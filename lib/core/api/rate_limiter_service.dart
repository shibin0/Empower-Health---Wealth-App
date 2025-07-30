import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Token bucket rate limiter implementation
class TokenBucket {
  final int capacity;
  final int refillRate; // tokens per second
  int _tokens;
  DateTime _lastRefill;

  TokenBucket({
    required this.capacity,
    required this.refillRate,
  }) : _tokens = capacity, _lastRefill = DateTime.now();

  /// Try to consume tokens from the bucket
  bool tryConsume(int tokens) {
    _refill();
    
    if (_tokens >= tokens) {
      _tokens -= tokens;
      return true;
    }
    
    return false;
  }

  /// Refill tokens based on elapsed time
  void _refill() {
    final now = DateTime.now();
    final elapsed = now.difference(_lastRefill).inMilliseconds / 1000.0;
    final tokensToAdd = (elapsed * refillRate).floor();
    
    if (tokensToAdd > 0) {
      _tokens = (_tokens + tokensToAdd).clamp(0, capacity);
      _lastRefill = now;
    }
  }

  /// Get current token count
  int get availableTokens {
    _refill();
    return _tokens;
  }

  /// Get time until next token is available
  Duration get timeUntilNextToken {
    _refill();
    if (_tokens > 0) return Duration.zero;
    
    final timePerToken = 1000 / refillRate; // milliseconds per token
    return Duration(milliseconds: timePerToken.ceil());
  }
}

/// Sliding window rate limiter
class SlidingWindowRateLimiter {
  final int maxRequests;
  final Duration window;
  final Queue<DateTime> _requests = Queue<DateTime>();

  SlidingWindowRateLimiter({
    required this.maxRequests,
    required this.window,
  });

  /// Check if request is allowed
  bool isAllowed() {
    final now = DateTime.now();
    final windowStart = now.subtract(window);
    
    // Remove old requests outside the window
    while (_requests.isNotEmpty && _requests.first.isBefore(windowStart)) {
      _requests.removeFirst();
    }
    
    // Check if we can add a new request
    if (_requests.length < maxRequests) {
      _requests.addLast(now);
      return true;
    }
    
    return false;
  }

  /// Get current request count in window
  int get currentRequests {
    final now = DateTime.now();
    final windowStart = now.subtract(window);
    
    // Remove old requests
    while (_requests.isNotEmpty && _requests.first.isBefore(windowStart)) {
      _requests.removeFirst();
    }
    
    return _requests.length;
  }

  /// Get time until window resets
  Duration get timeUntilReset {
    if (_requests.isEmpty) return Duration.zero;
    
    final oldestRequest = _requests.first;
    final windowEnd = oldestRequest.add(window);
    final now = DateTime.now();
    
    return windowEnd.isAfter(now) ? windowEnd.difference(now) : Duration.zero;
  }
}

/// Rate limiter configuration
class RateLimitConfig {
  final String name;
  final int maxRequests;
  final Duration window;
  final int burstCapacity;
  final int refillRate;
  final RateLimitStrategy strategy;

  const RateLimitConfig({
    required this.name,
    required this.maxRequests,
    required this.window,
    this.burstCapacity = 10,
    this.refillRate = 1,
    this.strategy = RateLimitStrategy.tokenBucket,
  });

  /// Default configurations for different API types
  static const Map<String, RateLimitConfig> defaults = {
    'health_api': RateLimitConfig(
      name: 'Health API',
      maxRequests: 100,
      window: Duration(minutes: 1),
      burstCapacity: 20,
      refillRate: 2,
    ),
    'financial_api': RateLimitConfig(
      name: 'Financial API',
      maxRequests: 50,
      window: Duration(minutes: 1),
      burstCapacity: 10,
      refillRate: 1,
    ),
    'general_api': RateLimitConfig(
      name: 'General API',
      maxRequests: 200,
      window: Duration(minutes: 1),
      burstCapacity: 50,
      refillRate: 5,
    ),
    'websocket': RateLimitConfig(
      name: 'WebSocket',
      maxRequests: 1000,
      window: Duration(minutes: 1),
      burstCapacity: 100,
      refillRate: 20,
    ),
  };
}

