import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/storage/enhanced_storage_service.dart';

// Settings models
class NotificationSettings {
  final bool pushNotifications;
  final bool emailNotifications;
  final bool lessonReminders;
  final bool quizReminders;
  final bool achievementNotifications;
  final bool weeklyProgress;
  final String reminderTime;

  NotificationSettings({
    this.pushNotifications = true,
    this.emailNotifications = true,
    this.lessonReminders = true,
    this.quizReminders = true,
    this.achievementNotifications = true,
    this.weeklyProgress = true,
    this.reminderTime = '09:00',
  });

  Map<String, dynamic> toJson() => {
    'pushNotifications': pushNotifications,
    'emailNotifications': emailNotifications,
    'lessonReminders': lessonReminders,
    'quizReminders': quizReminders,
    'achievementNotifications': achievementNotifications,
    'weeklyProgress': weeklyProgress,
    'reminderTime': reminderTime,
  };

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => NotificationSettings(
    pushNotifications: json['pushNotifications'] ?? true,
    emailNotifications: json['emailNotifications'] ?? true,
    lessonReminders: json['lessonReminders'] ?? true,
    quizReminders: json['quizReminders'] ?? true,
    achievementNotifications: json['achievementNotifications'] ?? true,
    weeklyProgress: json['weeklyProgress'] ?? true,
    reminderTime: json['reminderTime'] ?? '09:00',
  );

  NotificationSettings copyWith({
    bool? pushNotifications,
    bool? emailNotifications,
    bool? lessonReminders,
    bool? quizReminders,
    bool? achievementNotifications,
    bool? weeklyProgress,
    String? reminderTime,
  }) {
    return NotificationSettings(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      lessonReminders: lessonReminders ?? this.lessonReminders,
      quizReminders: quizReminders ?? this.quizReminders,
      achievementNotifications: achievementNotifications ?? this.achievementNotifications,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }
}

class AppSettings {
  final String theme; // 'light', 'dark', 'system'
  final String language;
  final bool offlineMode;
  final bool autoSync;
  final bool hapticFeedback;
  final bool soundEffects;
  final double fontSize;

  AppSettings({
    this.theme = 'system',
    this.language = 'en',
    this.offlineMode = false,
    this.autoSync = true,
    this.hapticFeedback = true,
    this.soundEffects = true,
    this.fontSize = 16.0,
  });

  Map<String, dynamic> toJson() => {
    'theme': theme,
    'language': language,
    'offlineMode': offlineMode,
    'autoSync': autoSync,
    'hapticFeedback': hapticFeedback,
    'soundEffects': soundEffects,
    'fontSize': fontSize,
  };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
    theme: json['theme'] ?? 'system',
    language: json['language'] ?? 'en',
    offlineMode: json['offlineMode'] ?? false,
    autoSync: json['autoSync'] ?? true,
    hapticFeedback: json['hapticFeedback'] ?? true,
    soundEffects: json['soundEffects'] ?? true,
    fontSize: json['fontSize']?.toDouble() ?? 16.0,
  );

