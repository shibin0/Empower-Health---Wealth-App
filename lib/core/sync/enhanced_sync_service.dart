import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../storage/enhanced_storage_service.dart';
import '../api/api_client.dart';

part 'enhanced_sync_service.g.dart';

/// Enhanced synchronization service with conflict resolution
@riverpod
class EnhancedSyncService extends _$EnhancedSyncService {
  Timer? _syncTimer;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool _isSyncing = false;
  final Map<String, SyncConflict> _conflicts = {};

  @override
  Future<EnhancedSyncService> build() async {
    await _initializeSync();
    return this;
  }

  Future<void> _initializeSync() async {
    // Listen to connectivity changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result != ConnectivityResult.none && !_isSyncing) {
          _triggerSync();
        }
      },
    );

    // Set up periodic sync (every 2 minutes when online)
    _syncTimer = Timer.periodic(const Duration(minutes: 2), (timer) {
      if (!_isSyncing) {
        _triggerSync();
      }
    });

    // Initial sync check
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.none) {
      _triggerSync();
    }
  }

  Future<void> _triggerSync() async {
    if (_isSyncing) return;

    _isSyncing = true;
    
    try {
      await _performEnhancedSync();
    } catch (error) {
      debugPrint('Sync error: $error');
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _performEnhancedSync() async {
    final storageService = ref.read(enhancedStorageServiceProvider.notifier);
    final apiClient = ref.read(apiClientProvider);

    // Get sync queue
    final syncQueue = storageService.getSyncQueue();
    if (syncQueue.isEmpty) {
      await storageService.setLastSyncTime(DateTime.now());
      return;
    }

    // Process sync items with conflict resolution
    for (final item in syncQueue) {
      try {
        final result = await _syncItemWithConflictResolution(item, apiClient, storageService);
        
        if (result.success) {
          await storageService.removeSyncQueueItem(item['id']);
        } else if (result.hasConflict) {
          _conflicts[item['id']] = result.conflict!;
          // Keep item in queue for manual resolution
        } else {
          await storageService.incrementSyncRetryCount(item['id']);
          
          // Remove items that have failed too many times
          if ((item['retryCount'] as int) >= 5) {
            await storageService.removeSyncQueueItem(item['id']);
          }
        }
      } catch (e) {
        debugPrint('Sync item error: $e');
        await storageService.incrementSyncRetryCount(item['id']);
      }
    }

    await storageService.setLastSyncTime(DateTime.now());
  }

  Future<SyncResult> _syncItemWithConflictResolution(
    Map<String, dynamic> item,
    ApiClient apiClient,
    EnhancedStorageService storageService,
  ) async {
    final type = item['type'] as String;
    final action = item['action'] as String;
    final data = item['data'] as Map<String, dynamic>;
    final localTimestamp = DateTime.fromMillisecondsSinceEpoch(item['timestamp']);

    try {
      // First, get the current server version
      final serverData = await _getServerData(type, data['id'], apiClient);
      
      if (serverData != null) {
        final serverTimestamp = DateTime.parse(serverData['updated_at']);
        
        // Check for conflicts
        if (serverTimestamp.isAfter(localTimestamp)) {
          // Conflict detected - server has newer data
          final conflict = SyncConflict(
            id: item['id'],
            type: type,
            localData: data,
            serverData: serverData,
            localTimestamp: localTimestamp,
            serverTimestamp: serverTimestamp,
          );
          
          // Try automatic conflict resolution
          final resolvedData = await _resolveConflictAutomatically(conflict);
          
          if (resolvedData != null) {
            // Auto-resolution successful
            await _updateServerData(type, resolvedData, apiClient);
            await _updateLocalData(type, resolvedData, storageService);
            return const SyncResult.success();
          } else {
            // Manual resolution required
            return SyncResult.conflict(conflict);
          }
        }
      }

      // No conflict, proceed with normal sync
      final success = await _syncItemToServer(type, action, data, apiClient);
      
      if (success) {
        return const SyncResult.success();
      } else {
        return const SyncResult.failure();
      }
    } catch (e) {
      debugPrint('Sync with conflict resolution failed: $e');
      return const SyncResult.failure();
    }
  }

  Future<Map<String, dynamic>?> _getServerData(
    String type,
    String id,
    ApiClient apiClient,
  ) async {
    try {
      switch (type) {
        case 'user_profile':
          final response = await apiClient.getUserProfile(id);
          return response;
        case 'health_data':
          // Get specific health data item
          return null; // Implement based on your API
        case 'portfolio':
          final response = await apiClient.getPortfolio(id);
          return response;
        case 'financial_goals':
          final response = await apiClient.getFinancialGoals(id);
          return response.isNotEmpty ? response.first : null;
        default:
          return null;
      }
    } catch (e) {
      debugPrint('Failed to get server data for $type:$id - $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> _resolveConflictAutomatically(
    SyncConflict conflict,
  ) async {
    switch (conflict.type) {
      case 'user_profile':
        return _resolveUserProfileConflict(conflict);
      case 'health_data':
        return _resolveHealthDataConflict(conflict);
      case 'portfolio':
        return _resolvePortfolioConflict(conflict);
      case 'financial_goals':
        return _resolveFinancialGoalsConflict(conflict);
      default:
        return null; // Manual resolution required
    }
  }

  Map<String, dynamic>? _resolveUserProfileConflict(SyncConflict conflict) {
    final local = conflict.localData;
    final server = conflict.serverData;
    final resolved = Map<String, dynamic>.from(server);

    // Merge strategy: Keep server data but preserve local preferences
    final preserveLocalFields = ['theme', 'notifications', 'language'];
    
    for (final field in preserveLocalFields) {
      if (local.containsKey(field)) {
        resolved[field] = local[field];
      }
    }

    // For numeric fields, take the maximum (assuming they're cumulative)
    final numericFields = ['total_points', 'streak_count'];
    for (final field in numericFields) {
      if (local.containsKey(field) && server.containsKey(field)) {
        final localValue = (local[field] as num?)?.toDouble() ?? 0.0;
        final serverValue = (server[field] as num?)?.toDouble() ?? 0.0;
        resolved[field] = localValue > serverValue ? localValue : serverValue;
      }
    }

    resolved['updated_at'] = DateTime.now().toIso8601String();
    return resolved;
  }

  Map<String, dynamic>? _resolveHealthDataConflict(SyncConflict conflict) {
    // For health data, usually take the most recent measurement
    // or merge if they're different types of measurements
    final local = conflict.localData;
    final server = conflict.serverData;

    // If same measurement type and time, take local (user's device is authoritative)
    if (local['type'] == server['type'] && 
        local['timestamp'] == server['timestamp']) {
      return local;
    }

    // Otherwise, no automatic resolution
    return null;
  }

  Map<String, dynamic>? _resolvePortfolioConflict(SyncConflict conflict) {
    final local = conflict.localData;
    final server = conflict.serverData;
    final resolved = Map<String, dynamic>.from(server);

    // Merge investments - combine both local and server investments
    final localInvestments = local['investments'] as List? ?? [];
    final serverInvestments = server['investments'] as List? ?? [];
    
    final mergedInvestments = <Map<String, dynamic>>[];
    final investmentIds = <String>{};

    // Add server investments first
    for (final investment in serverInvestments) {
      mergedInvestments.add(investment);
      investmentIds.add(investment['id']);
    }

    // Add local investments that aren't already present
    for (final investment in localInvestments) {
      if (!investmentIds.contains(investment['id'])) {
        mergedInvestments.add(investment);
      }
    }

    resolved['investments'] = mergedInvestments;
    resolved['updated_at'] = DateTime.now().toIso8601String();
    
    return resolved;
  }

  Map<String, dynamic>? _resolveFinancialGoalsConflict(SyncConflict conflict) {
    final local = conflict.localData;
    final server = conflict.serverData;
    final resolved = Map<String, dynamic>.from(server);

    // For financial goals, merge progress but keep server target amounts
    if (local.containsKey('current_amount') && server.containsKey('current_amount')) {
      final localAmount = (local['current_amount'] as num?)?.toDouble() ?? 0.0;
      final serverAmount = (server['current_amount'] as num?)?.toDouble() ?? 0.0;
      
      // Take the higher amount (assuming progress is cumulative)
      resolved['current_amount'] = localAmount > serverAmount ? localAmount : serverAmount;
    }

    resolved['updated_at'] = DateTime.now().toIso8601String();
    return resolved;
  }

  Future<bool> _syncItemToServer(
    String type,
    String action,
    Map<String, dynamic> data,
    ApiClient apiClient,
  ) async {
    try {
      switch (type) {
        case 'user_profile':
          await apiClient.updateUserProfile(data);
          return true;
        case 'health_data':
          await apiClient.createHealthData(data);
          return true;
        case 'portfolio':
          if (action == 'create') {
            await apiClient.createPortfolio(data);
          } else {
            await apiClient.updatePortfolio(data['id'], data);
          }
          return true;
        case 'financial_goals':
          await apiClient.createFinancialGoal(data);
          return true;
        default:
          return false;
      }
    } catch (e) {
      debugPrint('Failed to sync $type to server: $e');
      return false;
    }
  }

  Future<void> _updateServerData(
    String type,
    Map<String, dynamic> data,
    ApiClient apiClient,
  ) async {
    await _syncItemToServer(type, 'update', data, apiClient);
  }

  Future<void> _updateLocalData(
    String type,
    Map<String, dynamic> data,
    EnhancedStorageService storageService,
  ) async {
    switch (type) {
      case 'user_profile':
        // Update local user profile
        break;
      case 'portfolio':
        // Update local portfolio
        break;
      // Add other cases as needed
    }
  }

  // Manual conflict resolution methods

  /// Get all pending conflicts
  Map<String, SyncConflict> getPendingConflicts() {
    return Map.from(_conflicts);
  }

  /// Resolve conflict manually by choosing local data
  Future<void> resolveConflictWithLocal(String conflictId) async {
    final conflict = _conflicts[conflictId];
    if (conflict == null) return;

    try {
      final apiClient = ref.read(apiClientProvider);
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      
      await _updateServerData(conflict.type, conflict.localData, apiClient);
      await storageService.removeSyncQueueItem(conflictId);
      _conflicts.remove(conflictId);
    } catch (e) {
      debugPrint('Failed to resolve conflict with local data: $e');
    }
  }

  /// Resolve conflict manually by choosing server data
  Future<void> resolveConflictWithServer(String conflictId) async {
    final conflict = _conflicts[conflictId];
    if (conflict == null) return;

    try {
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      
      await _updateLocalData(conflict.type, conflict.serverData, storageService);
      await storageService.removeSyncQueueItem(conflictId);
      _conflicts.remove(conflictId);
    } catch (e) {
      debugPrint('Failed to resolve conflict with server data: $e');
    }
  }

  /// Resolve conflict manually with custom merged data
  Future<void> resolveConflictWithMerged(
    String conflictId,
    Map<String, dynamic> mergedData,
  ) async {
    final conflict = _conflicts[conflictId];
    if (conflict == null) return;

    try {
      final apiClient = ref.read(apiClientProvider);
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      
      await _updateServerData(conflict.type, mergedData, apiClient);
      await _updateLocalData(conflict.type, mergedData, storageService);
      await storageService.removeSyncQueueItem(conflictId);
      _conflicts.remove(conflictId);
    } catch (e) {
      debugPrint('Failed to resolve conflict with merged data: $e');
    }
  }

  /// Force sync all data
  Future<void> forceSyncAll() async {
    await _triggerSync();
  }

  /// Check if device is online
  Future<bool> isOnline() async {
    final connectivity = await Connectivity().checkConnectivity();
    return connectivity != ConnectivityResult.none;
  }

  /// Get sync statistics
  Future<EnhancedSyncStatistics> getSyncStatistics() async {
    final storageService = ref.read(enhancedStorageServiceProvider.notifier);
    final syncQueue = storageService.getSyncQueue();
    final lastSyncTime = storageService.getLastSyncTime();
    final isDeviceOnline = await isOnline();

    return EnhancedSyncStatistics(
      pendingItems: syncQueue.length,
      conflictCount: _conflicts.length,
      lastSyncTime: lastSyncTime,
      isOnline: isDeviceOnline,
      isSyncing: _isSyncing,
    );
  }

  void dispose() {
    _syncTimer?.cancel();
    _connectivitySubscription?.cancel();
  }
}

/// Sync conflict representation
class SyncConflict {
  final String id;
  final String type;
  final Map<String, dynamic> localData;
  final Map<String, dynamic> serverData;
  final DateTime localTimestamp;
  final DateTime serverTimestamp;

  const SyncConflict({
    required this.id,
    required this.type,
    required this.localData,
    required this.serverData,
    required this.localTimestamp,
    required this.serverTimestamp,
  });
}

/// Sync result representation
class SyncResult {
  final bool success;
  final bool hasConflict;
  final SyncConflict? conflict;

  const SyncResult._({
    required this.success,
    required this.hasConflict,
    this.conflict,
  });

  const SyncResult.success() : this._(success: true, hasConflict: false);
  const SyncResult.failure() : this._(success: false, hasConflict: false);
  const SyncResult.conflict(SyncConflict conflict) : this._(
    success: false,
    hasConflict: true,
    conflict: conflict,
  );
}

/// Enhanced sync statistics
class EnhancedSyncStatistics {
  final int pendingItems;
  final int conflictCount;
  final DateTime? lastSyncTime;
  final bool isOnline;
  final bool isSyncing;

  const EnhancedSyncStatistics({
    required this.pendingItems,
    required this.conflictCount,
    required this.lastSyncTime,
    required this.isOnline,
    required this.isSyncing,
  });

  String get statusText {
    if (isSyncing) return 'Syncing...';
    if (!isOnline) return 'Offline';
    if (conflictCount > 0) return '$conflictCount conflicts need resolution';
    if (pendingItems > 0) return '$pendingItems items pending';
    return 'Up to date';
  }

  bool get hasIssues => !isOnline || pendingItems > 0 || conflictCount > 0;
}