import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'enhanced_api_client.dart';
import '../storage/enhanced_storage_service.dart';
import '../../features/health/models/health_data.dart';
import '../../features/wealth/models/financial_data.dart';

/// Real-time data service for WebSocket-based updates
class RealtimeDataService {
  final Ref _ref;
  final Map<String, StreamSubscription> _subscriptions = {};
  final Map<String, StreamController> _controllers = {};
  bool _isInitialized = false;

  RealtimeDataService(this._ref) {
    _initializeRealtimeService();
  }

  /// Initialize real-time service
  void _initializeRealtimeService() {
    try {
      _isInitialized = true;
      debugPrint('Real-time data service initialized');
    } catch (e) {
      debugPrint('Failed to initialize real-time service: $e');
    }
  }

  /// Subscribe to health data updates
  Stream<HealthData> subscribeToHealthUpdates(String userId) {
    final endpoint = '/ws/health/$userId';
    final controller = StreamController<HealthData>.broadcast();

    _controllers[endpoint] = controller;

    _connectToWebSocket(endpoint).then((stream) {
      final subscription = stream.listen(
        (data) {
          try {
            final healthUpdate = _parseHealthUpdate(data);
            if (healthUpdate != null) {
              controller.add(healthUpdate);
              _cacheHealthUpdate(healthUpdate);
            }
          } catch (e) {
            debugPrint('Error parsing health update: $e');
          }
        },
        onError: (error) {
          debugPrint('Health WebSocket error: $error');
          controller.addError(error);
        },
      );

      _subscriptions[endpoint] = subscription;
    }).catchError((error) {
      debugPrint('Failed to connect to health WebSocket: $error');
      controller.addError(error);
    });

    return controller.stream;
  }

  /// Subscribe to financial data updates
  Stream<Investment> subscribeToFinancialUpdates(String userId) {
    final endpoint = '/ws/financial/$userId';
    final controller = StreamController<Investment>.broadcast();

    _controllers[endpoint] = controller;

    _connectToWebSocket(endpoint).then((stream) {
      final subscription = stream.listen(
        (data) {
          try {
            final financialUpdate = _parseFinancialUpdate(data);
            if (financialUpdate != null) {
              controller.add(financialUpdate);
              _cacheFinancialUpdate(financialUpdate);
            }
          } catch (e) {
            debugPrint('Error parsing financial update: $e');
          }
        },
        onError: (error) {
          debugPrint('Financial WebSocket error: $error');
          controller.addError(error);
        },
      );

      _subscriptions[endpoint] = subscription;
    }).catchError((error) {
      debugPrint('Failed to connect to financial WebSocket: $error');
      controller.addError(error);
    });

    return controller.stream;
  }

  /// Subscribe to market data updates
  Stream<Map<String, dynamic>> subscribeToMarketUpdates() {
    const endpoint = '/ws/market';
    final controller = StreamController<Map<String, dynamic>>.broadcast();

    _controllers[endpoint] = controller;

    _connectToWebSocket(endpoint).then((stream) {
      final subscription = stream.listen(
        (data) {
          try {
            final marketUpdate = _parseMarketUpdate(data);
            if (marketUpdate != null) {
              controller.add(marketUpdate);
              _cacheMarketUpdate(marketUpdate);
            }
          } catch (e) {
            debugPrint('Error parsing market update: $e');
          }
        },
        onError: (error) {
          debugPrint('Market WebSocket error: $error');
          controller.addError(error);
        },
      );

      _subscriptions[endpoint] = subscription;
    }).catchError((error) {
      debugPrint('Failed to connect to market WebSocket: $error');
      controller.addError(error);
    });

    return controller.stream;
  }