  AppSettings copyWith({
    String? theme,
    String? language,
    bool? offlineMode,
    bool? autoSync,
    bool? hapticFeedback,
    bool? soundEffects,
    double? fontSize,
  }) {
    return AppSettings(
      theme: theme ?? this.theme,
      language: language ?? this.language,
      offlineMode: offlineMode ?? this.offlineMode,
      autoSync: autoSync ?? this.autoSync,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
      soundEffects: soundEffects ?? this.soundEffects,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}

class PrivacySettings {
  final bool dataCollection;
  final bool analytics;
  final bool crashReporting;
  final bool personalizedAds;
  final bool shareProgress;

  PrivacySettings({
    this.dataCollection = true,
    this.analytics = true,
    this.crashReporting = true,
    this.personalizedAds = false,
    this.shareProgress = true,
  });

  Map<String, dynamic> toJson() => {
    'dataCollection': dataCollection,
    'analytics': analytics,
    'crashReporting': crashReporting,
    'personalizedAds': personalizedAds,
    'shareProgress': shareProgress,
  };

  factory PrivacySettings.fromJson(Map<String, dynamic> json) => PrivacySettings(
    dataCollection: json['dataCollection'] ?? true,
    analytics: json['analytics'] ?? true,
    crashReporting: json['crashReporting'] ?? true,
    personalizedAds: json['personalizedAds'] ?? false,
    shareProgress: json['shareProgress'] ?? true,
  );

  PrivacySettings copyWith({
    bool? dataCollection,
    bool? analytics,
    bool? crashReporting,
    bool? personalizedAds,
    bool? shareProgress,
  }) {
    return PrivacySettings(
      dataCollection: dataCollection ?? this.dataCollection,
      analytics: analytics ?? this.analytics,
      crashReporting: crashReporting ?? this.crashReporting,
      personalizedAds: personalizedAds ?? this.personalizedAds,
      shareProgress: shareProgress ?? this.shareProgress,
    );
  }
}

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  final EnhancedStorageService _storage = EnhancedStorageService();

  // Notification Settings
  Future<NotificationSettings> getNotificationSettings() async {
    try {
      final data = _storage.getCachedData('notification_settings');
      if (data != null) {
        return NotificationSettings.fromJson(Map<String, dynamic>.from(data));
      }
    } catch (e) {
      print('Error loading notification settings: $e');
    }
    return NotificationSettings();
  }

  Future<void> saveNotificationSettings(NotificationSettings settings) async {
    try {
      await _storage.cacheData('notification_settings', settings.toJson());
    } catch (e) {
      print('Error saving notification settings: $e');
    }
  }

  // App Settings
  Future<AppSettings> getAppSettings() async {
    try {
      final data = _storage.getCachedData('app_settings');
      if (data != null) {
        return AppSettings.fromJson(Map<String, dynamic>.from(data));
      }
    } catch (e) {
      print('Error loading app settings: $e');
    }
    return AppSettings();
  }

  Future<void> saveAppSettings(AppSettings settings) async {
    try {
      await _storage.cacheData('app_settings', settings.toJson());
    } catch (e) {
      print('Error saving app settings: $e');
    }
  }

  // Privacy Settings
  Future<PrivacySettings> getPrivacySettings() async {
    try {
      final data = _storage.getCachedData('privacy_settings');
      if (data != null) {
        return PrivacySettings.fromJson(Map<String, dynamic>.from(data));
      }
    } catch (e) {
      print('Error loading privacy settings: $e');
    }
    return PrivacySettings();
  }

  Future<void> savePrivacySettings(PrivacySettings settings) async {
    try {
      await _storage.cacheData('privacy_settings', settings.toJson());
    } catch (e) {
      print('Error saving privacy settings: $e');
    }
  }

  // Clear all settings
  Future<void> clearAllSettings() async {
    try {
      await _storage.clearCache();
    } catch (e) {
      print('Error clearing settings: $e');
    }
  }

  // Export settings
  Future<Map<String, dynamic>> exportSettings() async {
    try {
      final notifications = await getNotificationSettings();
      final app = await getAppSettings();
      final privacy = await getPrivacySettings();

      return {
        'notifications': notifications.toJson(),
        'app': app.toJson(),
        'privacy': privacy.toJson(),
        'exportDate': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      print('Error exporting settings: $e');
      return {};
    }
  }

  // Import settings
  Future<void> importSettings(Map<String, dynamic> settingsData) async {
    try {
      if (settingsData['notifications'] != null) {
        final notifications = NotificationSettings.fromJson(
          Map<String, dynamic>.from(settingsData['notifications'])
        );
        await saveNotificationSettings(notifications);
      }

      if (settingsData['app'] != null) {
        final app = AppSettings.fromJson(
          Map<String, dynamic>.from(settingsData['app'])
        );
        await saveAppSettings(app);
      }

      if (settingsData['privacy'] != null) {
        final privacy = PrivacySettings.fromJson(
          Map<String, dynamic>.from(settingsData['privacy'])
        );
        await savePrivacySettings(privacy);
      }
    } catch (e) {
      print('Error importing settings: $e');
      rethrow;
    }
  }
}

// Providers
final settingsServiceProvider = Provider<SettingsService>((ref) {
  return SettingsService();
});

final notificationSettingsProvider = FutureProvider<NotificationSettings>((ref) async {
  final service = ref.read(settingsServiceProvider);
  return await service.getNotificationSettings();
});

final appSettingsProvider = FutureProvider<AppSettings>((ref) async {
  final service = ref.read(settingsServiceProvider);
  return await service.getAppSettings();
});

final privacySettingsProvider = FutureProvider<PrivacySettings>((ref) async {
  final service = ref.read(settingsServiceProvider);
  return await service.getPrivacySettings();
});