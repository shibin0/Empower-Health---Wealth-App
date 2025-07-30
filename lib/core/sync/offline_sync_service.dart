import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../storage/enhanced_storage_service.dart';
// import '../api/api_client.dart';

part 'offline_sync_service.g.dart';

@riverpod
class OfflineSyncService extends _$OfflineSyncService {
  Timer? _syncTimer;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool _isSyncing = false;

  @override
  Future<SyncStatus> build() async {
    await _initializeSync();
    return const SyncStatus.idle();
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

    // Set up periodic sync (every 5 minutes when online)
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
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
    state = const AsyncValue.loading();

    try {
      final syncResult = await _performSync();
      state = AsyncValue.data(syncResult);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isSyncing = false;
    }
  }

  Future<SyncStatus> _performSync() async {
    final storageServiceAsync = ref.read(enhancedStorageServiceProvider);
    
    // Wait for storage service to be initialized
    await storageServiceAsync.when(
      data: (_) => Future.value(),
      loading: () => Future.value(),
      error: (error, stack) => throw error,
    );
    
    // Get the actual storage service instance from the notifier
    final storageService = ref.read(enhancedStorageServiceProvider.notifier);

    final syncQueue = storageService.getSyncQueue();
    if (syncQueue.isEmpty) {
      await storageService.setLastSyncTime(DateTime.now());
      return SyncStatus.completed(
        syncedItems: 0,
        failedItems: 0,
        lastSyncTime: DateTime.now(),
      );
    }

    int syncedCount = 0;
    int failedCount = 0;
    final List<String> failedItemIds = [];

    for (final item in syncQueue) {
      try {
        final success = await _syncItem(item);
        if (success) {
          await storageService.removeSyncQueueItem(item['id']);
          syncedCount++;
        } else {
          await storageService.incrementSyncRetryCount(item['id']);
          failedCount++;
          failedItemIds.add(item['id']);
        }
      } catch (e) {
        await storageService.incrementSyncRetryCount(item['id']);
        failedCount++;
        failedItemIds.add(item['id']);
      }

      // Remove items that have failed too many times
      if ((item['retryCount'] as int) >= 3) {
        await storageService.removeSyncQueueItem(item['id']);
        failedCount++;
      }
    }

    await storageService.setLastSyncTime(DateTime.now());

    return SyncStatus.completed(
      syncedItems: syncedCount,
      failedItems: failedCount,
      lastSyncTime: DateTime.now(),
      failedItemIds: failedItemIds,
    );
  }

