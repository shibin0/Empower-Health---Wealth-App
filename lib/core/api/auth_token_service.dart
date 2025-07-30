import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../storage/enhanced_storage_service.dart';

/// JWT token information
class TokenInfo {
  final String token;
  final String refreshToken;
  final DateTime expiresAt;
  final DateTime issuedAt;
  final Map<String, dynamic> claims;
  final String tokenType;

  const TokenInfo({
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
    required this.issuedAt,
    required this.claims,
    this.tokenType = 'Bearer',
  });

  /// Check if token is expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Check if token will expire soon (within 5 minutes)
  bool get willExpireSoon => 
      DateTime.now().add(const Duration(minutes: 5)).isAfter(expiresAt);

  /// Get remaining time until expiration
  Duration get timeUntilExpiry => expiresAt.difference(DateTime.now());

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'token': token,
    'refresh_token': refreshToken,
    'expires_at': expiresAt.toIso8601String(),
    'issued_at': issuedAt.toIso8601String(),
    'claims': claims,
    'token_type': tokenType,
  };

  /// Create from JSON
  factory TokenInfo.fromJson(Map<String, dynamic> json) => TokenInfo(
    token: json['token'],
    refreshToken: json['refresh_token'],
    expiresAt: DateTime.parse(json['expires_at']),
    issuedAt: DateTime.parse(json['issued_at']),
    claims: json['claims'] ?? {},
    tokenType: json['token_type'] ?? 'Bearer',
  );
}

/// Authentication result
class AuthResult {
  final bool success;
  final TokenInfo? tokenInfo;
  final String? error;
  final Map<String, dynamic> metadata;

  const AuthResult({
    required this.success,
    this.tokenInfo,
    this.error,
    this.metadata = const {},
  });

  const AuthResult.success(TokenInfo tokenInfo) : this(
    success: true,
    tokenInfo: tokenInfo,
  );

  const AuthResult.failure(String error, {Map<String, dynamic> metadata = const {}}) : this(
    success: false,
    error: error,
    metadata: metadata,
  );
}

/// Token refresh strategy
enum TokenRefreshStrategy {
  automatic,    // Refresh automatically when token expires soon
  onDemand,     // Refresh only when explicitly requested
  background,   // Refresh in background periodically
}

/// API key configuration
class ApiKeyConfig {
  final String keyId;
  final String secretKey;
  final String algorithm;
  final Duration validity;
  final List<String> scopes;

  const ApiKeyConfig({
    required this.keyId,
    required this.secretKey,
    this.algorithm = 'HS256',
    this.validity = const Duration(hours: 1),
    this.scopes = const [],
  });
}

/// OAuth configuration
class OAuthConfig {
  final String clientId;
  final String clientSecret;
  final String authorizationUrl;
  final String tokenUrl;
  final String redirectUri;
  final List<String> scopes;

  const OAuthConfig({
    required this.clientId,
    required this.clientSecret,
    required this.authorizationUrl,
    required this.tokenUrl,
    required this.redirectUri,
    this.scopes = const [],
  });
}

/// Enhanced authentication and token management service
class AuthTokenService {
  final Ref _ref;
  final Dio _dio;
  
  TokenInfo? _currentToken;
  Timer? _refreshTimer;
  Timer? _backgroundRefreshTimer;
  
  final Map<String, ApiKeyConfig> _apiKeys = {};
  final Map<String, OAuthConfig> _oauthConfigs = {};
  final Map<String, TokenInfo> _serviceTokens = {};
  
  TokenRefreshStrategy _refreshStrategy = TokenRefreshStrategy.automatic;
  bool _isRefreshing = false;
  final List<Completer<TokenInfo?>> _refreshCompleters = [];

  AuthTokenService(this._ref) : _dio = Dio() {
    _initializeService();
  }

  /// Initialize the authentication service
  void _initializeService() {
    _loadStoredTokens();
    _setupBackgroundRefresh();
    debugPrint('Auth token service initialized');
  }