  /// Subscribe to sync status updates
  Stream<Map<String, dynamic>> subscribeToSyncUpdates(String userId) {
    final endpoint = '/ws/sync/$userId';
    final controller = StreamController<Map<String, dynamic>>.broadcast();

    _controllers[endpoint] = controller;

    _connectToWebSocket(endpoint).then((stream) {
      final subscription = stream.listen(
        (data) {
          try {
            final syncUpdate = _parseSyncUpdate(data);
            if (syncUpdate != null) {
              controller.add(syncUpdate);
            }
          } catch (e) {
            debugPrint('Error parsing sync update: $e');
          }
        },
        onError: (error) {
          debugPrint('Sync WebSocket error: $error');
          controller.addError(error);
        },
      );

      _subscriptions[endpoint] = subscription;
    }).catchError((error) {
      debugPrint('Failed to connect to sync WebSocket: $error');
      controller.addError(error);
    });

    return controller.stream;
  }

  /// Connect to WebSocket endpoint
  Future<Stream<dynamic>> _connectToWebSocket(String endpoint) async {
    final apiClient = await _ref.read(enhancedApiClientProvider.future);

    // Add authentication headers
    final storageService = _ref.read(enhancedStorageServiceProvider.notifier);
    final authData = storageService.getCachedData('auth_token');
    final token = authData?['token'];

    final headers = token != null ? {'Authorization': 'Bearer $token'} : null;

    return apiClient.connectWebSocket(endpoint, headers: headers);
  }

  /// Parse health data update
  HealthData? _parseHealthUpdate(dynamic data) {
    try {
      final Map<String, dynamic> json =
          data is String ? jsonDecode(data) : data;

      if (json['type'] == 'health_update' && json['data'] != null) {
        return HealthData.fromJson(json['data']);
      }
    } catch (e) {
      debugPrint('Failed to parse health update: $e');
    }
    return null;
  }

  /// Parse financial data update
  Investment? _parseFinancialUpdate(dynamic data) {
    try {
      final Map<String, dynamic> json =
          data is String ? jsonDecode(data) : data;

      if (json['type'] == 'financial_update' && json['data'] != null) {
        return Investment.fromJson(json['data']);
      }
    } catch (e) {
      debugPrint('Failed to parse financial update: $e');
    }
    return null;
  }

  /// Parse market data update
  Map<String, dynamic>? _parseMarketUpdate(dynamic data) {
    try {
      final Map<String, dynamic> json =
          data is String ? jsonDecode(data) : data;

      if (json['type'] == 'market_update' && json['data'] != null) {
        return json['data'];
      }
    } catch (e) {
      debugPrint('Failed to parse market update: $e');
    }
    return null;
  }

  /// Parse sync status update
  Map<String, dynamic>? _parseSyncUpdate(dynamic data) {
    try {
      final Map<String, dynamic> json =
          data is String ? jsonDecode(data) : data;

      if (json['type'] == 'sync_update' && json['data'] != null) {
        return json['data'];
      }
    } catch (e) {
      debugPrint('Failed to parse sync update: $e');
    }
    return null;
  }

  /// Cache health update locally
  Future<void> _cacheHealthUpdate(HealthData healthData) async {
    try {
      final storageService = _ref.read(enhancedStorageServiceProvider.notifier);
      await storageService.cacheData(
        'realtime_health_${healthData.id}',
        healthData.toJson(),
        ttl: const Duration(hours: 24),
      );
    } catch (e) {
      debugPrint('Failed to cache health update: $e');
    }
  }

  /// Cache financial update locally
  Future<void> _cacheFinancialUpdate(Investment investment) async {
    try {
      final storageService = _ref.read(enhancedStorageServiceProvider.notifier);
      await storageService.cacheData(
        'realtime_financial_${investment.id}',
        investment.toJson(),
        ttl: const Duration(hours: 1),
      );
    } catch (e) {
      debugPrint('Failed to cache financial update: $e');
    }
  }

  /// Cache market update locally
  Future<void> _cacheMarketUpdate(Map<String, dynamic> marketData) async {
    try {
      final storageService = _ref.read(enhancedStorageServiceProvider.notifier);
      await storageService.cacheData(
        'realtime_market_${marketData['symbol'] ?? 'general'}',
        marketData,
        ttl: const Duration(minutes: 5),
      );
    } catch (e) {
      debugPrint('Failed to cache market update: $e');
    }
  }