/// Rate limiting strategies
enum RateLimitStrategy {
  tokenBucket,
  slidingWindow,
  fixedWindow,
}

/// Rate limit result
class RateLimitResult {
  final bool allowed;
  final String reason;
  final Duration? retryAfter;
  final Map<String, dynamic> metadata;

  const RateLimitResult({
    required this.allowed,
    this.reason = '',
    this.retryAfter,
    this.metadata = const {},
  });

  const RateLimitResult.allowed() : this(allowed: true);
  
  const RateLimitResult.denied({
    required String reason,
    Duration? retryAfter,
    Map<String, dynamic> metadata = const {},
  }) : this(
    allowed: false,
    reason: reason,
    retryAfter: retryAfter,
    metadata: metadata,
  );
}

/// Comprehensive rate limiter service
class RateLimiterService {
  final Map<String, TokenBucket> _tokenBuckets = {};
  final Map<String, SlidingWindowRateLimiter> _slidingWindows = {};
  final Map<String, RateLimitConfig> _configs = {};
  final Map<String, DateTime> _lastRequestTimes = {};
  final Map<String, int> _requestCounts = {};

  /// Initialize rate limiter with default configurations
  void initialize() {
    for (final entry in RateLimitConfig.defaults.entries) {
      addRateLimiter(entry.key, entry.value);
    }
    debugPrint('Rate limiter service initialized with ${_configs.length} limiters');
  }

  /// Add a new rate limiter
  void addRateLimiter(String key, RateLimitConfig config) {
    _configs[key] = config;
    
    switch (config.strategy) {
      case RateLimitStrategy.tokenBucket:
        _tokenBuckets[key] = TokenBucket(
          capacity: config.burstCapacity,
          refillRate: config.refillRate,
        );
        break;
      case RateLimitStrategy.slidingWindow:
        _slidingWindows[key] = SlidingWindowRateLimiter(
          maxRequests: config.maxRequests,
          window: config.window,
        );
        break;
      case RateLimitStrategy.fixedWindow:
        // Fixed window is handled by request counts and time tracking
        break;
    }
  }

  /// Check if request is allowed
  RateLimitResult checkRateLimit(String key, {int tokens = 1}) {
    final config = _configs[key];
    if (config == null) {
      return const RateLimitResult.allowed();
    }

    switch (config.strategy) {
      case RateLimitStrategy.tokenBucket:
        return _checkTokenBucket(key, config, tokens);
      case RateLimitStrategy.slidingWindow:
        return _checkSlidingWindow(key, config);
      case RateLimitStrategy.fixedWindow:
        return _checkFixedWindow(key, config);
    }
  }

  /// Check token bucket rate limit
  RateLimitResult _checkTokenBucket(String key, RateLimitConfig config, int tokens) {
    final bucket = _tokenBuckets[key];
    if (bucket == null) return const RateLimitResult.allowed();

    if (bucket.tryConsume(tokens)) {
      _recordRequest(key);
      return const RateLimitResult.allowed();
    }

    return RateLimitResult.denied(
      reason: 'Token bucket exhausted for $key',
      retryAfter: bucket.timeUntilNextToken,
      metadata: {
        'available_tokens': bucket.availableTokens,
        'requested_tokens': tokens,
        'capacity': config.burstCapacity,
      },
    );
  }

  /// Check sliding window rate limit
  RateLimitResult _checkSlidingWindow(String key, RateLimitConfig config) {
    final limiter = _slidingWindows[key];
    if (limiter == null) return const RateLimitResult.allowed();

    if (limiter.isAllowed()) {
      _recordRequest(key);
      return const RateLimitResult.allowed();
    }

    return RateLimitResult.denied(
      reason: 'Sliding window limit exceeded for $key',
      retryAfter: limiter.timeUntilReset,
      metadata: {
        'current_requests': limiter.currentRequests,
        'max_requests': config.maxRequests,
        'window_duration': config.window.inSeconds,
      },
    );
  }