  /// Load stored tokens from secure storage
  Future<void> _loadStoredTokens() async {
    try {
      final storageService = _ref.read(enhancedStorageServiceProvider.notifier);
      
      // Load main token
      final tokenData = storageService.getCachedData('auth_token');
      if (tokenData != null) {
        _currentToken = TokenInfo.fromJson(tokenData);
        if (_currentToken!.isExpired) {
          await _refreshTokenIfNeeded();
        }
      }

      // Load service tokens
      final serviceTokensData = storageService.getCachedData('service_tokens');
      if (serviceTokensData != null) {
        for (final entry in serviceTokensData.entries) {
          _serviceTokens[entry.key] = TokenInfo.fromJson(entry.value);
        }
      }

      // Load API keys
      final apiKeysData = storageService.getCachedData('api_keys');
      if (apiKeysData != null) {
        for (final entry in apiKeysData.entries) {
          _apiKeys[entry.key] = ApiKeyConfig(
            keyId: entry.value['key_id'],
            secretKey: entry.value['secret_key'],
            algorithm: entry.value['algorithm'] ?? 'HS256',
            validity: Duration(seconds: entry.value['validity_seconds'] ?? 3600),
            scopes: List<String>.from(entry.value['scopes'] ?? []),
          );
        }
      }
    } catch (e) {
      debugPrint('Failed to load stored tokens: $e');
    }
  }

