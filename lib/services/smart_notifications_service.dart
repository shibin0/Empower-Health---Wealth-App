import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import 'progress_tracking_service.dart';
import 'auth_service.dart';
import 'simple_onboarding_service.dart';

class SmartNotificationsService {
  static final SmartNotificationsService _instance = SmartNotificationsService._internal();
  factory SmartNotificationsService() => _instance;
  SmartNotificationsService._internal();

  bool _isInitialized = false;
  Timer? _dailyCheckTimer;
  Timer? _weeklyReviewTimer;
  Timer? _streakReminderTimer;

  // In-app notification callbacks
  Function(String title, String message, String type)? onNotificationGenerated;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _isInitialized = true;
      
      // Start periodic checks
      _startPeriodicChecks();
      
      debugPrint('Smart Notifications Service initialized successfully');
    } catch (e) {
      debugPrint('Error initializing Smart Notifications Service: $e');
    }
  }

  void _startPeriodicChecks() {
    // Daily check every 24 hours
    _dailyCheckTimer = Timer.periodic(const Duration(hours: 24), (timer) {
      _performDailyCheck();
    });

    // Weekly review every 7 days
    _weeklyReviewTimer = Timer.periodic(const Duration(days: 7), (timer) {
      _performWeeklyReview();
    });

    // Streak reminder check every 6 hours
    _streakReminderTimer = Timer.periodic(const Duration(hours: 6), (timer) {
      _checkStreakReminder();
    });

    // Perform initial checks
    _performDailyCheck();
  }

  Future<void> _performDailyCheck() async {
    try {
      final authService = AuthService();
      final user = authService.currentUser;
      
      if (user == null) return;

      final userProfile = await authService.getUserProfile();
      if (userProfile == null) return;

      final profile = UserProfile.fromJson(userProfile);
      
      // Check if user has been active today
      final today = DateTime.now();
      
      // Send daily reminder
      await _sendDailyReminder(profile);

      // Check for milestone achievements
      await _checkMilestones(profile, user.id);
      
      // Send personalized tip
      await _sendPersonalizedTip(profile);
      
    } catch (e) {
      debugPrint('Error in daily check: $e');
    }
  }

  Future<void> _performWeeklyReview() async {
    try {
      final authService = AuthService();
      final user = authService.currentUser;
      
      if (user == null) return;

      final userProfile = await authService.getUserProfile();
      if (userProfile == null) return;

      final profile = UserProfile.fromJson(userProfile);
      
      // Get weekly progress
      final weeklyStats = await _getWeeklyStats(user.id);
      
      await _sendWeeklyReview(profile, weeklyStats);
      
    } catch (e) {
      debugPrint('Error in weekly review: $e');
    }
  }

  Future<void> _checkStreakReminder() async {
    try {
      final authService = AuthService();
      final user = authService.currentUser;
      
      if (user == null) return;

      final userProfile = await authService.getUserProfile();
      if (userProfile == null) return;

      final profile = UserProfile.fromJson(userProfile);
      
      // Send streak reminder if streak > 0
      if (profile.streak > 0) {
        await _sendStreakReminder(profile);
      }
      
    } catch (e) {
      debugPrint('Error in streak reminder check: $e');
    }
  }

  Future<void> _sendDailyReminder(UserProfile profile) async {
    final messages = _getDailyReminderMessages(profile);
    final message = messages[Random().nextInt(messages.length)];
    
    _triggerNotification(
      title: 'Good morning, ${profile.name}! 🌅',
      message: message,
      type: 'daily_reminder',
    );
  }

  Future<void> _sendPersonalizedTip(UserProfile profile) async {
    try {
      final onboardingService = SimpleOnboardingService();
      final onboardingData = await onboardingService.getOnboardingData();
      
      if (onboardingData != null) {
        final personalizedContent = onboardingService.generatePersonalizedContent(onboardingData);
        final tips = personalizedContent['customTips'] as List<String>? ?? [];
        
        if (tips.isNotEmpty) {
          final tip = tips[Random().nextInt(tips.length)];
          
          _triggerNotification(
            title: '💡 Tip for You',
            message: tip,
            type: 'personalized_tip',
          );
        }
      }
    } catch (e) {
      debugPrint('Error sending personalized tip: $e');
    }
  }

  Future<void> _sendStreakReminder(UserProfile profile) async {
    final streakMessages = [
      'Don\'t break your ${profile.streak}-day streak! 🔥',
      'Your ${profile.streak}-day streak is waiting for you! 💪',
      'Keep the momentum going! ${profile.streak} days strong! 🚀',
      'Just a quick lesson to maintain your streak! ⚡',
    ];
    
    final message = streakMessages[Random().nextInt(streakMessages.length)];
    
    _triggerNotification(
      title: 'Streak Alert! 🔥',
      message: message,
      type: 'streak_reminder',
    );
  }

  Future<void> _checkMilestones(UserProfile profile, String userId) async {
    try {
      final progressService = ProgressTrackingService();
      final stats = await progressService.getOverallStats(userId);
      
      // Check for XP milestones
      if (_isXPMilestone(profile.xp)) {
        _triggerNotification(
          title: 'XP Milestone! 🎉',
          message: 'You\'ve reached ${profile.xp} XP! Keep learning!',
          type: 'milestone',
        );
      }
      
      // Check for level up
      if (_isLevelMilestone(profile.level)) {
        _triggerNotification(
          title: 'Level Up! 🆙',
          message: 'Congratulations! You\'re now Level ${profile.level}!',
          type: 'milestone',
        );
      }
      
      // Check for streak milestones
      if (_isStreakMilestone(profile.streak)) {
        _triggerNotification(
          title: 'Streak Milestone! 🔥',
          message: 'Amazing! ${profile.streak} days in a row!',
          type: 'milestone',
        );
      }
      
    } catch (e) {
      debugPrint('Error checking milestones: $e');
    }
  }

  Future<void> _sendWeeklyReview(UserProfile profile, Map<String, dynamic> weeklyStats) async {
    final completedLessons = weeklyStats['completedLessons'] ?? 0;
    final passedQuizzes = weeklyStats['passedQuizzes'] ?? 0;
    final xpGained = weeklyStats['xpGained'] ?? 0;
    
    String message;
    if (completedLessons > 0) {
      message = 'This week: $completedLessons lessons, $passedQuizzes quizzes, +$xpGained XP! 📈';
    } else {
      message = 'Ready for a fresh start this week? Let\'s learn something new! 🌟';
    }
    
    _triggerNotification(
      title: 'Weekly Review 📊',
      message: message,
      type: 'weekly_review',
    );
  }

  void _triggerNotification({
    required String title,
    required String message,
    required String type,
  }) {
    // Log the notification
    debugPrint('Notification: $title - $message');
    
    // Trigger callback if set
    onNotificationGenerated?.call(title, message, type);
  }

  Future<Map<String, dynamic>> _getWeeklyStats(String userId) async {
    try {
      final progressService = ProgressTrackingService();
      final stats = await progressService.getOverallStats(userId);
      
      // For now, return mock weekly stats
      // In a real implementation, this would calculate actual weekly progress
      return {
        'completedLessons': Random().nextInt(10),
        'passedQuizzes': Random().nextInt(5),
        'xpGained': Random().nextInt(500),
      };
    } catch (e) {
      debugPrint('Error getting weekly stats: $e');
      return {
        'completedLessons': 0,
        'passedQuizzes': 0,
        'xpGained': 0,
      };
    }
  }

  List<String> _getDailyReminderMessages(UserProfile profile) {
    return [
      'Ready to learn something new today? 📚',
      'Your daily dose of knowledge awaits! 🧠',
      'Let\'s make today count! Start with a quick lesson 💪',
      'Time to level up your skills! 🚀',
      'A few minutes of learning can change your day! ✨',
      'Your future self will thank you for learning today! 🙏',
      'Small steps, big progress! Let\'s go! 👣',
      'Knowledge is power - charge up today! ⚡',
    ];
  }

  bool _isXPMilestone(int xp) {
    final milestones = [100, 250, 500, 1000, 2500, 5000, 10000];
    return milestones.contains(xp);
  }

  bool _isLevelMilestone(int level) {
    return level > 1 && (level % 5 == 0 || level <= 10);
  }

  bool _isStreakMilestone(int streak) {
    final milestones = [3, 7, 14, 30, 50, 100];
    return milestones.contains(streak);
  }

  // Public methods for manual notifications
  Future<void> sendCustomNotification({
    required String title,
    required String message,
    String type = 'custom',
  }) async {
    _triggerNotification(title: title, message: message, type: type);
  }

  Future<void> sendGoalReminder(UserProfile profile, String goalType) async {
    String message;
    switch (goalType) {
      case 'health':
        message = 'Time to focus on your health goals! 💪';
        break;
      case 'wealth':
        message = 'Let\'s work on your financial future! 💰';
        break;
      default:
        message = 'Don\'t forget about your learning goals! 🎯';
    }
    
    _triggerNotification(
      title: 'Goal Reminder 🎯',
      message: message,
      type: 'goal_reminder',
    );
  }

  Future<void> sendProgressCelebration(UserProfile profile, String achievement) async {
    _triggerNotification(
      title: 'Congratulations! 🎉',
      message: achievement,
      type: 'celebration',
    );
  }

  void dispose() {
    _dailyCheckTimer?.cancel();
    _weeklyReviewTimer?.cancel();
    _streakReminderTimer?.cancel();
  }

  // Getters for notification history (for analytics)
  List<Map<String, dynamic>> getNotificationHistory() {
    // In a real implementation, this would return stored notification history
    return [];
  }

  Map<String, int> getNotificationStats() {
    // In a real implementation, this would return notification statistics
    return {
      'total_sent': 0,
      'daily_reminders': 0,
      'streak_reminders': 0,
      'milestones': 0,
      'tips': 0,
    };
  }
}