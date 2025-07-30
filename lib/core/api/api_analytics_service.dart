import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/enhanced_storage_service.dart';

/// Enum for API request status
enum ApiRequestStatus {
  pending,
  success,
  error,
}

/// Enum for API event types
enum ApiEventType {
  requestStart,
  success,
  error,
  cacheHit,
  cacheMiss,
  rateLimit,
  circuitBreaker,
}

/// Enum for circuit breaker states
enum CircuitBreakerState {
  closed,
  open,
  halfOpen,
}

/// API log entry model
class ApiLogEntry {
  final String requestId;
  final String endpoint;
  final String method;
  final DateTime timestamp;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParams;
  final dynamic requestBody;
  final String? userId;
  final ApiRequestStatus status;
  final int? statusCode;
  final Map<String, dynamic>? responseHeaders;
  final dynamic responseBody;
  final String? errorMessage;
  final String? errorType;
  final String? stackTrace;
  final Duration? responseTime;

  ApiLogEntry({
    required this.requestId,
    required this.endpoint,
    required this.method,
    required this.timestamp,
    this.headers,
    this.queryParams,
    this.requestBody,
    this.userId,
    required this.status,
    this.statusCode,
    this.responseHeaders,
    this.responseBody,
    this.errorMessage,
    this.errorType,
    this.stackTrace,
    this.responseTime,
  });

  ApiLogEntry copyWith({
    String? requestId,
    String? endpoint,
    String? method,
    DateTime? timestamp,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    dynamic requestBody,
    String? userId,
    ApiRequestStatus? status,
    int? statusCode,
    Map<String, dynamic>? responseHeaders,
    dynamic responseBody,
    String? errorMessage,
    String? errorType,
    String? stackTrace,
    Duration? responseTime,
  }) {
    return ApiLogEntry(
      requestId: requestId ?? this.requestId,
      endpoint: endpoint ?? this.endpoint,
      method: method ?? this.method,
      timestamp: timestamp ?? this.timestamp,
      headers: headers ?? this.headers,
      queryParams: queryParams ?? this.queryParams,
      requestBody: requestBody ?? this.requestBody,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      responseHeaders: responseHeaders ?? this.responseHeaders,
      responseBody: responseBody ?? this.responseBody,
      errorMessage: errorMessage ?? this.errorMessage,
      errorType: errorType ?? this.errorType,
      stackTrace: stackTrace ?? this.stackTrace,
      responseTime: responseTime ?? this.responseTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'endpoint': endpoint,
      'method': method,
      'timestamp': timestamp.toIso8601String(),
      'headers': headers,
      'queryParams': queryParams,
      'requestBody': requestBody,
      'userId': userId,
      'status': status.name,
      'statusCode': statusCode,
      'responseHeaders': responseHeaders,
      'responseBody': responseBody,
      'errorMessage': errorMessage,
      'errorType': errorType,
      'stackTrace': stackTrace,
      'responseTime': responseTime?.inMilliseconds,
    };
  }
}

/// API metrics for individual endpoints
class ApiMetrics {
  final String endpoint;
  int totalRequests = 0;
  int successCount = 0;
  int errorCount = 0;
  int cacheHits = 0;
  int cacheMisses = 0;
  int rateLimitHits = 0;
  int circuitBreakerTrips = 0;
  double averageResponseTime = 0.0;
  double _totalResponseTime = 0.0;
  DateTime lastUpdated = DateTime.now();

  ApiMetrics({required this.endpoint});

  double get errorRate => totalRequests > 0 ? errorCount / totalRequests : 0.0;
  double get successRate => totalRequests > 0 ? successCount / totalRequests : 0.0;
  double get cacheHitRate => (cacheHits + cacheMisses) > 0 ? cacheHits / (cacheHits + cacheMisses) : 0.0;

