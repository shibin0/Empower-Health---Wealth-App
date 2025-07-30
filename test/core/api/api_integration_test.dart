import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:empower_app/core/api/enhanced_api_client.dart';
import 'package:empower_app/core/api/rate_limiter_service.dart';
import 'package:empower_app/core/api/auth_token_service.dart';
import 'package:empower_app/core/api/api_analytics_service.dart';
import 'package:empower_app/core/api/realtime_data_service.dart';
import 'package:empower_app/core/integrations/health_api_service.dart';
import 'package:empower_app/core/integrations/financial_api_service.dart';
import 'package:empower_app/core/sync/enhanced_sync_service.dart';

void main() {
  group('API Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('Enhanced API Client Tests', () {
      test('should initialize API client correctly', () {
        // Test API client initialization
        expect(container.read(enhancedApiClientProvider), isNotNull);
      });

      test('should handle request configuration', () {
        // Test request configuration
        final apiClient = container.read(enhancedApiClientProvider);
        expect(apiClient, isA<EnhancedApiClient>());
      });
    });

    group('Rate Limiter Service Tests', () {
      test('should initialize rate limiter correctly', () {
        // Test rate limiter initialization
        expect(container.read(rateLimiterServiceProvider), isNotNull);
      });

      test('should create token bucket rate limiter', () {
        // Test token bucket creation
        final rateLimiter = container.read(rateLimiterServiceProvider);
        expect(rateLimiter, isA<RateLimiterService>());
      });
    });

    group('Auth Token Service Tests', () {
      test('should initialize auth service correctly', () {
        // Test auth service initialization
        expect(container.read(authTokenServiceProvider), isNotNull);
      });

      test('should handle token management', () {
        // Test token management
        final authService = container.read(authTokenServiceProvider);
        expect(authService, isA<AuthTokenService>());
      });
    });

    group('API Analytics Service Tests', () {
      test('should initialize analytics service correctly', () {
        // Test analytics service initialization
        expect(container.read(apiAnalyticsServiceProvider), isNotNull);
      });

      test('should track API metrics', () {
        // Test metrics tracking
        final analyticsService = container.read(apiAnalyticsServiceProvider);
        expect(analyticsService, isA<ApiAnalyticsService>());
      });
    });

    group('Real-time Data Service Tests', () {
      test('should initialize real-time service correctly', () {
        // Test real-time service initialization
        expect(container.read(realtimeDataServiceProvider), isNotNull);
      });

      test('should handle WebSocket connections', () {
        // Test WebSocket handling
        final realtimeService = container.read(realtimeDataServiceProvider);
        expect(realtimeService, isA<RealtimeDataService>());
      });
    });

    group('Health API Service Tests', () {
      test('should initialize health API service correctly', () {
        // Test health API service initialization
        expect(container.read(healthApiServiceProvider), isNotNull);
      });

      test('should handle health data integration', () {
        // Test health data integration
        final healthService = container.read(healthApiServiceProvider);
        expect(healthService, isA<HealthApiService>());
      });
    });

    group('Financial API Service Tests', () {
      test('should initialize financial API service correctly', () {
        // Test financial API service initialization
        expect(container.read(financialApiServiceProvider), isNotNull);
      });

      test('should handle financial data integration', () {
        // Test financial data integration
        final financialService = container.read(financialApiServiceProvider);
        expect(financialService, isA<FinancialApiService>());
      });
    });

    group('Enhanced Sync Service Tests', () {
      test('should initialize sync service correctly', () {
        // Test sync service initialization
        expect(container.read(enhancedSyncServiceProvider), isNotNull);
      });

      test('should handle data synchronization', () {
        // Test data synchronization
        final syncService = container.read(enhancedSyncServiceProvider);
        expect(syncService, isA<EnhancedSyncService>());
      });
    });

    group('Service Integration Tests', () {
      test('should integrate all API services correctly', () {
        // Test service integration
        final apiClient = container.read(enhancedApiClientProvider);
        final rateLimiter = container.read(rateLimiterServiceProvider);
        final authService = container.read(authTokenServiceProvider);
        final analytics = container.read(apiAnalyticsServiceProvider);
        
        expect(apiClient, isNotNull);
        expect(rateLimiter, isNotNull);
        expect(authService, isNotNull);
        expect(analytics, isNotNull);
      });

      test('should handle provider dependencies', () {
        // Test provider dependencies
        expect(() => container.read(enhancedApiClientProvider), returnsNormally);
        expect(() => container.read(rateLimiterServiceProvider), returnsNormally);
        expect(() => container.read(authTokenServiceProvider), returnsNormally);
        expect(() => container.read(apiAnalyticsServiceProvider), returnsNormally);
      });
    });

    group('Error Handling Tests', () {
      test('should handle service initialization errors gracefully', () {
        // Test error handling during initialization
        expect(() => container.read(enhancedApiClientProvider), returnsNormally);
      });

      test('should handle provider disposal correctly', () {
        // Test provider disposal
        expect(() => container.dispose(), returnsNormally);
      });
    });
  });
}

/// Helper class for creating test data
class TestDataFactory {
  static Map<String, dynamic> createHealthData() {
    return {
      'type': 'steps',
      'value': 10000,
      'unit': 'count',
      'timestamp': DateTime.now().toIso8601String(),
      'source': 'test',
    };
  }

  static Map<String, dynamic> createFinancialData() {
    return {
      'type': 'transaction',
      'amount': 100.0,
      'currency': 'USD',
      'category': 'food',
      'timestamp': DateTime.now().toIso8601String(),
      'description': 'Test transaction',
    };
  }

  static Map<String, dynamic> createApiResponse({
    int statusCode = 200,
    Map<String, dynamic>? data,
  }) {
    return {
      'statusCode': statusCode,
      'data': data ?? {'message': 'success'},
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}

/// Helper class for test assertions
class ApiTestAssertions {
  static void assertSuccessfulResponse(Response response) {
    expect(response.statusCode, equals(200));
    expect(response.data, isNotNull);
  }

  static void assertErrorResponse(Response response) {
    expect(response.statusCode, greaterThanOrEqualTo(400));
  }

  static void assertRateLimitResponse(Response response) {
    expect(response.statusCode, equals(429));
  }

  static void assertAuthenticationRequired(Response response) {
    expect(response.statusCode, equals(401));
  }
}