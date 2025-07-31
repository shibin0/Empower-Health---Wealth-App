import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import '../models/user_profile.dart';
import 'database_service.dart';
import 'realtime_sync_service.dart';

// Cache Entry Model
class CacheEntry {
  final String key;
  final Map<String, dynamic> data;
  final DateTime timestamp;
  final DateTime? expiresAt;
  final bool isDirty; // Needs to be synced to server

  const CacheEntry({
    required this.key,
    required this.data,
    required this.timestamp,
    this.expiresAt,
    this.isDirty = false,
  });

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isValid => !isExpired;

  CacheEntry copyWith({
    String? key,
    Map<String, dynamic>? data,
    DateTime? timestamp,
    DateTime? expiresAt,
    bool? isDirty,
  }) {
    return CacheEntry(
      key: key ?? this.key,
      data: data ?? this.data,
      timestamp: timestamp ?? this.timestamp,
      expiresAt: expiresAt ?? this.expiresAt,
      isDirty: isDirty ?? this.isDirty,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'isDirty': isDirty,
    };
  }

  factory CacheEntry.fromJson(Map<String, dynamic> json) {
    return CacheEntry(
      key: json['key'],
      data: Map<String, dynamic>.from(json['data']),
      timestamp: DateTime.parse(json['timestamp']),
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      isDirty: json['isDirty'] ?? false,
    );
  }
}

// Cache Strategy
enum CacheStrategy {
  cacheFirst,    // Try cache first, fallback to network
  networkFirst,  // Try network first, fallback to cache
  cacheOnly,     // Only use cache
  networkOnly,   // Only use network
  staleWhileRevalidate, // Return cache immediately, update in background
}

// Offline Cache Service
class OfflineCacheService extends ChangeNotifier {
  static final OfflineCacheService _instance = OfflineCacheService._internal();
  factory OfflineCacheService() => _instance;
  OfflineCacheService._internal();

  final DatabaseService _databaseService = DatabaseService();
  final RealtimeSyncService _syncService = RealtimeSyncService();

  SharedPreferences? _prefs;
  Map<String, CacheEntry> _memoryCache = {};
  bool _isInitialized = false;
  bool _isOnline = true;
  List<String> _pendingSyncKeys = [];

  // Cache configuration
  static const Duration _defaultTTL = Duration(hours: 24);
  static const int _maxMemoryCacheSize = 100;
  static const String _cachePrefix = 'empower_cache_';
  static const String _pendingSyncPrefix = 'pending_sync_';

  // Getters
  bool get isInitialized => _isInitialized;
  bool get isOnline => _isOnline;
  List<String> get pendingSyncKeys => _pendingSyncKeys;
  int get memoryCacheSize => _memoryCache.length;

  // Initialize cache service
  Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      await _loadMemoryCache();
      await _loadPendingSyncKeys();
      _isInitialized = true;
      
      // Start periodic cleanup
      _startPeriodicCleanup();
      