  void updateResponseTime(double responseTime) {
    _totalResponseTime += responseTime;
    averageResponseTime = successCount > 0 ? _totalResponseTime / successCount : 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'endpoint': endpoint,
      'totalRequests': totalRequests,
      'successCount': successCount,
      'errorCount': errorCount,
      'cacheHits': cacheHits,
      'cacheMisses': cacheMisses,
      'rateLimitHits': rateLimitHits,
      'circuitBreakerTrips': circuitBreakerTrips,
      'averageResponseTime': averageResponseTime,
      'errorRate': errorRate,
      'successRate': successRate,
      'cacheHitRate': cacheHitRate,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

/// Overall API metrics
class ApiOverallMetrics {
  final int totalRequests;
  final int successfulRequests;
  final int errorCount;
  final double averageResponseTime;
  final double cacheHitRate;
  final double uptime;
  final int activeEndpoints;

  ApiOverallMetrics({
    required this.totalRequests,
    required this.successfulRequests,
    required this.errorCount,
    required this.averageResponseTime,
    required this.cacheHitRate,
    required this.uptime,
    required this.activeEndpoints,
  });

  factory ApiOverallMetrics.empty() {
    return ApiOverallMetrics(
      totalRequests: 0,
      successfulRequests: 0,
      errorCount: 0,
      averageResponseTime: 0.0,
      cacheHitRate: 0.0,
      uptime: 1.0,
      activeEndpoints: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalRequests': totalRequests,
      'successfulRequests': successfulRequests,
      'errorCount': errorCount,
      'averageResponseTime': averageResponseTime,
      'cacheHitRate': cacheHitRate,
      'uptime': uptime,
      'activeEndpoints': activeEndpoints,
    };
  }
}

/// Slow endpoint information
class SlowEndpoint {
  final String endpoint;
  final double averageResponseTime;
  final int requestCount;

  SlowEndpoint({
    required this.endpoint,
    required this.averageResponseTime,
    required this.requestCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'endpoint': endpoint,
      'averageResponseTime': averageResponseTime,
      'requestCount': requestCount,
    };
  }
}

/// Error-prone endpoint information
class ErrorProneEndpoint {
  final String endpoint;
  final double errorRate;
  final int errorCount;
  final int totalRequests;

  ErrorProneEndpoint({
    required this.endpoint,
    required this.errorRate,
    required this.errorCount,
    required this.totalRequests,
  });

  Map<String, dynamic> toJson() {
    return {
      'endpoint': endpoint,
      'errorRate': errorRate,
      'errorCount': errorCount,
      'totalRequests': totalRequests,
    };
  }
}

/// Performance insights
class ApiPerformanceInsights {
  final List<SlowEndpoint> slowEndpoints;
  final List<ErrorProneEndpoint> errorProneEndpoints;
  final double overallHealth;
  final List<String> recommendations;

  ApiPerformanceInsights({
    required this.slowEndpoints,
    required this.errorProneEndpoints,
    required this.overallHealth,
    required this.recommendations,
  });

  Map<String, dynamic> toJson() {
    return {
      'slowEndpoints': slowEndpoints.map((e) => e.toJson()).toList(),
      'errorProneEndpoints': errorProneEndpoints.map((e) => e.toJson()).toList(),
      'overallHealth': overallHealth,
      'recommendations': recommendations,
    };
  }
}

/// API request/response analytics and monitoring service
class ApiAnalyticsService {
  final Ref _ref;
  final Map<String, ApiMetrics> _endpointMetrics = {};
  final List<ApiLogEntry> _recentLogs = [];
  final Map<String, List<double>> _responseTimeHistory = {};
  Timer? _metricsFlushTimer;
  Timer? _alertCheckTimer;
  
  static const int maxLogEntries = 1000;
  static const int maxResponseTimeHistory = 100;
  static const Duration metricsFlushInterval = Duration(minutes: 5);
  static const Duration alertCheckInterval = Duration(minutes: 1);

  ApiAnalyticsService(this._ref) {
    _startPeriodicTasks();
  }

  /// Start periodic background tasks
  void _startPeriodicTasks() {
    _metricsFlushTimer = Timer.periodic(metricsFlushInterval, (_) => _flushMetrics());
    _alertCheckTimer = Timer.periodic(alertCheckInterval, (_) => _checkAlerts());
  }

  /// Log API request start
  String logRequestStart({
    required String endpoint,
    required String method,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    dynamic body,
    String? userId,
  }) {
    final requestId = _generateRequestId();
    final timestamp = DateTime.now();
    
    final logEntry = ApiLogEntry(
      requestId: requestId,
      endpoint: endpoint,
      method: method,
      timestamp: timestamp,
      headers: headers,
      queryParams: queryParams,
      requestBody: body,
      userId: userId,
      status: ApiRequestStatus.pending,
    );
    
    _addLogEntry(logEntry);
    _updateMetrics(endpoint, method, ApiEventType.requestStart);
    
    debugPrint('API Request Started: $method $endpoint [$requestId]');
    return requestId;
  }

  /// Log API request completion
  void logRequestComplete({
    required String requestId,
    required int statusCode,
    Map<String, dynamic>? responseHeaders,
    dynamic responseBody,
    String? errorMessage,
    Duration? responseTime,
  }) {
    final logEntry = _findLogEntry(requestId);
    if (logEntry != null) {
      final updatedEntry = logEntry.copyWith(
        statusCode: statusCode,
        responseHeaders: responseHeaders,
        responseBody: responseBody,
        errorMessage: errorMessage,
        responseTime: responseTime ?? DateTime.now().difference(logEntry.timestamp),
        status: statusCode >= 200 && statusCode < 300 
            ? ApiRequestStatus.success 
            : ApiRequestStatus.error,
      );
      
      _updateLogEntry(requestId, updatedEntry);
      _updateMetrics(
        logEntry.endpoint, 
        logEntry.method, 
        statusCode >= 200 && statusCode < 300 
            ? ApiEventType.success 
            : ApiEventType.error,
        responseTime: updatedEntry.responseTime,
      );
      
      debugPrint('API Request Complete: ${logEntry.method} ${logEntry.endpoint} '
          '[$requestId] - $statusCode (${updatedEntry.responseTime?.inMilliseconds}ms)');
    }
  }

  /// Log API request error
  void logRequestError({
    required String requestId,
    required String errorMessage,
    String? errorType,
    StackTrace? stackTrace,
  }) {
    final logEntry = _findLogEntry(requestId);
    if (logEntry != null) {
      final updatedEntry = logEntry.copyWith(
        errorMessage: errorMessage,
        errorType: errorType,
        stackTrace: stackTrace?.toString(),
        responseTime: DateTime.now().difference(logEntry.timestamp),
        status: ApiRequestStatus.error,
      );
      
      _updateLogEntry(requestId, updatedEntry);
      _updateMetrics(logEntry.endpoint, logEntry.method, ApiEventType.error);
      
      debugPrint('API Request Error: ${logEntry.method} ${logEntry.endpoint} '
          '[$requestId] - $errorMessage');
    }
  }

  /// Log cache hit/miss
  void logCacheEvent({
    required String endpoint,
    required String method,
    required bool isHit,
    String? cacheKey,
  }) {
    _updateMetrics(
      endpoint, 
      method, 
      isHit ? ApiEventType.cacheHit : ApiEventType.cacheMiss,
    );
    
    debugPrint('Cache ${isHit ? 'HIT' : 'MISS'}: $method $endpoint');
  }

  /// Log rate limit event
  void logRateLimitEvent({
    required String endpoint,
    required String method,
    required bool isLimited,
    int? remainingRequests,
    Duration? resetTime,
  }) {
    _updateMetrics(endpoint, method, ApiEventType.rateLimit);
    
    if (isLimited) {
      debugPrint('Rate Limited: $method $endpoint (Reset in: ${resetTime?.inSeconds}s)');
    }
  }

  /// Log circuit breaker event
  void logCircuitBreakerEvent({
    required String endpoint,
    required String method,
    required CircuitBreakerState state,
  }) {
    _updateMetrics(endpoint, method, ApiEventType.circuitBreaker);
    
    debugPrint('Circuit Breaker $state: $method $endpoint');
  }

  /// Get metrics for specific endpoint
  ApiMetrics? getEndpointMetrics(String endpoint) {
    return _endpointMetrics[endpoint];
  }

  /// Get overall API metrics
  ApiOverallMetrics getOverallMetrics() {
    final allMetrics = _endpointMetrics.values.toList();
    
    if (allMetrics.isEmpty) {
      return ApiOverallMetrics.empty();
    }
    
    final totalRequests = allMetrics.fold<int>(0, (sum, m) => sum + m.totalRequests);
    final totalErrors = allMetrics.fold<int>(0, (sum, m) => sum + m.errorCount);
    final totalCacheHits = allMetrics.fold<int>(0, (sum, m) => sum + m.cacheHits);
    final totalCacheMisses = allMetrics.fold<int>(0, (sum, m) => sum + m.cacheMisses);
    
    final allResponseTimes = allMetrics
        .where((m) => m.averageResponseTime > 0)
        .map((m) => m.averageResponseTime)
        .toList();
    
    final averageResponseTime = allResponseTimes.isNotEmpty
        ? allResponseTimes.reduce((a, b) => a + b) / allResponseTimes.length
        : 0.0;
    
    return ApiOverallMetrics(
      totalRequests: totalRequests,
      successfulRequests: totalRequests - totalErrors,
      errorCount: totalErrors,
      averageResponseTime: averageResponseTime,
      cacheHitRate: totalCacheHits + totalCacheMisses > 0
          ? totalCacheHits / (totalCacheHits + totalCacheMisses)
          : 0.0,
      uptime: _calculateUptime(),
      activeEndpoints: _endpointMetrics.length,
    );
  }

  /// Get recent API logs
  List<ApiLogEntry> getRecentLogs({
    int? limit,
    String? endpoint,
    ApiRequestStatus? status,
    DateTime? since,
  }) {
    var logs = List<ApiLogEntry>.from(_recentLogs);
    
    if (endpoint != null) {
      logs = logs.where((log) => log.endpoint == endpoint).toList();
    }
    
    if (status != null) {
      logs = logs.where((log) => log.status == status).toList();
    }
    
    if (since != null) {
      logs = logs.where((log) => log.timestamp.isAfter(since)).toList();
    }
    
    logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    
    if (limit != null && limit < logs.length) {
      logs = logs.take(limit).toList();
    }
    
    return logs;
  }

  /// Get error logs
  List<ApiLogEntry> getErrorLogs({int? limit}) {
    return getRecentLogs(
      status: ApiRequestStatus.error,
      limit: limit,
    );
  }

  /// Get performance insights
  ApiPerformanceInsights getPerformanceInsights() {
    final slowEndpoints = _endpointMetrics.entries
        .where((entry) => entry.value.averageResponseTime > 2000) // > 2 seconds
        .map((entry) => SlowEndpoint(
              endpoint: entry.key,
              averageResponseTime: entry.value.averageResponseTime,
              requestCount: entry.value.totalRequests,
            ))
        .toList()
      ..sort((a, b) => b.averageResponseTime.compareTo(a.averageResponseTime));

    final errorProneEndpoints = _endpointMetrics.entries
        .where((entry) => entry.value.errorRate > 0.1) // > 10% error rate
        .map((entry) => ErrorProneEndpoint(
              endpoint: entry.key,
              errorRate: entry.value.errorRate,
              errorCount: entry.value.errorCount,
              totalRequests: entry.value.totalRequests,
            ))
        .toList()
      ..sort((a, b) => b.errorRate.compareTo(a.errorRate));

    return ApiPerformanceInsights(
      slowEndpoints: slowEndpoints,
      errorProneEndpoints: errorProneEndpoints,
      overallHealth: _calculateOverallHealth(),
      recommendations: _generateRecommendations(),
    );
  }

  /// Export analytics data
  Future<Map<String, dynamic>> exportAnalytics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final logs = getRecentLogs(
      since: startDate,
    ).where((log) => endDate == null || log.timestamp.isBefore(endDate)).toList();

    return {
      'export_timestamp': DateTime.now().toIso8601String(),
      'period': {
        'start': startDate?.toIso8601String(),
        'end': endDate?.toIso8601String(),
      },
      'overall_metrics': getOverallMetrics().toJson(),
      'endpoint_metrics': _endpointMetrics.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
      'performance_insights': getPerformanceInsights().toJson(),
      'logs': logs.map((log) => log.toJson()).toList(),
      'response_time_history': _responseTimeHistory,
    };
  }

  /// Clear analytics data
  Future<void> clearAnalytics() async {
    _endpointMetrics.clear();
    _recentLogs.clear();
    _responseTimeHistory.clear();
    
    final storageService = _ref.read(enhancedStorageServiceProvider.notifier);
    await storageService.clearCache();
    
    debugPrint('Analytics data cleared');
  }

  /// Dispose resources
  void dispose() {
    _metricsFlushTimer?.cancel();
    _alertCheckTimer?.cancel();
  }

  /// Private helper methods
  String _generateRequestId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}';
  }

  void _addLogEntry(ApiLogEntry entry) {
    _recentLogs.add(entry);
    
    if (_recentLogs.length > maxLogEntries) {
      _recentLogs.removeAt(0);
    }
  }

  ApiLogEntry? _findLogEntry(String requestId) {
    try {
      return _recentLogs.firstWhere((entry) => entry.requestId == requestId);
    } catch (e) {
      return null;
    }
  }

  void _updateLogEntry(String requestId, ApiLogEntry updatedEntry) {
    final index = _recentLogs.indexWhere((entry) => entry.requestId == requestId);
    if (index != -1) {
      _recentLogs[index] = updatedEntry;
    }
  }

  void _updateMetrics(
    String endpoint,
    String method,
    ApiEventType eventType, {
    Duration? responseTime,
  }) {
    final key = '$method $endpoint';
    final metrics = _endpointMetrics[key] ?? ApiMetrics(endpoint: key);
    
    switch (eventType) {
      case ApiEventType.requestStart:
        metrics.totalRequests++;
        break;
      case ApiEventType.success:
        metrics.successCount++;
        if (responseTime != null) {
          _updateResponseTimeHistory(key, responseTime.inMilliseconds.toDouble());
          metrics.updateResponseTime(responseTime.inMilliseconds.toDouble());
        }
        break;
      case ApiEventType.error:
        metrics.errorCount++;
        break;
      case ApiEventType.cacheHit:
        metrics.cacheHits++;
        break;
      case ApiEventType.cacheMiss:
        metrics.cacheMisses++;
        break;
      case ApiEventType.rateLimit:
        metrics.rateLimitHits++;
        break;
      case ApiEventType.circuitBreaker:
        metrics.circuitBreakerTrips++;
        break;
    }
    
    metrics.lastUpdated = DateTime.now();
    _endpointMetrics[key] = metrics;
  }

  void _updateResponseTimeHistory(String endpoint, double responseTime) {
    final history = _responseTimeHistory[endpoint] ?? <double>[];
    history.add(responseTime);
    
    if (history.length > maxResponseTimeHistory) {
      history.removeAt(0);
    }
    
    _responseTimeHistory[endpoint] = history;
  }

  double _calculateUptime() {
    // Simplified uptime calculation based on successful requests
    final overall = getOverallMetrics();
    if (overall.totalRequests == 0) return 1.0;
    
    return overall.successfulRequests / overall.totalRequests;
  }

  double _calculateOverallHealth() {
    final overall = getOverallMetrics();
    final uptime = _calculateUptime();
    final avgResponseTime = overall.averageResponseTime;
    
    // Health score based on uptime and response time
    double healthScore = uptime * 0.7; // 70% weight for uptime
    
    // Response time factor (good if < 1000ms, poor if > 5000ms)
    double responseTimeFactor = 1.0;
    if (avgResponseTime > 1000) {
      responseTimeFactor = max(0.0, 1.0 - (avgResponseTime - 1000) / 4000);
    }
    healthScore += responseTimeFactor * 0.3; // 30% weight for response time
    
    return max(0.0, min(1.0, healthScore));
  }

  List<String> _generateRecommendations() {
    final recommendations = <String>[];
    final insights = getPerformanceInsights();
    
    if (insights.slowEndpoints.isNotEmpty) {
      recommendations.add('Consider optimizing slow endpoints: ${insights.slowEndpoints.take(3).map((e) => e.endpoint).join(', ')}');
    }
    
    if (insights.errorProneEndpoints.isNotEmpty) {
      recommendations.add('Review error-prone endpoints: ${insights.errorProneEndpoints.take(3).map((e) => e.endpoint).join(', ')}');
    }
    
    final overall = getOverallMetrics();
    if (overall.cacheHitRate < 0.5) {
      recommendations.add('Consider improving cache strategy - current hit rate: ${(overall.cacheHitRate * 100).toStringAsFixed(1)}%');
    }
    
    if (overall.averageResponseTime > 2000) {
      recommendations.add('Overall response time is high (${overall.averageResponseTime.toStringAsFixed(0)}ms) - consider performance optimization');
    }
    
    return recommendations;
  }

  Future<void> _flushMetrics() async {
    try {
      final storageService = _ref.read(enhancedStorageServiceProvider.notifier);
      final metricsData = _endpointMetrics.map(
        (key, value) => MapEntry(key, value.toJson()),
      );
      
      await storageService.cacheData(
        'api_metrics',
        {'metrics': metricsData, 'timestamp': DateTime.now().toIso8601String()},
        ttl: const Duration(hours: 24),
      );
      
      debugPrint('API metrics flushed to storage');
    } catch (e) {
      debugPrint('Failed to flush metrics: $e');
    }
  }

  Future<void> _checkAlerts() async {
    try {
      final overall = getOverallMetrics();
      
      // Check for high error rate
      if (overall.totalRequests > 10 && overall.errorCount / overall.totalRequests > 0.2) {
        debugPrint('ALERT: High error rate detected - ${((overall.errorCount / overall.totalRequests) * 100).toStringAsFixed(1)}%');
      }
      
      // Check for slow response times
      if (overall.averageResponseTime > 5000) {
        debugPrint('ALERT: Slow response times detected - ${overall.averageResponseTime.toStringAsFixed(0)}ms average');
      }
      
      // Check for low cache hit rate
      if (overall.totalRequests > 50 && overall.cacheHitRate < 0.3) {
        debugPrint('ALERT: Low cache hit rate - ${(overall.cacheHitRate * 100).toStringAsFixed(1)}%');
      }
    } catch (e) {
      debugPrint('Failed to check alerts: $e');
    }
  }
}

/// Provider for API analytics service
final apiAnalyticsServiceProvider = Provider<ApiAnalyticsService>((ref) {
  return ApiAnalyticsService(ref);
});