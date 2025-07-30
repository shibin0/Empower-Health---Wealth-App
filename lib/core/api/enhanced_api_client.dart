import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../storage/enhanced_storage_service.dart';
import 'api_client.dart'; // Import existing API response classes

part 'enhanced_api_client.g.dart';

/// Circuit breaker state management
class CircuitBreakerState {
  int failureCount = 0;
  DateTime? lastFailureTime;
  bool get isOpen => failureCount >= 5 && 
    (lastFailureTime != null && 
     DateTime.now().difference(lastFailureTime!).inMinutes < 5);

  void recordSuccess() {
    failureCount = 0;
    lastFailureTime = null;
  }

  void recordFailure() {
    failureCount++;
    lastFailureTime = DateTime.now();
  }
}

/// Cache entry for API responses
class CacheEntry {
  final dynamic data;
  final DateTime timestamp;
  final Duration? ttl;

  CacheEntry({
    required this.data,
    required this.timestamp,
    this.ttl,
  });

  bool get isExpired {
    if (ttl == null) return false;
    return DateTime.now().difference(timestamp) > ttl!;
  }
}

/// Enhanced API client with advanced features
@riverpod
class EnhancedApiClient extends _$EnhancedApiClient {
  late final Dio _dio;
  final Map<String, CacheEntry> _cache = {};
  
  // Rate limiting
  final Map<String, List<DateTime>> _requestHistory = {};
  final int _maxRequestsPerMinute = 60;
  
  // Circuit breaker
  final Map<String, CircuitBreakerState> _circuitBreakers = {};
  
  // WebSocket connections
  final Map<String, WebSocketChannel> _webSockets = {};
  final Map<String, StreamController> _webSocketControllers = {};

