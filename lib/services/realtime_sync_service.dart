import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../models/user_profile.dart';
import 'database_service.dart';
import 'behavior_tracking_service.dart';
import 'ai_recommendation_system.dart';
import 'ml_prediction_service.dart';
import 'personalized_content_service.dart';

// Real-time Event Models
class RealtimeEvent {
  final String id;
  final String type;
  final String table;
  final String eventType; // INSERT, UPDATE, DELETE
  final Map<String, dynamic> oldRecord;
  final Map<String, dynamic> newRecord;
  final DateTime timestamp;

  const RealtimeEvent({
    required this.id,
    required this.type,
    required this.table,
    required this.eventType,
    required this.oldRecord,
    required this.newRecord,
    required this.timestamp,
  });

  factory RealtimeEvent.fromPayload(PostgresChangePayload payload) {
    return RealtimeEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'database_change',
      table: payload.table,
      eventType: payload.eventType.name,
      oldRecord: payload.oldRecord ?? {},
      newRecord: payload.newRecord ?? {},
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'table': table,
      'eventType': eventType,
      'oldRecord': oldRecord,
      'newRecord': newRecord,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

// Sync Status
enum SyncStatus {
  disconnected,
  connecting,
  connected,
  syncing,
  error,
}

// Real-time Sync Service
class RealtimeSyncService extends ChangeNotifier {
  static final RealtimeSyncService _instance = RealtimeSyncService._internal();
  factory RealtimeSyncService() => _instance;
  RealtimeSyncService._internal();

  final SupabaseClient _supabase = SupabaseConfig.client;
  final DatabaseService _databaseService = DatabaseService();
  final BehaviorTrackingService _behaviorService = BehaviorTrackingService();
  final AIRecommendationSystem _aiSystem = AIRecommendationSystem();
  final MLPredictionService _predictionService = MLPredictionService();
  final PersonalizedContentService _contentService = PersonalizedContentService();

  RealtimeChannel? _channel;
  SyncStatus _status = SyncStatus.disconnected;
  String? _currentUserId;
  List<RealtimeEvent> _recentEvents = [];
  Map<String, DateTime> _lastSyncTimes = {};
  bool _autoSyncEnabled = true;

  // Getters
  SyncStatus get status => _status;
  String? get currentUserId => _currentUserId;
  List<RealtimeEvent> get recentEvents => _recentEvents;
  Map<String, DateTime> get lastSyncTimes => _lastSyncTimes;
  bool get autoSyncEnabled => _autoSyncEnabled;
  bool get isConnected => _status == SyncStatus.connected;

  // Initialize real-time synchronization
  Future<void> initializeSync(String userId) async {
    try {
      _currentUserId = userId;
      _status = SyncStatus.connecting;
      notifyListeners();

      await _setupRealtimeChannel();
      await _performInitialSync();

      _status = SyncStatus.connected;
      notifyListeners();

      debugPrint('Real-time sync initialized for user: $userId');
    } catch (e) {
      _status = SyncStatus.error;
      notifyListeners();
      debugPrint('Error initializing real-time sync: $e');
    }
  }

  // Setup real-time channel
  Future<void> _setupRealtimeChannel() async {
    if (_currentUserId == null) return;

    // Remove existing channel if any
    if (_channel != null) {
      await _supabase.removeChannel(_channel!);
    }

    // Create new channel for user-specific data
    _channel = _supabase.channel('user_data_${_currentUserId}');

    // Listen to profiles table changes
    _channel!.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'profiles',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'id',
        value: _currentUserId!,
      ),
      callback: (payload) => _handleRealtimeEvent('profiles', payload),
    );

    // Listen to health_goals table changes
    _channel!.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'health_goals',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'user_id',
        value: _currentUserId!,
      ),
      callback: (payload) => _handleRealtimeEvent('health_goals', payload),
    );

    // Listen to wealth_goals table changes
    _channel!.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'wealth_goals',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'user_id',
        value: _currentUserId!,
      ),
      callback: (payload) => _handleRealtimeEvent('wealth_goals', payload),
    );

    // Listen to daily_tasks table changes
    _channel!.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'daily_tasks',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'user_id',
        value: _currentUserId!,
      ),
      callback: (payload) => _handleRealtimeEvent('daily_tasks', payload),
    );

    // Listen to user_achievements table changes
    _channel!.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'user_achievements',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'user_id',
        value: _currentUserId!,
      ),
      callback: (payload) => _handleRealtimeEvent('user_achievements', payload),
    );

    // Listen to progress_entries table changes
    _channel!.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'progress_entries',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'user_id',
        value: _currentUserId!,
      ),
      callback: (payload) => _handleRealtimeEvent('progress_entries', payload),
    );

    // Listen to user_module_progress table changes
    _channel!.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'user_module_progress',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'user_id',
        value: _currentUserId!,
      ),
      callback: (payload) => _handleRealtimeEvent('user_module_progress', payload),
    );

    // Subscribe to the channel
    await _channel!.subscribe();
  }

  // Handle real-time events
  void _handleRealtimeEvent(String table, PostgresChangePayload payload) {
    final event = RealtimeEvent.fromPayload(payload);
    _recentEvents.insert(0, event);
    
    // Keep only last 50 events
    if (_recentEvents.length > 50) {
      _recentEvents = _recentEvents.take(50).toList();
    }

    // Track the event
    _behaviorService.trackEvent(
      AnalyticsEvent.featureUsed('realtime_sync', {
        'table': table,
        'event_type': payload.eventType.name,
        'timestamp': DateTime.now().toIso8601String(),
      }),
    );

    // Process the event based on table
    _processTableEvent(table, event);

    // Update last sync time
    _lastSyncTimes[table] = DateTime.now();
    
    notifyListeners();
  }

  // Process events based on table
  void _processTableEvent(String table, RealtimeEvent event) {
    switch (table) {
      case 'profiles':
        _handleProfileChange(event);
        break;
      case 'health_goals':
      case 'wealth_goals':
        _handleGoalChange(event);
        break;
      case 'daily_tasks':
        _handleTaskChange(event);
        break;
      case 'user_achievements':
        _handleAchievementChange(event);
        break;
      case 'progress_entries':
        _handleProgressChange(event);
        break;
      case 'user_module_progress':
        _handleModuleProgressChange(event);
        break;
    }
  }

  // Handle profile changes
  void _handleProfileChange(RealtimeEvent event) {
    if (event.eventType == 'UPDATE' && _autoSyncEnabled) {
      // Trigger AI system refresh when profile changes
      _refreshAIServices();
    }
  }

  // Handle goal changes
  void _handleGoalChange(RealtimeEvent event) {
    if (_autoSyncEnabled) {
      // Update predictions when goals change
      _refreshPredictions();
    }
  }

  // Handle task changes
  void _handleTaskChange(RealtimeEvent event) {
    if (event.eventType == 'UPDATE' && _autoSyncEnabled) {
      final newRecord = event.newRecord;
      if (newRecord['completed'] == true) {
        // Task completed - trigger achievement check and AI refresh
        _checkAchievements();
        _refreshAIServices();
      }
    }
  }

  // Handle achievement changes
  void _handleAchievementChange(RealtimeEvent event) {
    if (event.eventType == 'INSERT') {
      // New achievement earned - show notification
      _showAchievementNotification(event.newRecord);
    }
  }

  // Handle progress changes
  void _handleProgressChange(RealtimeEvent event) {
    if (_autoSyncEnabled) {
      // Update content recommendations when progress changes
      _refreshContentRecommendations();
    }
  }

  // Handle module progress changes
  void _handleModuleProgressChange(RealtimeEvent event) {
    if (_autoSyncEnabled) {
      // Update learning paths when module progress changes
      _refreshLearningPaths();
    }
  }

  // Perform initial sync
  Future<void> _performInitialSync() async {
    if (_currentUserId == null) return;

    _status = SyncStatus.syncing;
    notifyListeners();

    try {
      // Sync user profile
      final profile = await _databaseService.getUserProfile(_currentUserId!);
      if (profile != null) {
        // Initialize AI services with fresh data
        await _aiSystem.initializeRecommendations(profile);
        await _predictionService.initializePredictions(profile);
        await _contentService.initializeContent(profile);
      }

      // Update sync times
      final now = DateTime.now();
      _lastSyncTimes['profiles'] = now;
      _lastSyncTimes['health_goals'] = now;
      _lastSyncTimes['wealth_goals'] = now;
      _lastSyncTimes['daily_tasks'] = now;
      _lastSyncTimes['user_achievements'] = now;
      _lastSyncTimes['progress_entries'] = now;
      _lastSyncTimes['user_module_progress'] = now;

    } catch (e) {
      debugPrint('Error during initial sync: $e');
    }
  }

  // Refresh AI services
  Future<void> _refreshAIServices() async {
    if (_currentUserId == null) return;

    try {
      final profile = await _databaseService.getUserProfile(_currentUserId!);
      if (profile != null) {
        await _aiSystem.refreshRecommendations(profile);
      }
    } catch (e) {
      debugPrint('Error refreshing AI services: $e');
    }
  }

  // Refresh predictions
  Future<void> _refreshPredictions() async {
    if (_currentUserId == null) return;

    try {
      final profile = await _databaseService.getUserProfile(_currentUserId!);
      if (profile != null) {
        await _predictionService.updatePredictions(profile);
      }
    } catch (e) {
      debugPrint('Error refreshing predictions: $e');
    }
  }

  // Refresh content recommendations
  Future<void> _refreshContentRecommendations() async {
    if (_currentUserId == null) return;

    try {
      final profile = await _databaseService.getUserProfile(_currentUserId!);
      if (profile != null) {
        await _contentService.refreshContent(profile);
      }
    } catch (e) {
      debugPrint('Error refreshing content: $e');
    }
  }

  // Refresh learning paths
  Future<void> _refreshLearningPaths() async {
    // This would typically update learning path recommendations
    // based on module progress changes
    await _refreshContentRecommendations();
  }

  // Check for new achievements
  Future<void> _checkAchievements() async {
    if (_currentUserId == null) return;

    try {
      // Get user stats to check for achievement eligibility
      final stats = await _databaseService.getUserStats(_currentUserId!);
      
      // This is a simplified achievement check
      // In a real implementation, you'd have more sophisticated logic
      final completedTasks = stats['completed_tasks_count'] ?? 0;
      
      if (completedTasks == 1) {
        // Award "First Steps" achievement
        await _databaseService.awardAchievement(_currentUserId!, 'first_steps_achievement_id');
      }
      
    } catch (e) {
      debugPrint('Error checking achievements: $e');
    }
  }

  // Show achievement notification
  void _showAchievementNotification(Map<String, dynamic> achievement) {
    // This would typically show a toast or notification
    // For now, we'll just track it
    _behaviorService.trackEvent(
      AnalyticsEvent.featureUsed('achievement_earned', {
        'achievement_id': achievement['achievement_id'],
        'earned_at': achievement['earned_at'],
      }),
    );
  }

  // Manual sync trigger
  Future<void> triggerManualSync() async {
    if (_currentUserId == null) return;

    _status = SyncStatus.syncing;
    notifyListeners();

    try {
      await _performInitialSync();
      _status = SyncStatus.connected;
    } catch (e) {
      _status = SyncStatus.error;
      debugPrint('Error during manual sync: $e');
    }

    notifyListeners();
  }

  // Sync specific table
  Future<void> syncTable(String tableName) async {
    if (_currentUserId == null) return;

    try {
      _lastSyncTimes[tableName] = DateTime.now();
      
      // Trigger appropriate refresh based on table
      switch (tableName) {
        case 'profiles':
          await _refreshAIServices();
          break;
        case 'health_goals':
        case 'wealth_goals':
          await _refreshPredictions();
          break;
        case 'daily_tasks':
          await _checkAchievements();
          break;
        case 'progress_entries':
          await _refreshContentRecommendations();
          break;
        case 'user_module_progress':
          await _refreshLearningPaths();
          break;
      }
    } catch (e) {
      debugPrint('Error syncing table $tableName: $e');
    }
  }

  // Enable/disable auto-sync
  void setAutoSyncEnabled(bool enabled) {
    _autoSyncEnabled = enabled;
    notifyListeners();
  }

  // Get sync status for specific table
  DateTime? getLastSyncTime(String tableName) {
    return _lastSyncTimes[tableName];
  }

  // Get connection health
  Map<String, dynamic> getConnectionHealth() {
    final now = DateTime.now();
    final recentEventCount = _recentEvents.where((event) =>
        now.difference(event.timestamp).inMinutes < 5).length;

    return {
      'status': _status.name,
      'connected': isConnected,
      'recent_events': recentEventCount,
      'last_activity': _recentEvents.isNotEmpty
          ? _recentEvents.first.timestamp.toIso8601String()
          : null,
      'auto_sync_enabled': _autoSyncEnabled,
      'tables_synced': _lastSyncTimes.keys.toList(),
    };
  }

  // Force reconnection
  Future<void> reconnect() async {
    if (_currentUserId == null) return;

    try {
      await disconnect();
      await initializeSync(_currentUserId!);
    } catch (e) {
      debugPrint('Error during reconnection: $e');
      _status = SyncStatus.error;
      notifyListeners();
    }
  }

  // Disconnect from real-time sync
  Future<void> disconnect() async {
    try {
      if (_channel != null) {
        await _supabase.removeChannel(_channel!);
        _channel = null;
      }
      
      _status = SyncStatus.disconnected;
      _currentUserId = null;
      _recentEvents.clear();
      _lastSyncTimes.clear();
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error disconnecting: $e');
    }
  }

  // Clear event history
  void clearEventHistory() {
    _recentEvents.clear();
    notifyListeners();
  }

  // Export sync data for debugging
  Map<String, dynamic> exportSyncData() {
    return {
      'status': _status.name,
      'user_id': _currentUserId,
      'recent_events': _recentEvents.map((e) => e.toJson()).toList(),
      'last_sync_times': _lastSyncTimes.map(
        (key, value) => MapEntry(key, value.toIso8601String()),
      ),
      'auto_sync_enabled': _autoSyncEnabled,
      'connection_health': getConnectionHealth(),
    };
  }

  // Import sync data (for testing/debugging)
  void importSyncData(Map<String, dynamic> data) {
    if (data['recent_events'] != null) {
      _recentEvents = (data['recent_events'] as List)
          .map((e) => RealtimeEvent(
                id: e['id'],
                type: e['type'],
                table: e['table'],
                eventType: e['eventType'],
                oldRecord: Map<String, dynamic>.from(e['oldRecord']),
                newRecord: Map<String, dynamic>.from(e['newRecord']),
                timestamp: DateTime.parse(e['timestamp']),
              ))
          .toList();
    }
    
    if (data['last_sync_times'] != null) {
      _lastSyncTimes = (data['last_sync_times'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, DateTime.parse(value)));
    }
    
    if (data['auto_sync_enabled'] != null) {
      _autoSyncEnabled = data['auto_sync_enabled'];
    }
    
    notifyListeners();
  }

  // Batch sync multiple tables
  Future<void> batchSync(List<String> tableNames) async {
    for (final tableName in tableNames) {
      await syncTable(tableName);
    }
  }

  // Get events for specific table
  List<RealtimeEvent> getEventsForTable(String tableName) {
    return _recentEvents.where((event) => event.table == tableName).toList();
  }

  // Get events by type
  List<RealtimeEvent> getEventsByType(String eventType) {
    return _recentEvents.where((event) => event.eventType == eventType).toList();
  }

  // Check if table needs sync (based on last sync time)
  bool needsSync(String tableName, {Duration threshold = const Duration(minutes: 5)}) {
    final lastSync = _lastSyncTimes[tableName];
    if (lastSync == null) return true;
    
    return DateTime.now().difference(lastSync) > threshold;
  }

  // Auto-sync check for all tables
  Future<void> performAutoSyncCheck() async {
    if (!_autoSyncEnabled || _currentUserId == null) return;

    final tablesToSync = <String>[];
    
    for (final table in ['profiles', 'health_goals', 'wealth_goals', 'daily_tasks', 'progress_entries']) {
      if (needsSync(table)) {
        tablesToSync.add(table);
      }
    }
    
    if (tablesToSync.isNotEmpty) {
      await batchSync(tablesToSync);
    }
  }
}