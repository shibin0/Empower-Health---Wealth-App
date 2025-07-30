import 'package:hive_flutter/hive_flutter.dart';
import '../models/app_state_model.dart';
import '../models/user_profile.dart';
import '../models/achievement.dart';
import '../models/task.dart';

class HiveService {
  static const String _appStateBoxName = 'app_state';
  static const String _userProfileBoxName = 'user_profile';
  static const String _achievementsBoxName = 'achievements';
  static const String _tasksBoxName = 'tasks';

  static late Box<Map<dynamic, dynamic>> _appStateBox;
  static late Box<Map<dynamic, dynamic>> _userProfileBox;
  static late Box<Map<dynamic, dynamic>> _achievementsBox;
  static late Box<Map<dynamic, dynamic>> _tasksBox;

  /// Initialize Hive and open all boxes
  static Future<void> init() async {
    // Initialize Hive
    await Hive.initFlutter();
    
    // Open boxes
    _appStateBox = await Hive.openBox<Map<dynamic, dynamic>>(_appStateBoxName);
    _userProfileBox = await Hive.openBox<Map<dynamic, dynamic>>(_userProfileBoxName);
    _achievementsBox = await Hive.openBox<Map<dynamic, dynamic>>(_achievementsBoxName);
    _tasksBox = await Hive.openBox<Map<dynamic, dynamic>>(_tasksBoxName);
  }

  /// Save app state to Hive
  static Future<void> saveAppState(AppStateModel appState) async {
    await _appStateBox.put('current', appState.toJson());
  }

  /// Load app state from Hive
  static AppStateModel? loadAppState() {
    final data = _appStateBox.get('current');
    if (data != null) {
      try {
        return AppStateModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        // If there's an error parsing, return null to use default state
        return null;
      }
    }
    return null;
  }

  /// Save user profile to Hive
  static Future<void> saveUserProfile(UserProfile userProfile) async {
    await _userProfileBox.put('current', userProfile.toJson());
  }

  /// Load user profile from Hive
  static UserProfile? loadUserProfile() {
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

  /// Save achievements list to Hive
  static Future<void> saveAchievements(List<Achievement> achievements) async {
    final achievementsJson = achievements.map((a) => a.toJson()).toList();
    await _achievementsBox.put('list', {'achievements': achievementsJson});
  }

  /// Load achievements list from Hive
  static List<Achievement> loadAchievements() {
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

  /// Save tasks list to Hive
  static Future<void> saveTasks(List<Task> tasks) async {
    final tasksJson = tasks.map((t) => t.toJson()).toList();
    await _tasksBox.put('list', {'tasks': tasksJson});
  }

  /// Load tasks list from Hive
  static List<Task> loadTasks() {
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

  /// Clear all stored data (useful for logout)
  static Future<void> clearAll() async {
    await _appStateBox.clear();
    await _userProfileBox.clear();
    await _achievementsBox.clear();
    await _tasksBox.clear();
  }

  /// Close all boxes (call on app termination)
  static Future<void> close() async {
    await _appStateBox.close();
    await _userProfileBox.close();
    await _achievementsBox.close();
    await _tasksBox.close();
  }
}