  @override
  Future<EnhancedApiClient> build() async {
    _initializeDio();
    return this;
  }

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: "https://api.empowerapp.com/v1",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    _dio.interceptors.addAll([
      _createAuthInterceptor(),
      _createRetryInterceptor(),
      _createLoggingInterceptor(),
      _createRateLimitInterceptor(),
      _createCircuitBreakerInterceptor(),
    ]);
  }

  /// Authentication interceptor
  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          final storageService = ref.read(enhancedStorageServiceProvider.notifier);
          final cachedData = storageService.getCachedData('auth_token');
          final token = cachedData?['token'];
          
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (e) {
          debugPrint('Auth interceptor error: $e');
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token expired, try to refresh
          final refreshed = await _refreshToken();
          if (refreshed) {
            // Retry the original request
            try {
              final clonedRequest = await _dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              handler.resolve(clonedRequest);
              return;
            } catch (e) {
              debugPrint('Retry request failed: $e');
            }
          }
        }
        handler.next(error);
      },
    );
  }

  /// Retry interceptor with exponential backoff
  Interceptor _createRetryInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        final shouldRetry = _shouldRetryRequest(error);
        if (shouldRetry) {
          final retryCount = error.requestOptions.extra['retryCount'] ?? 0;
          if (retryCount < 3) {
            // Exponential backoff: 1s, 2s, 4s
            final delay = Duration(seconds: (1 << retryCount));
            await Future.delayed(delay);
            
            error.requestOptions.extra['retryCount'] = retryCount + 1;
            
            try {
              final clonedRequest = await _dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              handler.resolve(clonedRequest);
              return;
            } catch (e) {
              debugPrint('Retry failed: $e');
            }
          }
        }
        handler.next(error);
      },
    );
  }

  /// Logging interceptor
  Interceptor _createLoggingInterceptor() {
    return LogInterceptor(
      requestBody: kDebugMode,
      responseBody: kDebugMode,
      error: true,
      logPrint: (object) {
        if (kDebugMode) {
          debugPrint('[Enhanced API] $object');
        }
        _logApiCall(object.toString());
      },
    );
  }

  /// Rate limiting interceptor
  Interceptor _createRateLimitInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final endpoint = '${options.method}:${options.path}';
        final now = DateTime.now();
        
        _requestHistory[endpoint] ??= [];
        final requests = _requestHistory[endpoint]!;
        
        // Remove requests older than 1 minute
        requests.removeWhere(
          (time) => now.difference(time).inMinutes >= 1,
        );
        
        if (requests.length >= _maxRequestsPerMinute) {
          handler.reject(
            DioException(
              requestOptions: options,
              error: 'Rate limit exceeded for $endpoint',
              type: DioExceptionType.unknown,
            ),
          );
          return;
        }
        
        requests.add(now);
        handler.next(options);
      },
    );
  }

  /// Circuit breaker interceptor
  Interceptor _createCircuitBreakerInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final endpoint = '${options.method}:${options.path}';
        final circuitBreaker = _circuitBreakers[endpoint];
        
        if (circuitBreaker != null && circuitBreaker.isOpen) {
          handler.reject(
            DioException(
              requestOptions: options,
              error: 'Circuit breaker is open for $endpoint',
              type: DioExceptionType.unknown,
            ),
          );
          return;
        }
        
        handler.next(options);
      },
      onResponse: (response, handler) {
        final endpoint = '${response.requestOptions.method}:${response.requestOptions.path}';
        _updateCircuitBreaker(endpoint, true);
        handler.next(response);
      },
      onError: (error, handler) {
        final endpoint = '${error.requestOptions.method}:${error.requestOptions.path}';
        _updateCircuitBreaker(endpoint, false);
        handler.next(error);
      },
    );
  }

  /// Update circuit breaker state
  void _updateCircuitBreaker(String endpoint, bool success) {
    _circuitBreakers[endpoint] ??= CircuitBreakerState();
    final circuitBreaker = _circuitBreakers[endpoint]!;
    
    if (success) {
      circuitBreaker.recordSuccess();
    } else {
      circuitBreaker.recordFailure();
    }
  }

  /// Check if request should be retried
  bool _shouldRetryRequest(DioException error) {
    // Retry on network errors, timeouts, and 5xx server errors
    return error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.receiveTimeout ||
           error.type == DioExceptionType.sendTimeout ||
           error.type == DioExceptionType.connectionError ||
           (error.response?.statusCode != null && 
            error.response!.statusCode! >= 500);
  }

  /// Refresh authentication token
  Future<bool> _refreshToken() async {
    try {
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      final refreshTokenData = storageService.getCachedData('refresh_token');
      final refreshToken = refreshTokenData?['token'];
      
      if (refreshToken == null) return false;

      final response = await _dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
        options: Options(
          headers: {'Authorization': null}, // Remove auth header for refresh
        ),
      );

      if (response.statusCode == 200) {
        final newToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];
        
        await storageService.cacheData(
          'auth_token',
          {'token': newToken},
          ttl: const Duration(hours: 1),
        );
        await storageService.cacheData(
          'refresh_token',
          {'token': newRefreshToken},
          ttl: const Duration(days: 30),
        );
        
        return true;
      }
    } catch (e) {
      debugPrint('Token refresh failed: $e');
    }
    
    return false;
  }

  /// Log API call for monitoring
  void _logApiCall(String logMessage) {
    try {
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      if (!kDebugMode) {
        storageService.cacheData(
          'api_logs_${DateTime.now().millisecondsSinceEpoch}',
          {'log': logMessage, 'timestamp': DateTime.now().toIso8601String()},
          ttl: const Duration(days: 7),
        );
      }
    } catch (e) {
      debugPrint('Logging failed: $e');
    }
  }

  // Cache Management
  
  /// Cache response data
  void _cacheResponse(String key, dynamic data, {Duration? ttl}) {
    _cache[key] = CacheEntry(
      data: data,
      timestamp: DateTime.now(),
      ttl: ttl,
    );
  }

  /// Get cached response
  dynamic _getCachedResponse(String key) {
    final entry = _cache[key];
    if (entry != null && !entry.isExpired) {
      return entry.data;
    }
    if (entry != null && entry.isExpired) {
      _cache.remove(key);
    }
    return null;
  }

  /// Clear expired cache entries
  void _clearExpiredCache() {
    final expiredKeys = _cache.entries
        .where((entry) => entry.value.isExpired)
        .map((entry) => entry.key)
        .toList();
    
    for (final key in expiredKeys) {
      _cache.remove(key);
    }
  }

  /// Generate cache key
  String _generateCacheKey(String method, String path, Map<String, dynamic>? params) {
    final paramsStr = params != null ? jsonEncode(params) : '';
    return '$method:$path:$paramsStr';
  }

  /// Handle API call with error handling
  Future<ApiResponse<T>> _handleApiCall<T>(Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return ApiResponse.success(result);
    } on DioException catch (e) {
      return _handleDioException<T>(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }

  /// Handle Dio exceptions
  ApiResponse<T> _handleDioException<T>(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ApiResponse.error('Connection timeout', statusCode: e.response?.statusCode);
      case DioExceptionType.sendTimeout:
        return ApiResponse.error('Send timeout', statusCode: e.response?.statusCode);
      case DioExceptionType.receiveTimeout:
        return ApiResponse.error('Receive timeout', statusCode: e.response?.statusCode);
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Server error';
        return ApiResponse.error(message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return ApiResponse.error('Request cancelled');
      case DioExceptionType.connectionError:
        return ApiResponse.error('Connection error. Please check your internet connection.');
      case DioExceptionType.badCertificate:
        return ApiResponse.error('Certificate error');
      case DioExceptionType.unknown:
        return ApiResponse.error('Unknown error: ${e.message}');
    }
  }

  // WebSocket Management
  
  /// Connect to WebSocket
  Future<Stream<dynamic>> connectWebSocket(String endpoint, {Map<String, String>? headers}) async {
    final wsUrl = _dio.options.baseUrl.replaceFirst('http', 'ws') ?? '';
    final fullUrl = '$wsUrl$endpoint';
    
    final channel = WebSocketChannel.connect(
      Uri.parse(fullUrl),
      protocols: headers != null ? [jsonEncode(headers)] : null,
    );
    
    _webSockets[endpoint] = channel;
    
    final controller = StreamController<dynamic>.broadcast();
    _webSocketControllers[endpoint] = controller;
    
    channel.stream.listen(
      (data) {
        try {
          final decoded = jsonDecode(data);
          controller.add(decoded);
        } catch (e) {
          controller.add(data);
        }
      },
      onError: (error) {
        controller.addError(error);
      },
      onDone: () {
        controller.close();
        _webSockets.remove(endpoint);
        _webSocketControllers.remove(endpoint);
      },
    );
    
    return controller.stream;
  }

  /// Send data through WebSocket
  void sendWebSocketMessage(String endpoint, dynamic message) {
    final channel = _webSockets[endpoint];
    if (channel != null) {
      final data = message is String ? message : jsonEncode(message);
      channel.sink.add(data);
    }
  }

  /// Close WebSocket connection
  void closeWebSocket(String endpoint) {
    final channel = _webSockets[endpoint];
    final controller = _webSocketControllers[endpoint];
    
    channel?.sink.close();
    controller?.close();
    
    _webSockets.remove(endpoint);
    _webSocketControllers.remove(endpoint);
  }

  /// Close all WebSocket connections
  void closeAllWebSockets() {
    for (final endpoint in _webSockets.keys.toList()) {
      closeWebSocket(endpoint);
    }
  }

  // Enhanced API Methods with caching and error handling

  /// GET request with caching
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    Duration? cacheTtl,
    bool forceRefresh = false,
  }) async {
    return _handleApiCall<T>(() async {
      final cacheKey = _generateCacheKey('GET', path, queryParameters);
      
      // Check cache first (unless force refresh)
      if (!forceRefresh && cacheTtl != null) {
        final cachedData = _getCachedResponse(cacheKey);
        if (cachedData != null) {
          return cachedData as T;
        }
      }
      
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      
      // Cache the response
      if (cacheTtl != null && response.data != null) {
        _cacheResponse(cacheKey, response.data, ttl: cacheTtl);
      }
      
      return response.data as T;
    });
  }

  /// POST request
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _handleApiCall<T>(() async {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data as T;
    });
  }

  /// PUT request
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _handleApiCall<T>(() async {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data as T;
    });
  }

  /// DELETE request
  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _handleApiCall<T>(() async {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data as T;
    });
  }

  // Utility Methods

  /// Clear all caches
  void clearAllCaches() {
    _cache.clear();
    _clearExpiredCache();
  }

  /// Get API statistics
  Map<String, dynamic> getApiStatistics() {
    return {
      'cache_size': _cache.length,
      'circuit_breakers': _circuitBreakers.length,
      'active_websockets': _webSockets.length,
      'request_history_endpoints': _requestHistory.length,
    };
  }

  /// Dispose resources
  void dispose() {
    closeAllWebSockets();
    _cache.clear();
    _requestHistory.clear();
    _circuitBreakers.clear();
  }
}