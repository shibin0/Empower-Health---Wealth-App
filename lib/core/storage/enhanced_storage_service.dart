import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/app_state_model.dart';
import '../models/user_profile.dart';
import '../models/achievement.dart';
import '../models/task.dart';
import '../../features/health/models/health_data.dart';
import '../../features/wealth/models/financial_data.dart';

part 'enhanced_storage_service.g.dart';

@riverpod
class EnhancedStorageService extends _$EnhancedStorageService {
  // Box names
  static const String _appStateBoxName = 'app_state_v2';
  static const String _userProfileBoxName = 'user_profile_v2';
  static const String _achievementsBoxName = 'achievements_v2';
  static const String _tasksBoxName = 'tasks_v2';
  static const String _healthDataBoxName = 'health_data_v2';
  static const String _wealthDataBoxName = 'wealth_data_v2';
  static const String _cacheBoxName = 'cache_v2';
  static const String _syncQueueBoxName = 'sync_queue_v2';

  // Boxes
  late Box<Map<dynamic, dynamic>> _appStateBox;
  late Box<Map<dynamic, dynamic>> _userProfileBox;
  late Box<Map<dynamic, dynamic>> _achievementsBox;
  late Box<Map<dynamic, dynamic>> _tasksBox;
  late Box<Map<dynamic, dynamic>> _healthDataBox;
  late Box<Map<dynamic, dynamic>> _wealthDataBox;
  late Box<Map<dynamic, dynamic>> _cacheBox;
  late Box<Map<dynamic, dynamic>> _syncQueueBox;

  @override
  Future<void> build() async {
    await _initializeStorage();
  }

  /// Initialize all storage boxes
  Future<void> _initializeStorage() async {
    await Hive.initFlutter();
    
    // Open all boxes
    _appStateBox = await Hive.openBox<Map<dynamic, dynamic>>(_appStateBoxName);
    _userProfileBox = await Hive.openBox<Map<dynamic, dynamic>>(_userProfileBoxName);
    _achievementsBox = await Hive.openBox<Map<dynamic, dynamic>>(_achievementsBoxName);
    _tasksBox = await Hive.openBox<Map<dynamic, dynamic>>(_tasksBoxName);
    _healthDataBox = await Hive.openBox<Map<dynamic, dynamic>>(_healthDataBoxName);
    _wealthDataBox = await Hive.openBox<Map<dynamic, dynamic>>(_wealthDataBoxName);
    _cacheBox = await Hive.openBox<Map<dynamic, dynamic>>(_cacheBoxName);
    _syncQueueBox = await Hive.openBox<Map<dynamic, dynamic>>(_syncQueueBoxName);

    // Perform any necessary migrations
    await _performMigrations();
  }

  /// Perform data migrations if needed
  Future<void> _performMigrations() async {
    final currentVersion = await getStorageVersion();
    const latestVersion = 2;

    if (currentVersion < latestVersion) {
      await _migrateFromV1ToV2();
      await setStorageVersion(latestVersion);
    }
  }

  /// Migrate from version 1 to version 2
  Future<void> _migrateFromV1ToV2() async {
    // Migration logic for existing data
    // This would handle migrating from the old HiveService format
    try {
      // Check if old boxes exist and migrate data
      if (await Hive.boxExists('app_state')) {
        final oldBox = await Hive.openBox('app_state');
        final oldData = oldBox.get('current');
        if (oldData != null) {
          await _appStateBox.put('current', oldData);
        }
        await oldBox.deleteFromDisk();
      }

      // Similar migration for other boxes...
    } catch (e) {
      // Log migration errors but don't fail
      print('Migration warning: $e');
    }
  }

  // App State Management
  Future<void> saveAppState(AppStateModel appState) async {
    await _appStateBox.put('current', appState.toJson());
    await _addToSyncQueue('app_state', 'update', appState.toJson());
  }