  /// Send real-time message
  Future<void> sendRealtimeMessage(
      String endpoint, Map<String, dynamic> message) async {
    try {
      final apiClient = await _ref.read(enhancedApiClientProvider.future);
      apiClient.sendWebSocketMessage(endpoint, message);
    } catch (e) {
      debugPrint('Failed to send real-time message: $e');
    }
  }

  /// Request real-time health data
  Future<void> requestHealthData(
      String userId, List<HealthMetricType> metrics) async {
    final message = {
      'type': 'request_health_data',
      'user_id': userId,
      'metrics': metrics.map((m) => m.name).toList(),
      'timestamp': DateTime.now().toIso8601String(),
    };

    await sendRealtimeMessage('/ws/health/$userId', message);
  }

  /// Request real-time financial data
  Future<void> requestFinancialData(String userId, List<String> symbols) async {
    final message = {
      'type': 'request_financial_data',
      'user_id': userId,
      'symbols': symbols,
      'timestamp': DateTime.now().toIso8601String(),
    };

    await sendRealtimeMessage('/ws/financial/$userId', message);
  }

  /// Subscribe to specific stock prices
  Future<void> subscribeToStockPrices(List<String> symbols) async {
    final message = {
      'type': 'subscribe_stocks',
      'symbols': symbols,
      'timestamp': DateTime.now().toIso8601String(),
    };

    await sendRealtimeMessage('/ws/market', message);
  }

  /// Unsubscribe from stock prices
  Future<void> unsubscribeFromStockPrices(List<String> symbols) async {
    final message = {
      'type': 'unsubscribe_stocks',
      'symbols': symbols,
      'timestamp': DateTime.now().toIso8601String(),
    };

    await sendRealtimeMessage('/ws/market', message);
  }

  /// Get connection status
  Map<String, bool> getConnectionStatus() {
    final status = <String, bool>{};
    for (final endpoint in _subscriptions.keys) {
      status[endpoint] = !_subscriptions[endpoint]!.isPaused;
    }
    return status;
  }

  /// Reconnect to all WebSocket endpoints
  Future<void> reconnectAll() async {
    final endpoints = _subscriptions.keys.toList();

    // Close existing connections
    await disconnectAll();

    // Reconnect to all endpoints
    for (final endpoint in endpoints) {
      try {
        await _connectToWebSocket(endpoint);
        debugPrint('Reconnected to $endpoint');
      } catch (e) {
        debugPrint('Failed to reconnect to $endpoint: $e');
      }
    }
  }

  /// Disconnect from specific endpoint
  Future<void> disconnect(String endpoint) async {
    final subscription = _subscriptions[endpoint];
    final controller = _controllers[endpoint];

    await subscription?.cancel();
    await controller?.close();

    _subscriptions.remove(endpoint);
    _controllers.remove(endpoint);

    // Close WebSocket connection
    final apiClient = await _ref.read(enhancedApiClientProvider.future);
    apiClient.closeWebSocket(endpoint);
  }

  /// Disconnect from all endpoints
  Future<void> disconnectAll() async {
    final endpoints = _subscriptions.keys.toList();

    for (final endpoint in endpoints) {
      await disconnect(endpoint);
    }

    // Close all WebSocket connections
    final apiClient = await _ref.read(enhancedApiClientProvider.future);
    apiClient.closeAllWebSockets();
  }

  /// Get real-time statistics
  Map<String, dynamic> getRealtimeStatistics() {
    return {
      'active_connections': _subscriptions.length,
      'endpoints': _subscriptions.keys.toList(),
      'connection_status': getConnectionStatus(),
      'is_initialized': _isInitialized,
    };
  }

  /// Dispose resources
  void dispose() {
    disconnectAll();
  }
}

/// Provider for real-time data service
final realtimeDataServiceProvider = Provider<RealtimeDataService>((ref) {
  return RealtimeDataService(ref);
});