      debugPrint('Offline cache service initialized');
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing cache service: $e');
    }
  }

  // Set online/offline status
  void setOnlineStatus(bool online) {
    if (_isOnline != online) {
      _isOnline = online;
      notifyListeners();
      
      if (online) {
        _syncPendingChanges();
      }
    }
  }

  // Cache data with strategy
  Future<T?> cacheData<T>({
    required String key,
    required Future<T> Function() networkCall,
    required T Function(Map<String, dynamic>) fromJson,
    CacheStrategy strategy = CacheStrategy.cacheFirst,
    Duration? ttl,
  }) async {
    if (!_isInitialized) await initialize();

    final cacheKey = _getCacheKey(key);
    ttl ??= _defaultTTL;

    switch (strategy) {
      case CacheStrategy.cacheFirst:
        return await _cacheFirstStrategy<T>(cacheKey, networkCall, fromJson, ttl);
      case CacheStrategy.networkFirst:
        return await _networkFirstStrategy<T>(cacheKey, networkCall, fromJson, ttl);
      case CacheStrategy.cacheOnly:
        return await _cacheOnlyStrategy<T>(cacheKey, fromJson);
      case CacheStrategy.networkOnly:
        return await _networkOnlyStrategy<T>(networkCall);
      case CacheStrategy.staleWhileRevalidate:
        return await _staleWhileRevalidateStrategy<T>(cacheKey, networkCall, fromJson, ttl);
    }
  }

  // Cache first strategy
  Future<T?> _cacheFirstStrategy<T>(
    String cacheKey,
    Future<T> Function() networkCall,
    T Function(Map<String, dynamic>) fromJson,
    Duration ttl,
  ) async {
    // Try cache first
    final cached = await _getFromCache<T>(cacheKey, fromJson);
    if (cached != null) {
      return cached;
    }

    // Fallback to network
    if (_isOnline) {
      try {
        final result = await networkCall();
        await _saveToCache(cacheKey, result, ttl);
        return result;
      } catch (e) {
        debugPrint('Network call failed in cache-first strategy: $e');
        return null;
      }
    }

    return null;
  }

  // Network first strategy
  Future<T?> _networkFirstStrategy<T>(
    String cacheKey,
    Future<T> Function() networkCall,
    T Function(Map<String, dynamic>) fromJson,
    Duration ttl,
  ) async {
    if (_isOnline) {
      try {
        final result = await networkCall();
        await _saveToCache(cacheKey, result, ttl);
        return result;
      } catch (e) {
        debugPrint('Network call failed, trying cache: $e');
      }
    }

    // Fallback to cache
    return await _getFromCache<T>(cacheKey, fromJson);
  }

  // Cache only strategy
  Future<T?> _cacheOnlyStrategy<T>(
    String cacheKey,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    return await _getFromCache<T>(cacheKey, fromJson);
  }

  // Network only strategy
  Future<T?> _networkOnlyStrategy<T>(Future<T> Function() networkCall) async {
    if (!_isOnline) return null;

    try {
      return await networkCall();
    } catch (e) {
      debugPrint('Network-only call failed: $e');
      return null;
    }
  }

  // Stale while revalidate strategy
  Future<T?> _staleWhileRevalidateStrategy<T>(
    String cacheKey,
    Future<T> Function() networkCall,
    T Function(Map<String, dynamic>) fromJson,
    Duration ttl,
  ) async {
    // Get cached data immediately
    final cached = await _getFromCache<T>(cacheKey, fromJson);

    // Update in background if online
    if (_isOnline) {
      _updateCacheInBackground(cacheKey, networkCall, ttl);
    }

    return cached;
  }

  // Update cache in background
  void _updateCacheInBackground<T>(
    String cacheKey,
    Future<T> Function() networkCall,
    Duration ttl,
  ) async {
    try {
      final result = await networkCall();
      await _saveToCache(cacheKey, result, ttl);
      notifyListeners(); // Notify listeners of cache update
    } catch (e) {
      debugPrint('Background cache update failed: $e');
    }
  }

  // Get data from cache
  Future<T?> _getFromCache<T>(
    String cacheKey,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    // Check memory cache first
    final memoryEntry = _memoryCache[cacheKey];
    if (memoryEntry != null && memoryEntry.isValid) {
      return fromJson(memoryEntry.data);
    }

    // Check persistent cache
    final persistentData = _prefs?.getString(cacheKey);
    if (persistentData != null) {
      try {
        final entryJson = json.decode(persistentData);
        final entry = CacheEntry.fromJson(entryJson);
        
        if (entry.isValid) {
          // Update memory cache
          _memoryCache[cacheKey] = entry;
          _trimMemoryCache();
          return fromJson(entry.data);
        } else {
          // Remove expired entry
          await _removeFromCache(cacheKey);
        }
      } catch (e) {
        debugPrint('Error parsing cached data: $e');
        await _removeFromCache(cacheKey);
      }
    }

    return null;
  }

  // Save data to cache
  Future<void> _saveToCache<T>(String cacheKey, T data, Duration ttl) async {
    try {
      final dataMap = _toMap(data);
      final entry = CacheEntry(
        key: cacheKey,
        data: dataMap,
        timestamp: DateTime.now(),
        expiresAt: DateTime.now().add(ttl),
      );

      // Save to memory cache
      _memoryCache[cacheKey] = entry;
      _trimMemoryCache();

      // Save to persistent cache
      await _prefs?.setString(cacheKey, json.encode(entry.toJson()));
    } catch (e) {
      debugPrint('Error saving to cache: $e');
    }
  }

  // Convert object to map
  Map<String, dynamic> _toMap<T>(T data) {
    if (data is Map<String, dynamic>) {
      return data;
    } else if (data is UserProfile) {
      return data.toJson();
    } else if (data is List) {
      return {'list': data.map((item) => _toMap(item)).toList()};
    } else {
      // For primitive types or unknown objects
      return {'value': data};
    }
  }

  // Remove from cache
  Future<void> _removeFromCache(String cacheKey) async {
    _memoryCache.remove(cacheKey);
    await _prefs?.remove(cacheKey);
  }

  // Cache dirty data (needs sync)
  Future<void> cacheDirtyData(String key, Map<String, dynamic> data) async {
    if (!_isInitialized) await initialize();

    final cacheKey = _getCacheKey(key);
    final entry = CacheEntry(
      key: cacheKey,
      data: data,
      timestamp: DateTime.now(),
      isDirty: true,
    );

    // Save to memory and persistent cache
    _memoryCache[cacheKey] = entry;
    await _prefs?.setString(cacheKey, json.encode(entry.toJson()));

    // Add to pending sync
    if (!_pendingSyncKeys.contains(key)) {
      _pendingSyncKeys.add(key);
      await _savePendingSyncKeys();
    }

    notifyListeners();
  }

  // Sync pending changes
  Future<void> _syncPendingChanges() async {
    if (!_isOnline || _pendingSyncKeys.isEmpty) return;

    final keysToSync = List<String>.from(_pendingSyncKeys);
    
    for (final key in keysToSync) {
      try {
        await _syncSingleItem(key);
        _pendingSyncKeys.remove(key);
      } catch (e) {
        debugPrint('Error syncing item $key: $e');
      }
    }

    await _savePendingSyncKeys();
    notifyListeners();
  }

  // Sync single item
  Future<void> _syncSingleItem(String key) async {
    final cacheKey = _getCacheKey(key);
    final entry = _memoryCache[cacheKey];
    
    if (entry == null || !entry.isDirty) return;

    // Determine sync action based on key pattern
    if (key.startsWith('profile_')) {
      await _syncProfile(entry.data);
    } else if (key.startsWith('health_goal_')) {
      await _syncHealthGoal(entry.data);
    } else if (key.startsWith('wealth_goal_')) {
      await _syncWealthGoal(entry.data);
    } else if (key.startsWith('daily_task_')) {
      await _syncDailyTask(entry.data);
    } else if (key.startsWith('progress_entry_')) {
      await _syncProgressEntry(entry.data);
    }

    // Mark as clean
    final cleanEntry = entry.copyWith(isDirty: false);
    _memoryCache[cacheKey] = cleanEntry;
    await _prefs?.setString(cacheKey, json.encode(cleanEntry.toJson()));
  }

  // Sync methods for different data types
  Future<void> _syncProfile(Map<String, dynamic> data) async {
    final profile = UserProfile.fromJson(data);
    await _databaseService.updateUserProfile(profile);
  }

  Future<void> _syncHealthGoal(Map<String, dynamic> data) async {
    if (data['id'] != null) {
      await _databaseService.updateHealthGoal(data['id'], data);
    } else {
      await _databaseService.createHealthGoal(data);
    }
  }

  Future<void> _syncWealthGoal(Map<String, dynamic> data) async {
    if (data['id'] != null) {
      await _databaseService.updateWealthGoal(data['id'], data);
    } else {
      await _databaseService.createWealthGoal(data);
    }
  }

  Future<void> _syncDailyTask(Map<String, dynamic> data) async {
    if (data['id'] != null) {
      await _databaseService.updateDailyTask(data['id'], data);
    } else {
      await _databaseService.createDailyTask(data);
    }
  }

  Future<void> _syncProgressEntry(Map<String, dynamic> data) async {
    await _databaseService.createProgressEntry(data);
  }

  // Utility methods
  String _getCacheKey(String key) => '$_cachePrefix$key';

  void _trimMemoryCache() {
    if (_memoryCache.length > _maxMemoryCacheSize) {
      // Remove oldest entries
      final sortedEntries = _memoryCache.entries.toList()
        ..sort((a, b) => a.value.timestamp.compareTo(b.value.timestamp));
      
      final entriesToRemove = sortedEnt