  /// Check fixed window rate limit
  RateLimitResult _checkFixedWindow(String key, RateLimitConfig config) {
    final now = DateTime.now();
    final lastRequest = _lastRequestTimes[key];
    final currentCount = _requestCounts[key] ?? 0;

    // Reset window if enough time has passed
    if (lastRequest == null || now.difference(lastRequest) >= config.window) {
      _requestCounts[key] = 1;
      _lastRequestTimes[key] = now;
      _recordRequest(key);
      return const RateLimitResult.allowed();
    }

    // Check if within limit
    if (currentCount < config.maxRequests) {
      _requestCounts[key] = currentCount + 1;
      _recordRequest(key);
      return const RateLimitResult.allowed();
    }

    // Calculate retry after
    final windowEnd = lastRequest.add(config.window);
    final retryAfter = windowEnd.difference(now);

    return RateLimitResult.denied(
      reason: 'Fixed window limit exceeded for $key',
      retryAfter: retryAfter,
      metadata: {
        'current_requests': currentCount,
        'max_requests': config.maxRequests,
        'window_duration': config.window.inSeconds,
      },
    );
  }

  /// Record a successful request
  void _recordRequest(String key) {
    _lastRequestTimes[key] = DateTime.now();
  }

  /// Get rate limit status for a key
  Map<String, dynamic> getRateLimitStatus(String key) {
    final config = _configs[key];
    if (config == null) {
      return {'error': 'Rate limiter not found for key: $key'};
    }

    final status = <String, dynamic>{
      'key': key,
      'strategy': config.strategy.name,
      'max_requests': config.maxRequests,
      'window_seconds': config.window.inSeconds,
    };

    switch (config.strategy) {
      case RateLimitStrategy.tokenBucket:
        final bucket = _tokenBuckets[key];
        if (bucket != null) {
          status.addAll({
            'available_tokens': bucket.availableTokens,
            'capacity': config.burstCapacity,
            'refill_rate': config.refillRate,
            'time_until_next_token_ms': bucket.timeUntilNextToken.inMilliseconds,
          });
        }
        break;
      case RateLimitStrategy.slidingWindow:
        final limiter = _slidingWindows[key];
        if (limiter != null) {
          status.addAll({
            'current_requests': limiter.currentRequests,
            'time_until_reset_ms': limiter.timeUntilReset.inMilliseconds,
          });
        }
        break;
      case RateLimitStrategy.fixedWindow:
        status.addAll({
          'current_requests': _requestCounts[key] ?? 0,
          'last_request': _lastRequestTimes[key]?.toIso8601String(),
        });
        break;
    }

    return status;
  }

  /// Get all rate limit statuses
  Map<String, dynamic> getAllRateLimitStatuses() {
    final statuses = <String, dynamic>{};
    for (final key in _configs.keys) {
      statuses[key] = getRateLimitStatus(key);
    }
    return statuses;
  }

  /// Update rate limit configuration
  void updateRateLimitConfig(String key, RateLimitConfig newConfig) {
    addRateLimiter(key, newConfig);
    debugPrint('Updated rate limit config for $key');
  }

  /// Remove rate limiter
  void removeRateLimiter(String key) {
    _configs.remove(key);
    _tokenBuckets.remove(key);
    _slidingWindows.remove(key);
    _requestCounts.remove(key);
    _lastRequestTimes.remove(key);
    debugPrint('Removed rate limiter for $key');
  }

  /// Clear all rate limiters
  void clearAll() {
    _configs.clear();
    _tokenBuckets.clear();
    _slidingWindows.clear();
    _requestCounts.clear();
    _lastRequestTimes.clear();
    debugPrint('Cleared all rate limiters');
  }

  /// Get rate limiter statistics
  Map<String, dynamic> getStatistics() {
    return {
      'total_limiters': _configs.length,
      'token_buckets': _tokenBuckets.length,
      'sliding_windows': _slidingWindows.length,
      'active_keys': _configs.keys.toList(),
      'last_request_times': _lastRequestTimes.length,
      'request_counts': _requestCounts.length,
    };
  }
}

/// Provider for rate limiter service
final rateLimiterServiceProvider = Provider<RateLimiterService>((ref) {
  final service = RateLimiterService();
  service.initialize();
  return service;
});