  Future<bool> _syncItem(Map<String, dynamic> item) async {
    final type = item['type'] as String;
    final action = item['action'] as String;
    final data = item['data'] as Map<String, dynamic>;

    try {
      switch (type) {
        case 'user_profile':
          return await _syncUserProfile(action, data);
        case 'health_data':
          return await _syncHealthData(action, data);
        case 'portfolio':
          return await _syncPortfolio(action, data);
        case 'financial_goals':
          return await _syncFinancialGoals(action, data);
        case 'achievements':
          return await _syncAchievements(action, data);
        case 'tasks':
          return await _syncTasks(action, data);
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> _syncUserProfile(String action, Map<String, dynamic> data) async {
    // Implement API call to sync user profile
    // This would use the API client to send data to the server
    try {
      // Example API call (would need actual implementation)
      // await ref.read(apiClientProvider).updateUserProfile(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _syncHealthData(String action, Map<String, dynamic> data) async {
    try {
      // Example API call for health data
      // await ref.read(apiClientProvider).syncHealthData(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _syncPortfolio(String action, Map<String, dynamic> data) async {
    try {
      // Example API call for portfolio data
      // await ref.read(apiClientProvider).syncPortfolio(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _syncFinancialGoals(String action, Map<String, dynamic> data) async {
    try {
      // Example API call for financial goals
      // await ref.read(apiClientProvider).syncFinancialGoals(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _syncAchievements(String action, Map<String, dynamic> data) async {
    try {
      // Example API call for achievements
      // await ref.read(apiClientProvider).syncAchievements(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _syncTasks(String action, Map<String, dynamic> data) async {
    try {
      // Example API call for tasks
      // await ref.read(apiClientProvider).syncTasks(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Manual sync trigger
  Future<void> forcSync() async {
    await _triggerSync();
  }

  // Check if device is online
  Future<bool> isOnline() async {
    final connectivity = await Connectivity().checkConnectivity();
    return connectivity != ConnectivityResult.none;
  }

  // Get sync statistics
  Future<SyncStatistics> getSyncStatistics() async {
    final storageServiceAsync = ref.read(enhancedStorageServiceProvider);
    await storageServiceAsync.when(
      data: (_) => Future.value(),
      loading: () => Future.value(),
      error: (error, stack) => throw error,
    );

    final storageService = ref.read(enhancedStorageServiceProvider.notifier);
    final syncQueue = storageService.getSyncQueue();
    final lastSyncTime = storageService.getLastSyncTime();
    final isDeviceOnline = await isOnline();

    return SyncStatistics(
      pendingItems: syncQueue.length,
      lastSyncTime: lastSyncTime,
      isOnline: isDeviceOnline,
      isSyncing: _isSyncing,
    );
  }

  // Clear sync queue (for testing or reset purposes)
  Future<void> clearSyncQueue() async {
    final storageServiceAsync = ref.read(enhancedStorageServiceProvider);
    await storageServiceAsync.when(
      data: (_) => Future.value(),
      loading: () => Future.value(),
      error: (error, stack) => throw error,
    );

    final storageService = ref.read(enhancedStorageServiceProvider.notifier);
    final syncQueue = storageService.getSyncQueue();
    for (final item in syncQueue) {
      await storageService.removeSyncQueueItem(item['id']);
    }
  }

  // Note: dispose() is not available in riverpod_annotation generated classes
  // Cleanup is handled automatically by Riverpod
}

// Data classes for sync status and statistics
class SyncStatus {
  final SyncState state;
  final int? syncedItems;
  final int? failedItems;
  final DateTime? lastSyncTime;
  final List<String>? failedItemIds;
  final String? errorMessage;

  const SyncStatus._({
    required this.state,
    this.syncedItems,
    this.failedItems,
    this.lastSyncTime,
    this.failedItemIds,
    this.errorMessage,
  });

  const SyncStatus.idle() : this._(state: SyncState.idle);

  const SyncStatus.syncing() : this._(state: SyncState.syncing);

  const SyncStatus.completed({
    required int syncedItems,
    required int failedItems,
    required DateTime lastSyncTime,
    List<String>? failedItemIds,
  }) : this._(
          state: SyncState.completed,
          syncedItems: syncedItems,
          failedItems: failedItems,
          lastSyncTime: lastSyncTime,
          failedItemIds: failedItemIds,
        );

  const SyncStatus.error({
    required String errorMessage,
  }) : this._(
          state: SyncState.error,
          errorMessage: errorMessage,
        );
}

enum SyncState {
  idle,
  syncing,
  completed,
  error,
}

class SyncStatistics {
  final int pendingItems;
  final DateTime? lastSyncTime;
  final bool isOnline;
  final bool isSyncing;

  const SyncStatistics({
    required this.pendingItems,
    required this.lastSyncTime,
    required this.isOnline,
    required this.isSyncing,
  });

  String get statusText {
    if (isSyncing) return 'Syncing...';
    if (!isOnline) return 'Offline';
    if (pendingItems > 0) return '$pendingItems items pending';
    return 'Up to date';
  }

  bool get hasIssues => !isOnline || pendingItems > 0;
}

// Connectivity provider
@riverpod
Stream<ConnectivityResult> connectivityStream(ConnectivityStreamRef ref) {
  return Connectivity().onConnectivityChanged;
}

@riverpod
Future<bool> isDeviceOnline(IsDeviceOnlineRef ref) async {
  final connectivity = await Connectivity().checkConnectivity();
  return connectivity != ConnectivityResult.none;
}