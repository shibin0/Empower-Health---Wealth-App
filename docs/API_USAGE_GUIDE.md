# API Usage Guide

## Quick Start

This guide provides practical examples and step-by-step instructions for using the enhanced API architecture in the Empower Health & Wealth App.

## Table of Contents

1. [Setup and Configuration](#setup-and-configuration)
2. [Basic API Operations](#basic-api-operations)
3. [Health Data Integration](#health-data-integration)
4. [Financial Data Integration](#financial-data-integration)
5. [Real-time Data Handling](#real-time-data-handling)
6. [Error Handling Patterns](#error-handling-patterns)
7. [Performance Optimization](#performance-optimization)
8. [Testing Your Integration](#testing-your-integration)

## Setup and Configuration

### 1. Initialize API Services

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:empower_app/core/api/enhanced_api_client.dart';
import 'package:empower_app/core/api/auth_token_service.dart';
import 'package:empower_app/core/api/rate_limiter_service.dart';
import 'package:empower_app/core/api/api_analytics_service.dart';

class ApiSetup {
  static Future<void> initialize() async {
    // Initialize core services
    final container = ProviderContainer();
    
    // Configure API client
    final apiClient = container.read(enhancedApiClientProvider);
    await apiClient.initialize();
    
    // Setup authentication
    final authService = container.read(authTokenServiceProvider);
    await authService.initialize();
    
    // Configure rate limiting
    final rateLimiter = container.read(rateLimiterServiceProvider);
    await _configureRateLimits(rateLimiter);
    
    // Start analytics
    final analytics = container.read(apiAnalyticsServiceProvider);
    // Analytics starts automatically
  }
  
  static Future<void> _configureRateLimits(RateLimiterService rateLimiter) async {
    // Health API rate limits
    await rateLimiter.configureRateLimit(
      'health_api',
      RateLimitConfig(
        strategy: RateLimitStrategy.tokenBucket,
        maxRequests: 60,
        windowDuration: Duration(minutes: 1),
        burstCapacity: 10,
      ),
    );
    
    // Financial API rate limits
    await rateLimiter.configureRateLimit(
      'financial_api',
      RateLimitConfig(
        strategy: RateLimitStrategy.slidingWindow,
        maxRequests: 100,
        windowDuration: Duration(minutes: 1),
      ),
    );
    
    // General API rate limits
    await rateLimiter.configureRateLimit(
      'general_api',
      RateLimitConfig(
        strategy: RateLimitStrategy.tokenBucket,
        maxRequests: 200,
        windowDuration: Duration(minutes: 1),
        burstCapacity: 20,
      ),
    );
  }
}
```

### 2. Configure Authentication

```dart
class AuthSetup {
  static Future<void> setupAuthentication(AuthTokenService authService) async {
    // Configure JWT authentication
    await authService.configureJWT(
      JWTConfig(
        loginEndpoint: '/auth/login',
        refreshEndpoint: '/auth/refresh',
        tokenField: 'access_token',
        refreshTokenField: 'refresh_token',
        expiryField: 'expires_in',
      ),
    );
    
    // Configure OAuth providers
    await authService.configureOAuth(
      'google',
      OAuthConfig(
        clientId: 'your_google_client_id',
        clientSecret: 'your_google_client_secret',
        scopes: ['openid', 'profile', 'email'],
        redirectUri: 'your_app://oauth/callback',
        pkceEnabled: true,
      ),
    );
    
    // Configure API keys for external services
    await authService.configureApiKey(
      'health_service',
      ApiKeyConfig(
        keyId: 'health_api_key',
        secretKey: 'your_health_api_secret',
        algorithm: 'HS256',
        validity: Duration(hours: 24),
        scopes: ['health:read', 'health:write'],
      ),
    );
  }
}
```

## Basic API Operations

### 1. Making HTTP Requests

```dart
class UserService {
  final EnhancedApiClient _apiClient;
  final ApiAnalyticsService _analytics;
  
  UserService(this._apiClient, this._analytics);
  
  // GET request with caching
  Future<UserProfile> getUserProfile(String userId) async {
    final requestId = _analytics.logRequestStart(
      endpoint: '/api/users/$userId',
      method: 'GET',
      userId: userId,
    );
    
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        '/api/users/$userId',
        options: RequestOptions(
          cacheConfig: CacheConfig(
            ttl: Duration(hours: 1),
            staleWhileRevalidate: true,
          ),
        ),
      );
      
      _analytics.logRequestComplete(
        requestId: requestId,
        statusCode: response.statusCode ?? 200,
        responseTime: response.responseTime,
      );
      
      return UserProfile.fromJson(response.data!);
    } catch (e) {
      _analytics.logRequestError(
        requestId: requestId,
        errorMessage: e.toString(),
        errorType: e.runtimeType.toString(),
      );
      rethrow;
    }
  }
  
  // POST request with validation
  Future<UserProfile> updateUserProfile(String userId, UserProfile profile) async {
    final requestId = _analytics.logRequestStart(
      endpoint: '/api/users/$userId',
      method: 'PUT',
      userId: userId,
    );
    
    try {
      final response = await _apiClient.put<Map<String, dynamic>>(
        '/api/users/$userId',
        data: profile.toJson(),
        options: RequestOptions(
          validateResponse: true,
          retryConfig: RetryConfig(
            maxAttempts: 3,
            retryCondition: (error) => error is NetworkException,
          ),
        ),
      );
      
      _analytics.logRequestComplete(
        requestId: requestId,
        statusCode: response.statusCode ?? 200,
        responseTime: response.responseTime,
      );
      
      return UserProfile.fromJson(response.data!);
    } catch (e) {
      _analytics.logRequestError(
        requestId: requestId,
        errorMessage: e.toString(),
        errorType: e.runtimeType.toString(),
      );
      rethrow;
    }
  }
  
  // Batch requests
  Future<Map<String, dynamic>> getUserDashboardData(String userId) async {
    final batchRequest = BatchRequest([
      ApiRequest.get('/api/users/$userId/profile'),
      ApiRequest.get('/api/users/$userId/health-summary'),
      ApiRequest.get('/api/users/$userId/financial-summary'),
      ApiRequest.get('/api/users/$userId/achievements'),
    ]);
    
    final responses = await _apiClient.executeBatch(batchRequest);
    
    return {
      'profile': responses[0].data,
      'health': responses[1].data,
      'financial': responses[2].data,
      'achievements': responses[3].data,
    };
  }
}
```

### 2. File Upload and Download

```dart
class FileService {
  final EnhancedApiClient _apiClient;
  
  FileService(this._apiClient);
  
  // Upload profile picture
  Future<String> uploadProfilePicture(String userId, File imageFile) async {
    final response = await _apiClient.upload(
      '/api/users/$userId/profile-picture',
      imageFile,
      options: UploadOptions(
        fieldName: 'profile_picture',
        additionalFields: {
          'user_id': userId,
          'image_type': 'profile',
        },
        onProgress: (sent, total) {
          print('Upload progress: ${(sent / total * 100).toStringAsFixed(1)}%');
        },
      ),
    );
    
    return response.data['image_url'];
  }
  
  // Download health report
  Future<void> downloadHealthReport(String userId, String reportId) async {
    final savePath = '/path/to/downloads/health_report_$reportId.pdf';
    
    await _apiClient.download(
      '/api/users/$userId/reports/$reportId/download',
      savePath,
      options: DownloadOptions(
        onProgress: (received, total) {
          if (total != -1) {
            print('Download progress: ${(received / total * 100).toStringAsFixed(1)}%');
          }
        },
      ),
    );
  }
}
```

## Health Data Integration

### 1. HealthKit Integration

```dart
class HealthKitIntegration {
  final HealthApiService _healthService;
  
  HealthKitIntegration(this._healthService);
  
  // Setup HealthKit permissions
  Future<void> setupHealthKit() async {
    await _healthService.configureHealthSync(
      HealthSyncConfig(
        sources: [HealthDataSource.healthKit],
        dataTypes: [
          HealthMetricType.steps,
          HealthMetricType.heartRate,
          HealthMetricType.sleep,
          HealthMetricType.weight,
          HealthMetricType.bloodPressure,
          HealthMetricType.bloodGlucose,
        ],
        syncFrequency: SyncFrequency.realTime,
        conflictResolution: ConflictResolutionStrategy.mostRecent,
        permissions: HealthPermissions(
          read: [
            'HKQuantityTypeIdentifierStepCount',
            'HKQuantityTypeIdentifierHeartRate',
            'HKCategoryTypeIdentifierSleepAnalysis',
          ],
          write: [
            'HKQuantityTypeIdentifierStepCount',
          ],
        ),
      ),
    );
  }
  
  // Sync recent health data
  Future<List<HealthData>> syncRecentHealthData() async {
    final result = await _healthService.syncHealthData(
      source: HealthDataSource.healthKit,
      dataTypes: [HealthMetricType.steps, HealthMetricType.heartRate],
      dateRange: DateRange(
        start: DateTime.now().subtract(Duration(days: 7)),
        end: DateTime.now(),
      ),
      options: SyncOptions(
        batchSize: 100,
        includeMetadata: true,
        validateData: true,
      ),
    );
    
    return result.syncedData;
  }
  
  // Real-time health monitoring
  void startRealTimeMonitoring() {
    _healthService.startRealTimeSync(
      dataTypes: [HealthMetricType.heartRate, HealthMetricType.steps],
      onDataReceived: (healthData) {
        print('New health data: ${healthData.type} = ${healthData.value}');
        _processHealthData(healthData);
      },
      onError: (error) {
        print('Health sync error: $error');
      },
    );
  }
  
  void _processHealthData(HealthData data) {
    // Process incoming health data
    switch (data.type) {
      case HealthMetricType.heartRate:
        _checkHeartRateAlerts(data);
        break;
      case HealthMetricType.steps:
        _updateStepGoals(data);
        break;
      default:
        break;
    }
  }
  
  void _checkHeartRateAlerts(HealthData heartRateData) {
    final heartRate = heartRateData.value;
    if (heartRate > 100 || heartRate < 60) {
      // Trigger alert
      print('Heart rate alert: $heartRate BPM');
    }
  }
  
  void _updateStepGoals(HealthData stepsData) {
    final steps = stepsData.value;
    final dailyGoal = 10000;
    final progress = (steps / dailyGoal * 100).clamp(0, 100);
    print('Step progress: ${progress.toStringAsFixed(1)}%');
  }
}
```

### 2. Google Fit Integration

```dart
class GoogleFitIntegration {
  final HealthApiService _healthService;
  
  GoogleFitIntegration(this._healthService);
  
  // Setup Google Fit
  Future<void> setupGoogleFit() async {
    await _healthService.configureHealthSync(
      HealthSyncConfig(
        sources: [HealthDataSource.googleFit],
        dataTypes: [
          HealthMetricType.steps,
          HealthMetricType.calories,
          HealthMetricType.distance,
          HealthMetricType.activeMinutes,
        ],
        syncFrequency: SyncFrequency.hourly,
        conflictResolution: ConflictResolutionStrategy.merge,
        credentials: GoogleFitCredentials(
          clientId: 'your_google_fit_client_id',
          scopes: [
            'https://www.googleapis.com/auth/fitness.activity.read',
            'https://www.googleapis.com/auth/fitness.body.read',
          ],
        ),
      ),
    );
  }
  
  // Sync fitness activities
  Future<List<WorkoutSession>> syncWorkoutSessions() async {
    final result = await _healthService.syncWorkoutSessions(
      source: HealthDataSource.googleFit,
      dateRange: DateRange.lastWeek(),
      options: WorkoutSyncOptions(
        includeGpsData: true,
        includeHeartRateZones: true,
        minDuration: Duration(minutes: 5),
      ),
    );
    
    return result.workoutSessions;
  }
}
```

## Financial Data Integration

### 1. Open Banking Integration

```dart
class OpenBankingIntegration {
  final FinancialApiService _financialService;
  
  OpenBankingIntegration(this._financialService);
  
  // Connect bank account
  Future<BankAccount> connectBankAccount(String bankProvider) async {
    final connectionConfig = BankConnectionConfig(
      provider: bankProvider,
      authMethod: BankAuthMethod.oauth,
      scopes: [
        'accounts:read',
        'transactions:read',
        'balances:read',
      ],
      redirectUri: 'your_app://banking/callback',
    );
    
    final result = await _financialService.connectBankAccount(connectionConfig);
    return result.account;
  }
  
  // Sync transactions
  Future<List<Transaction>> syncTransactions(String accountId) async {
    final result = await _financialService.syncTransactions(
      accountId: accountId,
      dateRange: DateRange.lastMonth(),
      options: TransactionSyncOptions(
        categorizeTransactions: true,
        includePendingTransactions: false,
        batchSize: 200,
      ),
    );
    
    return result.transactions;
  }
  
  // Get account balances
  Future<List<AccountBalance>> getAccountBalances(List<String> accountIds) async {
    final balances = <AccountBalance>[];
    
    for (final accountId in accountIds) {
      final balance = await _financialService.getAccountBalance(accountId);
      balances.add(balance);
    }
    
    return balances;
  }
  
  // Analyze spending patterns
  Future<SpendingAnalysis> analyzeSpending(String accountId) async {
    final transactions = await syncTransactions(accountId);
    
    final analysis =
 await _financialService.analyzeSpending(
      accountId: accountId,
      dateRange: DateRange.lastMonth(),
      analysisOptions: SpendingAnalysisOptions(
        groupByCategory: true,
        includeProjections: true,
        detectAnomalies: true,
      ),
    );
    
    return analysis;
  }
}
```

### 2. Investment Platform Integration

```dart
class InvestmentIntegration {
  final FinancialApiService _financialService;
  
  InvestmentIntegration(this._financialService);
  
  // Connect investment account
  Future<InvestmentAccount> connectInvestmentAccount(String provider) async {
    final connectionConfig = InvestmentConnectionConfig(
      provider: provider,
      authMethod: InvestmentAuthMethod.apiKey,
      credentials: {
        'api_key': 'your_investment_api_key',
        'secret_key': 'your_investment_secret_key',
      },
      permissions: [
        'portfolio:read',
        'positions:read',
        'orders:read',
      ],
    );
    
    final result = await _financialService.connectInvestmentAccount(connectionConfig);
    return result.account;
  }
  
  // Sync portfolio data
  Future<Portfolio> syncPortfolio(String accountId) async {
    final result = await _financialService.syncPortfolio(
      accountId: accountId,
      options: PortfolioSyncOptions(
        includeHistoricalData: true,
        includeDividends: true,
        includeOptions: false,
        priceDataRange: DateRange.lastYear(),
      ),
    );
    
    return result.portfolio;
  }
  
  // Get real-time market data
  Future<List<MarketData>> getMarketData(List<String> symbols) async {
    final marketData = await _financialService.getMarketData(
      symbols: symbols,
      options: MarketDataOptions(
        includeExtendedHours: true,
        includeVolume: true,
        includeTechnicalIndicators: true,
      ),
    );
    
    return marketData;
  }
}
```

## Real-time Data Handling

### 1. WebSocket Connection Management

```dart
class RealtimeDataManager {
  final RealtimeDataService _realtimeService;
  final StreamController<Map<String, dynamic>> _dataController;
  
  RealtimeDataManager(this._realtimeService) 
      : _dataController = StreamController<Map<String, dynamic>>.broadcast();
  
  Stream<Map<String, dynamic>> get dataStream => _dataController.stream;
  
  // Connect to real-time services
  Future<void> connect() async {
    await _realtimeService.connect('wss://api.example.com/ws');
    
    // Subscribe to different data channels
    _subscribeToHealthUpdates();
    _subscribeToFinancialUpdates();
    _subscribeToMarketData();
    _subscribeToSyncStatus();
  }
  
  void _subscribeToHealthUpdates() {
    _realtimeService.subscribeToHealthUpdates((data) {
      _dataController.add({
        'type': 'health_update',
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
      });
    });
  }
  
  void _subscribeToFinancialUpdates() {
    _realtimeService.subscribeToFinancialUpdates((data) {
      _dataController.add({
        'type': 'financial_update',
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
      });
    });
  }
  
  void _subscribeToMarketData() {
    _realtimeService.subscribeToMarketUpdates((data) {
      _dataController.add({
        'type': 'market_update',
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
      });
    });
  }
  
  void _subscribeToSyncStatus() {
    _realtimeService.subscribeToSyncStatus((status) {
      _dataController.add({
        'type': 'sync_status',
        'data': status,
        'timestamp': DateTime.now().toIso8601String(),
      });
    });
  }
  
  // Send real-time updates
  Future<void> sendHealthUpdate(HealthData healthData) async {
    await _realtimeService.sendHealthUpdate(healthData.toJson());
  }
  
  Future<void> sendFinancialUpdate(FinancialData financialData) async {
    await _realtimeService.sendFinancialUpdate(financialData.toJson());
  }
  
  // Disconnect and cleanup
  Future<void> disconnect() async {
    await _dataController.close();
    await _realtimeService.disconnect();
  }
}
```

### 2. Real-time UI Updates

```dart
class RealtimeUIController extends StateNotifier<RealtimeState> {
  final RealtimeDataManager _dataManager;
  late StreamSubscription _dataSubscription;
  
  RealtimeUIController(this._dataManager) : super(RealtimeState.initial()) {
    _initializeRealTimeUpdates();
  }
  
  void _initializeRealTimeUpdates() {
    _dataSubscription = _dataManager.dataStream.listen(
      (data) => _handleRealtimeData(data),
      onError: (error) => _handleRealtimeError(error),
    );
  }
  
  void _handleRealtimeData(Map<String, dynamic> data) {
    final type = data['type'] as String;
    final payload = data['data'];
    
    switch (type) {
      case 'health_update':
        _updateHealthData(payload);
        break;
      case 'financial_update':
        _updateFinancialData(payload);
        break;
      case 'market_update':
        _updateMarketData(payload);
        break;
      case 'sync_status':
        _updateSyncStatus(payload);
        break;
    }
  }
  
  void _updateHealthData(Map<String, dynamic> healthData) {
    state = state.copyWith(
      lastHealthUpdate: DateTime.now(),
      healthData: HealthData.fromJson(healthData),
    );
  }
  
  void _updateFinancialData(Map<String, dynamic> financialData) {
    state = state.copyWith(
      lastFinancialUpdate: DateTime.now(),
      financialData: FinancialData.fromJson(financialData),
    );
  }
  
  void _updateMarketData(Map<String, dynamic> marketData) {
    state = state.copyWith(
      lastMarketUpdate: DateTime.now(),
      marketData: MarketData.fromJson(marketData),
    );
  }
  
  void _updateSyncStatus(Map<String, dynamic> syncStatus) {
    state = state.copyWith(
      syncStatus: SyncStatus.fromJson(syncStatus),
    );
  }
  
  void _handleRealtimeError(dynamic error) {
    state = state.copyWith(
      error: error.toString(),
      connectionStatus: ConnectionStatus.error,
    );
  }
  
  @override
  void dispose() {
    _dataSubscription.cancel();
    super.dispose();
  }
}
```

## Error Handling Patterns

### 1. Comprehensive Error Handling

```dart
class ApiErrorHandler {
  static Future<T> handleApiCall<T>(
    Future<T> Function() apiCall, {
    String? operation,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
  }) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      try {
        return await apiCall();
      } on NetworkException catch (e) {
        attempts++;
        if (attempts >= maxRetries) {
          throw UserFriendlyException(
            'Network error: Please check your internet connection',
            originalError: e,
          );
        }
        await Future.delayed(retryDelay * attempts);
      } on AuthenticationException catch (e) {
        // Try to refresh token once
        if (attempts == 0) {
          await _refreshAuthToken();
          attempts++;
          continue;
        }
        throw UserFriendlyException(
          'Authentication failed: Please log in again',
          originalError: e,
        );
      } on RateLimitException catch (e) {
        if (attempts >= maxRetries) {
          throw UserFriendlyException(
            'Too many requests: Please try again later',
            originalError: e,
          );
        }
        await Future.delayed(e.retryAfter ?? Duration(seconds: 60));
        attempts++;
      } on ValidationException catch (e) {
        throw UserFriendlyException(
          'Invalid data: ${e.message}',
          originalError: e,
        );
      } on ServerException catch (e) {
        if (e.statusCode >= 500) {
          attempts++;
          if (attempts >= maxRetries) {
            throw UserFriendlyException(
              'Server error: Please try again later',
              originalError: e,
            );
          }
          await Future.delayed(retryDelay * attempts);
        } else {
          throw UserFriendlyException(
            'Request failed: ${e.message}',
            originalError: e,
          );
        }
      } catch (e) {
        throw UserFriendlyException(
          'Unexpected error: Please try again',
          originalError: e,
        );
      }
    }
    
    throw UserFriendlyException('Maximum retry attempts exceeded');
  }
  
  static Future<void> _refreshAuthToken() async {
    // Implement token refresh logic
    final authService = GetIt.instance<AuthTokenService>();
    await authService.refreshToken();
  }
}
```

### 2. Error Recovery Strategies

```dart
class ErrorRecoveryService {
  final ApiAnalyticsService _analytics;
  final EnhancedStorageService _storage;
  
  ErrorRecoveryService(this._analytics, this._storage);
  
  // Implement circuit breaker pattern
  Future<T> withCircuitBreaker<T>(
    String operationId,
    Future<T> Function() operation,
  ) async {
    final circuitBreaker = CircuitBreaker(
      failureThreshold: 5,
      recoveryTimeout: Duration(minutes: 1),
      onStateChange: (state) {
        _analytics.logCircuitBreakerEvent(
          endpoint: operationId,
          method: 'CIRCUIT_BREAKER',
          state: state,
        );
      },
    );
    
    return await circuitBreaker.execute(operation);
  }
  
  // Implement fallback strategies
  Future<T> withFallback<T>(
    Future<T> Function() primaryOperation,
    Future<T> Function() fallbackOperation,
  ) async {
    try {
      return await primaryOperation();
    } catch (e) {
      print('Primary operation failed, using fallback: $e');
      return await fallbackOperation();
    }
  }
  
  // Cache-first strategy with network fallback
  Future<T> cacheFirstWithNetworkFallback<T>(
    String cacheKey,
    Future<T> Function() networkOperation,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    // Try cache first
    final cachedData = await _storage.getCachedData(cacheKey);
    if (cachedData != null) {
      try {
        return fromJson(cachedData);
      } catch (e) {
        print('Cache data corrupted, falling back to network: $e');
      }
    }
    
    // Fallback to network
    try {
      final result = await networkOperation();
      // Cache the result
      await _storage.cacheData(cacheKey, (result as dynamic).toJson());
      return result;
    } catch (e) {
      // If we have stale cache data, use it
      if (cachedData != null) {
        print('Network failed, using stale cache data');
        return fromJson(cachedData);
      }
      rethrow;
    }
  }
}
```

## Performance Optimization

### 1. Request Optimization

```dart
class RequestOptimizer {
  final EnhancedApiClient _apiClient;
  final Map<String, Timer> _debounceTimers = {};
  
  RequestOptimizer(this._apiClient);
  
  // Debounce rapid requests
  Future<T> debounceRequest<T>(
    String key,
    Future<T> Function() request,
    Duration delay,
  ) async {
    final completer = Completer<T>();
    
    _debounceTimers[key]?.cancel();
    _debounceTimers[key] = Timer(delay, () async {
      try {
        final result = await request();
        completer.complete(result);
      } catch (e) {
        completer.completeError(e);
      }
    });
    
    return completer.future;
  }
  
  // Batch similar requests
  Future<List<T>> batchRequests<T>(
    List<Future<T> Function()> requests,
    {int batchSize = 5}
  ) async {
    final results = <T>[];
    
    for (int i = 0; i < requests.length; i += batchSize) {
      final batch = requests.skip(i).take(batchSize);
      final batchResults = await Future.wait(
        batch.map((request) => request()),
      );
      results.addAll(batchResults);
    }
    
    return results;
  }
  
  // Request deduplication
  final Map<String, Future> _ongoingRequests = {};
  
  Future<T> deduplicateRequest<T>(
    String key,
    Future<T> Function() request,
  ) async {
    if (_ongoingRequests.containsKey(key)) {
      return await _ongoingRequests[key] as T;
    }
    
    final future = request();
    _ongoingRequests[key] = future;
    
    try {
      final result = await future;
      return result;
    } finally {
      _ongoingRequests.remove(key);
    }
  }
}
```

### 2. Caching Strategies

```dart
class CacheManager {
  final EnhancedStorageService _storage;
  final Map<String, CacheStrategy> _strategies = {};
  
  CacheManager(this._storage) {
    _initializeCacheStrategies();
  }
  
  void _initializeCacheStrategies() {
    // User profile - long cache
    _strategies['/api/user/profile'] = CacheStrategy(
      ttl: Duration(hours: 6),
      staleWhileRevalidate: true,
      maxAge: Duration(days: 1),
    );
    
    // Health data - medium cache
    _strategies['/api/health/data'] = CacheStrategy(
      ttl: Duration(minutes: 15),
      refreshInBackground: true,
      maxAge: Duration(hours: 2),
    );
    
    // Market data - short cache
    _strategies['/api/market/data'] = CacheStrategy(
      ttl: Duration(minutes: 1),
      refreshInBackground: true,
      maxAge: Duration(minutes: 5),
    );
    
    // Static data - very long cache
    _strategies['/api/static/'] = CacheStrategy(
      ttl: Duration(days: 7),
      staleWhileRevalidate: true,
      maxAge: Duration(days: 30),
    );
  }
  
  CacheStrategy? getStrategyForEndpoint(String endpoint) {
    for (final entry in _strategies.entries) {
      if (endpoint.startsWith(entry.key)) {
        return entry.value;
      }
    }
    return null;
  }
  
  // Smart cache invalidation
  Future<void> invalidateRelatedCache(String endpoint) async {
    final patterns = <String>[];
    
    if (endpoint.contains('/user/')) {
      patterns.addAll(['/api/user/', '/api/profile/']);
    }
    
    if (endpoint.contains('/health/')) {
      patterns.addAll(['/api/health/', '/api/wellness/']);
    }
    
    if (endpoint.contains('/financial/')) {
      patterns.addAll(['/api/financial/', '/api/portfolio/']);
    }
    
    for (final pattern in patterns) {
      await _storage.clearCache(); // Implement pattern-based clearing
    }
  }
}
```

## Testing Your Integration

### 1. Unit Testing API Services

```dart
// test/api/health_api_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:empower_app/core/integrations/health_api_service.dart';

class MockHealthApiService extends Mock implements HealthApiService {}

void main() {
  group('HealthApiService Tests', () {
    late MockHealthApiService mockHealthService;
    
    setUp(() {
      mockHealthService = MockHealthApiService();
    });
    
    test('should sync health data successfully', () async {
      // Arrange
      final expectedData = [
        HealthData(
          type: HealthMetricType.steps,
          value: 10000,
          timestamp: DateTime.now(),
          source: 'test',
        ),
      ];
      
      when(mockHealthService.syncHealthData(
        source: anyNamed('source'),
        dataTypes: anyNamed('dataTypes'),
        dateRange: anyNamed('dateRange'),
      )).thenAnswer((_) async => SyncResult(
        success: true,
        syncedData: expectedData,
        conflictsResolved: 0,
      ));
      
      // Act
      final result = await mockHealthService.syncHealthData(
        source: HealthDataSource.healthKit,
        dataTypes: [HealthMetricType.steps],
        dateRange: DateRange.lastWeek(),
      );
      
      // Assert
      expect(result.success, isTrue);
      expect(result.syncedData, hasLength(1));
      expect(result.syncedData.first.type, equals(HealthMetricType.steps));
    });
    
    test('should handle sync errors gracefully', () async {
      // Arrange
      when(mockHealthService.syncHealthData(
        source: anyNamed('source'),
        dataTypes: anyNamed('dataTypes'),
        dateRange: anyNamed('dateRange'),
      )).thenThrow(HealthSyncException('Sync failed'));
      
      // Act & Assert
      expect(
        () => mockHealthService.syncHealthData(
          source: HealthDataSource.healthKit,
          dataTypes: [HealthMetricType.steps],
          dateRange: DateRange.lastWeek(),
        ),
        throwsA(isA<HealthSyncException>()),
      );
    });
  });
}
```

### 2. Integration Testing

```dart
// test/integration/api_integration_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:empower_app/core/api/enhanced_api_client.dart';

void main() {
  group('API Integration Tests', () {
    late ProviderContainer container;
    
    setUp(() {
      container = ProviderContainer();
    });
    
    tearDown(() {
      container.dispose();
    });
    
    testWidgets('should initialize all API services', (tester) async {
      // Test that all API services can be initialized without errors
      expect(() => container.read(enhancedApiClientProvider), returnsNormally);
      expect(() => container.read(authTokenServiceProvider), returnsNormally);
      expect(() => container.read(rateLimiterServiceProvider), returnsNormally);
      expect(() => container.read(apiAnalyticsServiceProvider), returnsNormally);
    });
    
    testWidgets('should handle API request flow', (tester) async {
      final apiClient = container.read(enhancedApiClientProvider);
      
      // Test basic API request (this would need a test server)
      // expect(apiClient, isNotNull);
      // final response = await apiClient.get('/test/endpoint');
      // expect(response.statusCode, equals(200));
    });
  });
}
```

### 3. Performance Testing

```dart
// test/performance/api_performance_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:empower_app/core/api/enhanced_api_client.dart';

void main() {
  group('API Performance Tests', () {
    test('should handle concurrent requests efficiently', () async {
      final apiClient = EnhancedApiClient();
      final stopwatch = Stopwatch()..start();
      
      // Simulate concurrent requests
      final futures = List.generate(10, (index) => 
        apiClient.get('/test/endpoint/$index')
      );
      
      await Future.wait(futures);
      stopwatch.stop();
      
      // Assert reasonable performance
      expect(stopwatch.elapsedMilliseconds, lessThan(5000)); // 5 seconds max
    });
    
    test('should cache responses effectively', () async {
      final apiClient = EnhancedApiClient();
      
      // First request (should hit network)
      final stopwatch1 = Stopwatch()..start();
      await apiClient.get('/test/cacheable-endpoint');
      stopwatch1.stop();
      
      // Second request (should hit cache)
      final stopwatch2 = Stopwatch()..start();
      await apiClient.get('/test/cacheable-endpoint');
      stopwatch2.stop();
      
      // Cache should be significantly faster
      expect(stopwatch2.elapsedMilliseconds, lessThan(stopwatch1.elapsedMilliseconds ~/ 2));
    });
  });
}
```

### 4. End-to-End Testing

```dart
// test/e2e/health_sync_e2e_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:empower_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('Health Sync E2E Tests', () {
    testWidgets('complete health data sync workflow', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      // Navigate to health sync screen
      await tester.tap(find.text('Health'));
      await tester.pumpAndSettle();
      
      // Initiate sync
      await tester.tap(find.text('Sync Health Data'));
      await tester.pumpAndSettle();
      
      // Wait for sync to complete
      await tester.pump(Duration(seconds: 5));
      
      // Verify sync success
      expect(find.text('Sync completed'), findsOneWidget);
    });
  });
}
```

## Best Practices Summary

### 1. API Design Principles

- **Consistency**: Use consistent naming conventions and response formats
- **Versioning**: Implement proper API versioning strategies
- **Documentation**: Maintain up-to-date API documentation
- **Error Handling**: Provide meaningful error messages and codes
- **Security**: Implement proper authentication and authorization

### 2. Performance Guidelines

- **Caching**: Implement intelligent caching strategies
- **Batching**: Batch similar requests when possible
- **Pagination**: Use pagination for large data sets
- **Compression**: Enable response compression
- **Connection Pooling**: Reuse connections efficiently

### 3. Monitoring and Analytics

- **Metrics**: Track key performance indicators
- **Logging**: Implement comprehensive logging
- **Alerting**: Set up alerts for critical issues
- **Analytics**: Analyze usage patterns and performance
- **Health Checks**: Implement service health monitoring

### 4. Security Best Practices

- **Authentication**: Use secure authentication methods
- **Authorization**: Implement proper access controls
- **Encryption**: Encrypt sensitive data in transit and at rest
- **Validation**: Validate all input data
- **Rate Limiting**: Implement rate limiting to prevent abuse

## Troubleshooting Common Issues

### 1. Authentication Issues

```dart
// Check token expiration
if (authService.isTokenExpired()) {
  await authService.refreshToken();
}

// Verify token format
final token = await authService.getCurrentToken();
if (token == null || !token.isValid) {
  await authService.authenticate();
}
```

### 2. Network Issues

```dart
// Implement retry logic
final result = await ApiErrorHandler.handleApiCall(
  () => apiClient.get('/api/data'),
  maxRetries: 3,
  retryDelay: Duration(seconds: 2),
);
```

### 3. Cache Issues

```dart
// Clear cache if data seems stale
await cacheManager.invalidateRelatedCache('/api/user/');

// Force refresh from network
final data = await apiClient.get(
  '/api/data',
  options: RequestOptions(bypassCache: true),
);
```

### 4. Rate Limiting

```dart
// Check rate limit before making request
final canProceed = await rateLimiter.checkRateLimit('api_calls', userId);
if (!canProceed) {
  throw RateLimitException('Rate limit exceeded');
}
```

## Conclusion

This usage guide provides comprehensive examples and patterns for implementing the enhanced API architecture in the Empower Health & Wealth App. Follow these patterns and best practices to ensure robust, performant, and maintainable API integrations.

For more detailed information, refer to the [API Architecture Documentation](./API_ARCHITECTURE_DOCUMENTATION.md).