  AppStateModel? loadAppState() {
    final data = _appStateBox.get('current');
    if (data != null) {
      try {
        return AppStateModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // User Profile Management
  Future<void> saveUserProfile(UserProfile userProfile) async {
    await _userProfileBox.put('current', userProfile.toJson());
    await _addToSyncQueue('user_profile', 'update', userProfile.toJson());
  }

  UserProfile? loadUserProfile() {
    final data = _userProfileBox.get('current');
    if (data != null) {
      try {
        return UserProfile.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Achievements Management
  Future<void> saveAchievements(List<Achievement> achievements) async {
    final achievementsJson = achievements.map((a) => a.toJson()).toList();
    await _achievementsBox.put('list', {'achievements': achievementsJson});
    await _addToSyncQueue('achievements', 'update', {'achievements': achievementsJson});
  }

  List<Achievement> loadAchievements() {
    final data = _achievementsBox.get('list');
    if (data != null && data['achievements'] != null) {
      try {
        final List<dynamic> achievementsJson = data['achievements'];
        return achievementsJson
            .map((json) => Achievement.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  // Tasks Management
  Future<void> saveTasks(List<Task> tasks) async {
    final tasksJson = tasks.map((t) => t.toJson()).toList();
    await _tasksBox.put('list', {'tasks': tasksJson});
    await _addToSyncQueue('tasks', 'update', {'tasks': tasksJson});
  }

  List<Task> loadTasks() {
    final data = _tasksBox.get('list');
    if (data != null && data['tasks'] != null) {
      try {
        final List<dynamic> tasksJson = data['tasks'];
        return tasksJson
            .map((json) => Task.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  // Health Data Management
  Future<void> saveHealthData(List<HealthData> healthDataList) async {
    final healthDataJson = healthDataList.map((h) => h.toJson()).toList();
    await _healthDataBox.put('list', {'health_data': healthDataJson});
    await _addToSyncQueue('health_data', 'update', {'health_data': healthDataJson});
  }

  Future<void> addHealthDataEntry(HealthData healthData) async {
    final existingData = loadHealthData();
    existingData.add(healthData);
    await saveHealthData(existingData);
  }

  List<HealthData> loadHealthData() {
    final data = _healthDataBox.get('list');
    if (data != null && data['health_data'] != null) {
      try {
        final List<dynamic> healthDataJson = data['health_data'];
        return healthDataJson
            .map((json) => HealthData.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  List<HealthData> getHealthDataByType(HealthMetricType type) {
    final allData = loadHealthData();
    return allData.where((data) => data.type == type).toList();
  }

  List<HealthData> getHealthDataByDateRange(DateTime start, DateTime end) {
    final allData = loadHealthData();
    return allData.where((data) => 
      data.timestamp.isAfter(start) && data.timestamp.isBefore(end)
    ).toList();
  }

  // Wealth Data Management
  Future<void> savePortfolio(Portfolio portfolio) async {
    await _wealthDataBox.put('portfolio', portfolio.toJson());
    await _addToSyncQueue('portfolio', 'update', portfolio.toJson());
  }

  Portfolio? loadPortfolio() {
    final data = _wealthDataBox.get('portfolio');
    if (data != null) {
      try {
        return Portfolio.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<void> saveFinancialGoals(List<FinancialGoal> goals) async {
    final goalsJson = goals.map((g) => g.toJson()).toList();
    await _wealthDataBox.put('financial_goals', {'goals': goalsJson});
    await _addToSyncQueue('financial_goals', 'update', {'goals': goalsJson});
  }

  List<FinancialGoal> loadFinancialGoals() {
    final data = _wealthDataBox.get('financial_goals');
    if (data != null && data['goals'] != null) {
      try {
        final List<dynamic> goalsJson = data['goals'];
        return goalsJson
            .map((json) => FinancialGoal.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  // Cache Management
  Future<void> cacheData(String key, Map<String, dynamic> data, {Duration? ttl}) async {
    final cacheEntry = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'ttl': ttl?.inMilliseconds,
    };
    await _cacheBox.put(key, cacheEntry);
  }

  Map<String, dynamic>? getCachedData(String key) {
    final cacheEntry = _cacheBox.get(key);
    if (cacheEntry != null) {
      final timestamp = cacheEntry['timestamp'] as int;
      final ttl = cacheEntry['ttl'] as int?;
      
      if (ttl != null) {
        final expiryTime = timestamp + ttl;
        if (DateTime.now().millisecondsSinceEpoch > expiryTime) {
          // Cache expired, remove it
          _cacheBox.delete(key);
          return null;
        }
      }
      
      return Map<String, dynamic>.from(cacheEntry['data']);
    }
    return null;
  }

  Future<void> clearCache() async {
    await _cacheBox.clear();
  }

  Future<void> clearExpiredCache() async {
    final keys = _cacheBox.keys.toList();
    for (final key in keys) {
      getCachedData(key.toString()); // This will remove expired entries
    }
  }

  // Sync Queue Management
  Future<void> _addToSyncQueue(String type, String action, Map<String, dynamic> data) async {
    final syncItem = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'type': type,
      'action': action,
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'retryCount': 0,
    };
    
    await _syncQueueBox.put(syncItem['id'], syncItem);
  }

  List<Map<String, dynamic>> getSyncQueue() {
    return _syncQueueBox.values
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  Future<void> removeSyncQueueItem(String id) async {
    await _syncQueueBox.delete(id);
  }

  Future<void> incrementSyncRetryCount(String id) async {
    final item = _syncQueueBox.get(id);
    if (item != null) {
      final updatedItem = Map<String, dynamic>.from(item);
      updatedItem['retryCount'] = (updatedItem['retryCount'] as int) + 1;
      await _syncQueueBox.put(id, updatedItem);
    }
  }

  // Storage Metadata
  Future<void> setStorageVersion(int version) async {
    await _cacheBox.put('storage_version', {'version': version});
  }

  Future<int> getStorageVersion() async {
    final data = _cacheBox.get('storage_version');
    return data?['version'] ?? 1;
  }

  Future<void> setLastSyncTime(DateTime time) async {
    await _cacheBox.put('last_sync_time', {'timestamp': time.millisecondsSinceEpoch});
  }

  DateTime? getLastSyncTime() {
    final data = _cacheBox.get('last_sync_time');
    if (data != null) {
      return DateTime.fromMillisecondsSinceEpoch(data['timestamp']);
    }
    return null;
  }

  // Storage Statistics
  Map<String, dynamic> getStorageStats() {
    return {
      'app_state_size': _appStateBox.length,
      'user_profile_size': _userProfileBox.length,
      'achievements_size': _achievementsBox.length,
      'tasks_size': _tasksBox.length,
      'health_data_size': _healthDataBox.length,
      'wealth_data_size': _wealthDataBox.length,
      'cache_size': _cacheBox.length,
      'sync_queue_size': _syncQueueBox.length,
      'total_entries': _appStateBox.length + _userProfileBox.length + 
                      _achievementsBox.length + _tasksBox.length +
                      _healthDataBox.length + _wealthDataBox.length +
                      _cacheBox.length + _syncQueueBox.length,
    };
  }

  // Cleanup and Maintenance
  Future<void> clearAllData() async {
    await _appStateBox.clear();
    await _userProfileBox.clear();
    await _achievementsBox.clear();
    await _tasksBox.clear();
    await _healthDataBox.clear();
    await _wealthDataBox.clear();
    await _cacheBox.clear();
    await _syncQueueBox.clear();
  }

  Future<void> clearUserData() async {
    await _userProfileBox.clear();
    await _achievementsBox.clear();
    await _tasksBox.clear();
    await _healthDataBox.clear();
    await _wealthDataBox.clear();
    await _syncQueueBox.clear();
  }

  Future<void> closeAllBoxes() async {
    await _appStateBox.close();
    await _userProfileBox.close();
    await _achievementsBox.close();
    await _tasksBox.close();
    await _healthDataBox.close();
    await _wealthDataBox.close();
    await _cacheBox.close();
    await _syncQueueBox.close();
  }

  // Backup and Restore
  Future<Map<String, dynamic>> exportData() async {
    return {
      'app_state': _appStateBox.get('current'),
      'user_profile': _userProfileBox.get('current'),
      'achievements': _achievementsBox.get('list'),
      'tasks': _tasksBox.get('list'),
      'health_data': _healthDataBox.get('list'),
      'wealth_data': {
        'portfolio': _wealthDataBox.get('portfolio'),
        'financial_goals': _wealthDataBox.get('financial_goals'),
      },
      'export_timestamp': DateTime.now().millisecondsSinceEpoch,
      'storage_version': await getStorageVersion(),
    };
  }

  Future<void> importData(Map<String, dynamic> data) async {
    try {
      if (data['app_state'] != null) {
        await _appStateBox.put('current', data['app_state']);
      }
      if (data['user_profile'] != null) {
        await _userProfileBox.put('current', data['user_profile']);
      }
      if (data['achievements'] != null) {
        await _achievementsBox.put('list', data['achievements']);
      }
      if (data['tasks'] != null) {
        await _tasksBox.put('list', data['tasks']);
      }
      if (data['health_data'] != null) {
        await _healthDataBox.put('list', data['health_data']);
      }
      if (data['wealth_data'] != null) {
        final wealthData = data['wealth_data'] as Map<String, dynamic>;
        if (wealthData['portfolio'] != null) {
          await _wealthDataBox.put('portfolio', wealthData['portfolio']);
        }
        if (wealthData['financial_goals'] != null) {
          await _wealthDataBox.put('financial_goals', wealthData['financial_goals']);
        }
      }
    } catch (e) {
      throw Exception('Failed to import data: $e');
    }
  }
}