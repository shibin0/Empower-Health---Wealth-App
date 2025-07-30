import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';

// Analytics Event Models
class AnalyticsEvent {
  final String id;
  final String type;
  final String category;
  final Map<String, dynamic> properties;
  final DateTime timestamp;

  const AnalyticsEvent({
    required this.id,
    required this.type,
    required this.category,
    required this.properties,
    required this.timestamp,
  });

  factory AnalyticsEvent.screenView(String screenName) {
    return AnalyticsEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'screen_view',
      category: 'navigation',
      properties: {'screen_name': screenName},
      timestamp: DateTime.now(),
    );
  }

  factory AnalyticsEvent.lessonStarted(String lessonId, String category) {
    return AnalyticsEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'lesson_started',
      category: 'learning',
      properties: {
        'lesson_id': lessonId,
        'lesson_category': category,
      },
      timestamp: DateTime.now(),
    );
  }

  factory AnalyticsEvent.lessonCompleted(String lessonId, String category, int timeSpent) {
    return AnalyticsEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'lesson_completed',
      category: 'learning',
      properties: {
        'lesson_id': lessonId,
        'lesson_category': category,
        'time_spent_seconds': timeSpent,
      },
      timestamp: DateTime.now(),
    );
  }

  factory AnalyticsEvent.quizCompleted(String quizId, int score, int totalQuestions) {
    return AnalyticsEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'quiz_completed',
      category: 'assessment',
      properties: {
        'quiz_id': quizId,
        'score': score,
        'total_questions': totalQuestions,
        'percentage': (score / totalQuestions * 100).round(),
      },
      timestamp: DateTime.now(),
    );
  }

  factory AnalyticsEvent.goalInteraction(String goalId, String interactionType) {
    return AnalyticsEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'goal_interaction',
      category: 'engagement',
      properties: {
        'goal_id': goalId,
        'interaction_type': interactionType,
      },
      timestamp: DateTime.now(),
    );
  }

  factory AnalyticsEvent.calculatorUsed(String calculatorType, Map<String, dynamic> inputs) {
    return AnalyticsEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'calculator_used',
      category: 'tools',
      properties: {
        'calculator_type': calculatorType,
        'inputs': inputs,
      },
      timestamp: DateTime.now(),
    );
  }

  factory AnalyticsEvent.featureUsed(String featureName, Map<String, dynamic> context) {
    return AnalyticsEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'feature_used',
      category: 'engagement',
      properties: {
        'feature_name': featureName,
        'context': context,
      },
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'category': category,
      'properties': properties,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory AnalyticsEvent.fromJson(Map<String, dynamic> json) {
    return AnalyticsEvent(
      id: json['id'],
      type: json['type'],
      category: json['category'],
      properties: Map<String, dynamic>.from(json['properties']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

// User Behavior Profile
class UserBehaviorProfile {
  final String userId;
  final Map<String, int> screenViews;
  final Map<String, int> featureUsage;
  final Map<String, double> categoryEngagement;
  final List<String> preferredLearningTimes;
  final double averageSessionDuration;
  final int totalSessions;
  final Map<String, int> learningPatterns;
  final DateTime lastActive;
  final Map<String, dynamic> preferences;

  const UserBehaviorProfile({
    required this.userId,
    required this.screenViews,
    required this.featureUsage,
    required this.categoryEngagement,
    required this.preferredLearningTimes,
    required this.averageSessionDuration,
    required this.totalSessions,
    required this.learningPatterns,
    required this.lastActive,
    required this.preferences,
  });

  factory UserBehaviorProfile.empty(String userId) {
    return UserBehaviorProfile(
      userId: userId,
      screenViews: {},
      featureUsage: {},
      categoryEngagement: {},
      preferredLearningTimes: [],
      averageSessionDuration: 0.0,
      totalSessions: 0,
      learningPatterns: {},
      lastActive: DateTime.now(),
      preferences: {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'screenViews': screenViews,
      'featureUsage': featureUsage,
      'categoryEngagement': categoryEngagement,
      'preferredLearningTimes': preferredLearningTimes,
      'averageSessionDuration': averageSessionDuration,
      'totalSessions': totalSessions,
      'learningPatterns': learningPatterns,
      'lastActive': lastActive.toIso8601String(),
      'preferences': preferences,
    };
  }

  factory UserBehaviorProfile.fromJson(Map<String, dynamic> json) {
    return UserBehaviorProfile(
      userId: json['userId'],
      screenViews: Map<String, int>.from(json['screenViews'] ?? {}),
      featureUsage: Map<String, int>.from(json['featureUsage'] ?? {}),
      categoryEngagement: Map<String, double>.from(json['categoryEngagement'] ?? {}),
      preferredLearningTimes: List<String>.from(json['preferredLearningTimes'] ?? []),
      averageSessionDuration: (json['averageSessionDuration'] ?? 0.0).toDouble(),
      totalSessions: json['totalSessions'] ?? 0,
      learningPatterns: Map<String, int>.from(json['learningPatterns'] ?? {}),
      lastActive: DateTime.parse(json['lastActive'] ?? DateTime.now().toIso8601String()),
      preferences: Map<String, dynamic>.from(json['preferences'] ?? {}),
    );
  }
}

// Session Data
class UserSession {
  final String sessionId;
  final DateTime startTime;
  final DateTime? endTime;
  final List<AnalyticsEvent> events;
  final Map<String, dynamic> sessionData;

  const UserSession({
    required this.sessionId,
    required this.startTime,
    this.endTime,
    required this.events,
    required this.sessionData,
  });

  Duration get duration {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'events': events.map((e) => e.toJson()).toList(),
      'sessionData': sessionData,
    };
  }
}

// Behavior Tracking Service
class BehaviorTrackingService extends ChangeNotifier {
  static final BehaviorTrackingService _instance = BehaviorTrackingService._internal();
  factory BehaviorTrackingService() => _instance;
  BehaviorTrackingService._internal();

  UserBehaviorProfile? _behaviorProfile;
  UserSession? _currentSession;
  final List<AnalyticsEvent> _eventQueue = [];
  bool _isTracking = true;

  UserBehaviorProfile? get behaviorProfile => _behaviorProfile;
  UserSession? get currentSession => _currentSession;
  bool get isTracking => _isTracking;

  // Initialize tracking for a user
  void initializeTracking(String userId) {
    _behaviorProfile = UserBehaviorProfile.empty(userId);
    _startNewSession();
    notifyListeners();
  }

  // Start a new session
  void _startNewSession() {
    _currentSession = UserSession(
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
      startTime: DateTime.now(),
      events: [],
      sessionData: {},
    );
  }

  // End current session
  void endSession() {
    if (_currentSession != null) {
      _currentSession = UserSession(
        sessionId: _currentSession!.sessionId,
        startTime: _currentSession!.startTime,
        endTime: DateTime.now(),
        events: _currentSession!.events,
        sessionData: _currentSession!.sessionData,
      );
      _updateEngagementMetrics();
      notifyListeners();
    }
  }

  // Track an event
  void trackEvent(AnalyticsEvent event) {
    if (!_isTracking) return;

    _eventQueue.add(event);
    _currentSession?.events.add(event);
    
    // Process event immediately for real-time insights
    _processEvent(event);
    
    // Batch process events periodically
    _processBatchEvents();
    
    notifyListeners();
  }

  // Convenience methods for common events
  void trackScreenView(String screenName) {
    trackEvent(AnalyticsEvent.screenView(screenName));
  }

  void trackLessonStarted(String lessonId, String category) {
    trackEvent(AnalyticsEvent.lessonStarted(lessonId, category));
  }

  void trackLessonCompleted(String lessonId, String category, int timeSpent) {
    trackEvent(AnalyticsEvent.lessonCompleted(lessonId, category, timeSpent));
  }

  void trackQuizCompleted(String quizId, int score, int totalQuestions) {
    trackEvent(AnalyticsEvent.quizCompleted(quizId, score, totalQuestions));
  }

  void trackGoalInteraction(String goalId, String interactionType) {
    trackEvent(AnalyticsEvent.goalInteraction(goalId, interactionType));
  }

  void trackCalculatorUsed(String calculatorType, Map<String, dynamic> inputs) {
    trackEvent(AnalyticsEvent.calculatorUsed(calculatorType, inputs));
  }

  void trackFeatureUsed(String featureName, {Map<String, dynamic>? context}) {
    trackEvent(AnalyticsEvent.featureUsed(featureName, context ?? {}));
  }

  // Process individual event
  void _processEvent(AnalyticsEvent event) {
    if (_behaviorProfile == null) return;

    // Update screen views
    if (event.type == 'screen_view') {
      final screenName = event.properties['screen_name'] as String;
      final currentViews = _behaviorProfile!.screenViews[screenName] ?? 0;
      _behaviorProfile!.screenViews[screenName] = currentViews + 1;
    }

    // Update feature usage
    if (event.type == 'feature_used') {
      final featureName = event.properties['feature_name'] as String;
      final currentUsage = _behaviorProfile!.featureUsage[featureName] ?? 0;
      _behaviorProfile!.featureUsage[featureName] = currentUsage + 1;
    }

    // Update category engagement
    final currentEngagement = _behaviorProfile!.categoryEngagement[event.category] ?? 0.0;
    _behaviorProfile!.categoryEngagement[event.category] = currentEngagement + 1.0;
  }

  // Process events in batches
  void _processBatchEvents() {
    if (_eventQueue.length >= 10) {
      // Process batch of events for deeper analytics
      _analyzeLearningPatterns();
      _analyzeTimePreferences();
      _updateEngagementMetrics();
      
      // Clear processed events
      _eventQueue.clear();
    }
  }

  // Analyze learning patterns
  void _analyzeLearningPatterns() {
    if (_behaviorProfile == null) return;

    final learningEvents = _eventQueue.where((e) => e.category == 'learning').toList();
    
    for (final event in learningEvents) {
      if (event.type == 'lesson_completed') {
        final category = event.properties['lesson_category'] as String;
        final currentCount = _behaviorProfile!.learningPatterns[category] ?? 0;
        _behaviorProfile!.learningPatterns[category] = currentCount + 1;
      }
    }
  }

  // Analyze time preferences
  void _analyzeTimePreferences() {
    if (_behaviorProfile == null) return;

    final learningEvents = _eventQueue.where((e) => e.category == 'learning').toList();
    final timePreferences = <String, int>{};

    for (final event in learningEvents) {
      final hour = event.timestamp.hour;
      String timeSlot;
      
      if (hour >= 6 && hour < 12) {
        timeSlot = 'morning';
      } else if (hour >= 12 && hour < 17) {
        timeSlot = 'afternoon';
      } else if (hour >= 17 && hour < 21) {
        timeSlot = 'evening';
      } else {
        timeSlot = 'night';
      }
      
      timePreferences[timeSlot] = (timePreferences[timeSlot] ?? 0) + 1;
    }

    // Update preferred learning times
    final sortedTimes = timePreferences.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    _behaviorProfile!.preferredLearningTimes.clear();
    _behaviorProfile!.preferredLearningTimes.addAll(
      sortedTimes.take(2).map((e) => e.key),
    );
  }

  // Update engagement metrics
  void _updateEngagementMetrics() {
    if (_behaviorProfile == null || _currentSession == null) return;

    // Update session count
    _behaviorProfile = UserBehaviorProfile(
      userId: _behaviorProfile!.userId,
      screenViews: _behaviorProfile!.screenViews,
      featureUsage: _behaviorProfile!.featureUsage,
      categoryEngagement: _behaviorProfile!.categoryEngagement,
      preferredLearningTimes: _behaviorProfile!.preferredLearningTimes,
      averageSessionDuration: _calculateAverageSessionDuration(),
      totalSessions: _behaviorProfile!.totalSessions + 1,
      learningPatterns: _behaviorProfile!.learningPatterns,
      lastActive: DateTime.now(),
      preferences: _behaviorProfile!.preferences,
    );
  }

  // Calculate average session duration
  double _calculateAverageSessionDuration() {
    if (_currentSession == null) return 0.0;
    
    final currentDuration = _currentSession!.duration.inSeconds.toDouble();
    final totalSessions = _behaviorProfile!.totalSessions;
    
    if (totalSessions == 0) return currentDuration;
    
    final currentAverage = _behaviorProfile!.averageSessionDuration;
    return ((currentAverage * totalSessions) + currentDuration) / (totalSessions + 1);
  }

  // Get user insights based on behavior
  Map<String, dynamic> getUserInsights() {
    if (_behaviorProfile == null) return {};

    return {
      'most_used_features': _getMostUsedFeatures(),
      'preferred_categories': _getPreferredCategories(),
      'learning_streak': _calculateLearningStreak(),
      'engagement_score': _calculateEngagementScore(),
      'recommendations': _generateBehaviorRecommendations(),
    };
  }

  // Get most used features
  List<Map<String, dynamic>> _getMostUsedFeatures() {
    final sortedFeatures = _behaviorProfile!.featureUsage.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return sortedFeatures.take(5).map((entry) => {
      'feature': entry.key,
      'usage_count': entry.value,
    }).toList();
  }

  // Get preferred categories
  List<Map<String, dynamic>> _getPreferredCategories() {
    final sortedCategories = _behaviorProfile!.categoryEngagement.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return sortedCategories.take(3).map((entry) => {
      'category': entry.key,
      'engagement_score': entry.value,
    }).toList();
  }

  // Calculate learning streak
  int _calculateLearningStreak() {
    // This would typically check consecutive days of learning activity
    // For now, return a simple calculation based on recent activity
    final recentEvents = _eventQueue.where((e) =>
      e.category == 'learning' &&
      e.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 7)))
    ).length;
    
    return (recentEvents / 7).ceil();
  }

  // Calculate engagement score
  double _calculateEngagementScore() {
    if (_behaviorProfile == null) return 0.0;

    double score = 0.0;
    
    // Factor in session frequency
    score += _behaviorProfile!.totalSessions * 0.1;
    
    // Factor in feature diversity
    score += _behaviorProfile!.featureUsage.length * 0.2;
    
    // Factor in category engagement
    final totalEngagement = _behaviorProfile!.categoryEngagement.values
        .fold(0.0, (sum, value) => sum + value);
    score += totalEngagement * 0.05;
    
    // Factor in session duration
    score += _behaviorProfile!.averageSessionDuration * 0.001;
    
    return (score * 10).clamp(0.0, 100.0);
  }

  // Generate behavior-based recommendations
  List<String> _generateBehaviorRecommendations() {
    if (_behaviorProfile == null) return [];

    final recommendations = <String>[];
    
    // Check for low engagement
    if (_calculateEngagementScore() < 30) {
      recommendations.add('Try exploring new features to boost your learning experience');
    }
    
    // Check for category preferences
    final topCategory = _getPreferredCategories().isNotEmpty
        ? _getPreferredCategories().first['category']
        : null;
    
    if (topCategory == 'learning') {
      recommendations.add('You love learning! Check out our advanced courses');
    } else if (topCategory == 'tools') {
      recommendations.add('You enjoy our calculators! Try the new budget planner');
    }
    
    // Check for time preferences
    if (_behaviorProfile!.preferredLearningTimes.contains('morning')) {
      recommendations.add('Morning learner detected! Set up morning reminders');
    }
    
    // Check for session patterns
    if (_behaviorProfile!.averageSessionDuration < 300) { // Less than 5 minutes
      recommendations.add('Try longer learning sessions for better retention');
    }
    
    return recommendations;
  }

  // Export behavior data for AI analysis
  Map<String, dynamic> exportBehaviorData() {
    if (_behaviorProfile == null) return {};

    return {
      'behavior_profile': _behaviorProfile!.toJson(),
      'current_session': _currentSession?.toJson(),
      'insights': getUserInsights(),
      'recent_events': _eventQueue.map((e) => e.toJson()).toList(),
    };
  }

  // Import behavior data
  void importBehaviorData(Map<String, dynamic> data) {
    if (data['behavior_profile'] != null) {
      _behaviorProfile = UserBehaviorProfile.fromJson(data['behavior_profile']);
    }
    
    if (data['recent_events'] != null) {
      _eventQueue.clear();
      for (final eventData in data['recent_events']) {
        _eventQueue.add(AnalyticsEvent.fromJson(eventData));
      }
    }
    
    notifyListeners();
  }

  // Toggle tracking
  void setTrackingEnabled(bool enabled) {
    _isTracking = enabled;
    notifyListeners();
  }

  // Clear all data
  void clearAllData() {
    _behaviorProfile = null;
    _currentSession = null;
    _eventQueue.clear();
    notifyListeners();
  }
}