  /// Setup background token refresh
  void _setupBackgroundRefresh() {
    _backgroundRefreshTimer?.cancel();
    _backgroundRefreshTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => _checkAndRefreshTokens(),
    );
  }

  /// Check and refresh tokens if needed
  Future<void> _checkAndRefreshTokens() async {
    if (_refreshStrategy == TokenRefreshStrategy.background) {
      await _refreshTokenIfNeeded();
      await _refreshServiceTokens();
    }
  }

  /// Refresh service tokens
  Future<void> _refreshServiceTokens() async {
    final expiredServices = <String>[];
    
    for (final entry in _serviceTokens.entries) {
      if (entry.value.willExpireSoon) {
        expiredServices.add(entry.key);
      }
    }
    
    for (final service in expiredServices) {
      try {
        // Try to refresh service token if it has a refresh token
        final token = _serviceTokens[service]!;
        if (token.refreshToken.isNotEmpty) {
          await _refreshServiceToken(service);
        } else {
          // Re-authenticate with API key if no refresh token
          final config = _apiKeys[service];
          if (config != null) {
            await authenticateWithApiKey(service: service);
          }
        }
      } catch (e) {
        debugPrint('Failed to refresh token for service $service: $e');
      }
    }
  }

  /// Refresh specific service token
  Future<void> _refreshServiceToken(String service) async {
    final token = _serviceTokens[service];
    if (token == null || token.refreshToken.isEmpty) return;

    try {
      final oauthConfig = _oauthConfigs[service];
      if (oauthConfig != null) {
        final response = await _dio.post(
          oauthConfig.tokenUrl,
          data: {
            'grant_type': 'refresh_token',
            'refresh_token': token.refreshToken,
            'client_id': oauthConfig.clientId,
            'client_secret': oauthConfig.clientSecret,
          },
        );

        if (response.statusCode == 200) {
          final newToken = _parseTokenResponse(response.data);
          await _storeServiceToken(service, newToken);
        }
      }
    } catch (e) {
      debugPrint('Failed to refresh service token for $service: $e');
    }
  }

  /// Authenticate with username and password
  Future<AuthResult> authenticateWithCredentials({
    required String username,
    required String password,
    String? baseUrl,
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final response = await _dio.post(
        '${baseUrl ?? "https://api.empowerapp.com"}/auth/login',
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            ...?additionalHeaders,
          },
        ),
      );

      if (response.statusCode == 200) {
        final tokenInfo = _parseTokenResponse(response.data);
        await _storeToken(tokenInfo);
        _currentToken = tokenInfo;
        _scheduleTokenRefresh();
        
        return AuthResult.success(tokenInfo);
      } else {
        return AuthResult.failure('Authentication failed: ${response.statusMessage}');
      }
    } catch (e) {
      return AuthResult.failure('Authentication error: $e');
    }
  }

  /// Authenticate with OAuth
  Future<AuthResult> authenticateWithOAuth({
    required String service,
    required String authorizationCode,
  }) async {
    final config = _oauthConfigs[service];
    if (config == null) {
      return AuthResult.failure('OAuth configuration not found for service: $service');
    }

    try {
      final response = await _dio.post(
        config.tokenUrl,
        data: {
          'grant_type': 'authorization_code',
          'client_id': config.clientId,
          'client_secret': config.clientSecret,
          'code': authorizationCode,
          'redirect_uri': config.redirectUri,
        },
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      if (response.statusCode == 200) {
        final tokenInfo = _parseTokenResponse(response.data);
        await _storeServiceToken(service, tokenInfo);
        
        return AuthResult.success(tokenInfo);
      } else {
        return AuthResult.failure('OAuth authentication failed: ${response.statusMessage}');
      }
    } catch (e) {
      return AuthResult.failure('OAuth error: $e');
    }
  }

  /// Authenticate with API key
  Future<AuthResult> authenticateWithApiKey({
    required String service,
    Map<String, String>? additionalClaims,
  }) async {
    final config = _apiKeys[service];
    if (config == null) {
      return AuthResult.failure('API key configuration not found for service: $service');
    }

    try {
      final token = _generateApiKeyToken(config, additionalClaims);
      final tokenInfo = TokenInfo(
        token: token,
        refreshToken: '', // API keys don't have refresh tokens
        expiresAt: DateTime.now().add(config.validity),
        issuedAt: DateTime.now(),
        claims: {
          'service': service,
          'scopes': config.scopes,
          ...?additionalClaims,
        },
        tokenType: 'ApiKey',
      );

      await _storeServiceToken(service, tokenInfo);
      return AuthResult.success(tokenInfo);
    } catch (e) {
      return AuthResult.failure('API key authentication error: $e');
    }
  }

  /// Generate API key token (simplified JWT-like token)
  String _generateApiKeyToken(ApiKeyConfig config, Map<String, String>? additionalClaims) {
    final header = {
      'alg': config.algorithm,
      'typ': 'JWT',
      'kid': config.keyId,
    };

    final payload = {
      'iss': 'empower-app',
      'sub': config.keyId,
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'exp': DateTime.now().add(config.validity).millisecondsSinceEpoch ~/ 1000,
      'scopes': config.scopes,
      ...?additionalClaims,
    };

    final headerEncoded = base64Url.encode(utf8.encode(jsonEncode(header)));
    final payloadEncoded = base64Url.encode(utf8.encode(jsonEncode(payload)));
    
    final message = '$headerEncoded.$payloadEncoded';
    final signature = _generateSignature(message, config.secretKey, config.algorithm);
    
    return '$message.$signature';
  }

  /// Generate signature for token
  String _generateSignature(String message, String secret, String algorithm) {
    switch (algorithm) {
      case 'HS256':
        final hmac = Hmac(sha256, utf8.encode(secret));
        final digest = hmac.convert(utf8.encode(message));
        return base64Url.encode(digest.bytes);
      default:
        throw UnsupportedError('Algorithm $algorithm not supported');
    }
  }

  /// Parse token response from server
  TokenInfo _parseTokenResponse(Map<String, dynamic> data) {
    final expiresIn = data['expires_in'] ?? 3600;
    final issuedAt = DateTime.now();
    final expiresAt = issuedAt.add(Duration(seconds: expiresIn));

    return TokenInfo(
      token: data['access_token'],
      refreshToken: data['refresh_token'] ?? '',
      expiresAt: expiresAt,
      issuedAt: issuedAt,
      claims: data['claims'] ?? {},
      tokenType: data['token_type'] ?? 'Bearer',
    );
  }

  /// Store token securely
  Future<void> _storeToken(TokenInfo tokenInfo) async {
    final storageService = _ref.read(enhancedStorageServiceProvider.notifier);
    await storageService.cacheData(
      'auth_token',
      tokenInfo.toJson(),
      ttl: tokenInfo.timeUntilExpiry,
    );
  }

  /// Store service-specific token
  Future<void> _storeServiceToken(String service, TokenInfo tokenInfo) async {
    _serviceTokens[service] = tokenInfo;
    
    final storageService = _ref.read(enhancedStorageServiceProvider.notifier);
    final serviceTokensData = <String, dynamic>{};
    for (final entry in _serviceTokens.entries) {
      serviceTokensData[entry.key] = entry.value.toJson();
    }
    
    await storageService.cacheData(
      'service_tokens',
      serviceTokensData,
      ttl: const Duration(days: 30),
    );
  }

  /// Schedule automatic token refresh
  void _scheduleTokenRefresh() {
    if (_refreshStrategy != TokenRefreshStrategy.automatic) return;
    
    _refreshTimer?.cancel();
    
    if (_currentToken != null && !_currentToken!.isExpired) {
      final refreshTime = _currentToken!.expiresAt.subtract(const Duration(minutes: 5));
      final delay = refreshTime.difference(DateTime.now());
      
      if (delay.isNegative) {
        // Token expires soon, refresh immediately
        _refreshTokenIfNeeded();
      } else {
        _refreshTimer = Timer(delay, () => _refreshTokenIfNeeded());
      }
    }
  }

  /// Refresh token if needed
  Future<TokenInfo?> _refreshTokenIfNeeded() async {
    if (_currentToken == null || !_currentToken!.willExpireSoon) {
      return _currentToken;
    }

    return await _refreshToken();
  }

  /// Refresh current token
  Future<TokenInfo?> _refreshToken() async {
    if (_isRefreshing) {
      // If already refreshing, wait for the current refresh to complete
      final completer = Completer<TokenInfo?>();
      _refreshCompleters.add(completer);
      return completer.future;
    }

    _isRefreshing = true;

    try {
      if (_currentToken?.refreshToken.isEmpty ?? true) {
        throw Exception('No refresh token available');
      }

      final response = await _dio.post(
        'https://api.empowerapp.com/auth/refresh',
        data: {
          'refresh_token': _currentToken!.refreshToken,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final newTokenInfo = _parseTokenResponse(response.data);
        await _storeToken(newTokenInfo);
        _currentToken = newTokenInfo;
        _scheduleTokenRefresh();

        // Complete all waiting refresh requests
        for (final completer in _refreshCompleters) {
          completer.complete(newTokenInfo);
        }
        _refreshCompleters.clear();

        debugPrint('Token refreshed successfully');
        return newTokenInfo;
      } else {
        throw Exception('Token refresh failed: ${response.statusMessage}');
      }
    } catch (e) {
      debugPrint('Token refresh error: $e');
      
      // Complete all waiting refresh requests with null
      for (final completer in _refreshCompleters) {
        completer.complete(null);
      }
      _refreshCompleters.clear();
      
      return null;
    } finally {
      _isRefreshing = false;
    }
  }

  /// Get current valid token
  Future<String?> getCurrentToken() async {
    if (_currentToken == null) return null;
    
    if (_currentToken!.isExpired) {
      await _refreshTokenIfNeeded();
    }
    
    return _currentToken?.token;
  }

  /// Get service token
  Future<String?> getServiceToken(String service) async {
    final token = _serviceTokens[service];
    if (token == null) return null;
    
    if (token.isExpired) {
      await _refreshServiceToken(service);
      return _serviceTokens[service]?.token;
    }
    
    return token.token;
  }

  /// Add API key configuration
  void addApiKeyConfig(String service, ApiKeyConfig config) {
    _apiKeys[service] = config;
    _storeApiKeyConfigs();
  }

  /// Add OAuth configuration
  void addOAuthConfig(String service, OAuthConfig config) {
    _oauthConfigs[service] = config;
  }

  /// Store API key configurations
  Future<void> _storeApiKeyConfigs() async {
    final storageService = _ref.read(enhancedStorageServiceProvider.notifier);
    final configsData = <String, dynamic>{};
    
    for (final entry in _apiKeys.entries) {
      configsData[entry.key] = {
        'key_id': entry.value.keyId,
        'secret_key': entry.value.secretKey,
        'algorithm': entry.value.algorithm,
        'validity_seconds': entry.value.validity.inSeconds,
        'scopes': entry.value.scopes,
      };
    }
    
    await storageService.cacheData(
      'api_keys',
      configsData,
      ttl: const Duration(days: 365),
    );
  }

  /// Set refresh strategy
  void setRefreshStrategy(TokenRefreshStrategy strategy) {
    _refreshStrategy = strategy;
    if (strategy == TokenRefreshStrategy.automatic) {
      _scheduleTokenRefresh();
    } else {
      _refreshTimer?.cancel();
    }
  }

  /// Logout and clear all tokens
  Future<void> logout() async {
    _currentToken = null;
    _serviceTokens.clear();
    _refreshTimer?.cancel();
    
    final storageService = _ref.read(enhancedStorageServiceProvider.notifier);
    await storageService.clearCache();
    
    debugPrint('Logged out and cleared all tokens');
  }

  /// Get authentication status
  Map<String, dynamic> getAuthStatus() {
    return {
      'is_authenticated': _currentToken != null && !_currentToken!.isExpired,
      'token_expires_at': _currentToken?.expiresAt.toIso8601String(),
      'time_until_expiry_minutes': _currentToken?.timeUntilExpiry.inMinutes,
      'refresh_strategy': _refreshStrategy.name,
      'service_tokens_count': _serviceTokens.length,
      'api_keys_count': _apiKeys.length,
      'oauth_configs_count': _oauthConfigs.length,
    };
  }

  /// Get token claims
  Map<String, dynamic>? getTokenClaims() {
    return _currentToken?.claims;
  }

  /// Check if user has specific scope
  bool hasScope(String scope) {
    final scopes = _currentToken?.claims['scopes'] as List<dynamic>?;
    return scopes?.contains(scope) ?? false;
  }

  /// Dispose resources
  void dispose() {
    _refreshTimer?.cancel();
    _backgroundRefreshTimer?.cancel();
    _dio.close();
  }
}

/// Provider for auth token service
final authTokenServiceProvider = Provider<AuthTokenService>((ref) {
  return AuthTokenService(ref);
});