import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import 'ai_service.dart';
import 'behavior_tracking_service.dart';
import 'personalized_content_service.dart';
import 'ml_prediction_service.dart';

// Comprehensive AI Recommendation
class AIRecommendation {
  final String id;
  final String type;
  final String title;
  final String description;
  final String category;
  final double priority;
  final double confidence;
  final Map<String, dynamic> data;
  final List<String> tags;
  final DateTime timestamp;
  final String? actionUrl;
  final Map<String, dynamic> metadata;

  const AIRecommendation({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.confidence,
    required this.data,
    required this.tags,
    required this.timestamp,
    this.actionUrl,
    required this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'confidence': confidence,
      'data': data,
      'tags': tags,
      'timestamp': timestamp.toIso8601String(),
      'actionUrl': actionUrl,
      'metadata': metadata,
    };
  }

  factory AIRecommendation.fromJson(Map<String, dynamic> json) {
    return AIRecommendation(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      priority: (json['priority'] ?? 0.0).toDouble(),
      confidence: (json['confidence'] ?? 0.0).toDouble(),
      data: Map<String, dynamic>.from(json['data']),
      tags: List<String>.from(json['tags']),
      timestamp: DateTime.parse(json['timestamp']),
      actionUrl: json['actionUrl'],
      metadata: Map<String, dynamic>.from(json['metadata']),
    );
  }
}

// AI Recommendation Engine
class AIRecommendationSystem extends ChangeNotifier {
  static final AIRecommendationSystem _instance = AIRecommendationSystem._internal();
  factory AIRecommendationSystem() => _instance;
  AIRecommendationSystem._internal();

  final AIService _aiService = AIService();
  final BehaviorTrackingService _behaviorService = BehaviorTrackingService();
  final PersonalizedContentService _contentService = PersonalizedContentService();
  final MLPredictionService _predictionService = MLPredictionService();

  List<AIRecommendation> _recommendations = [];
  Map<String, List<AIRecommendation>> _categoryRecommendations = {};
  bool _isGenerating = false;
  DateTime? _lastUpdate;

  List<AIRecommendation> get recommendations => _recommendations;
  Map<String, List<AIRecommendation>> get categoryRecommendations => _categoryRecommendations;
  bool get isGenerating => _isGenerating;
  DateTime? get lastUpdate => _lastUpdate;

  // Initialize AI recommendation system
  Future<void> initializeRecommendations(UserProfile userProfile) async {
    _isGenerating = true;
    notifyListeners();

    try {
      // Initialize all dependent services
      _behaviorService.initializeTracking(userProfile.id ?? '');
      await _contentService.initializeContent(userProfile);
      await _predictionService.initializePredictions(userProfile);

      // Generate comprehensive recommendations
      await _generateComprehensiveRecommendations(userProfile);
      
      _lastUpdate = DateTime.now();
    } catch (e) {
      debugPrint('Error initializing AI recommendations: $e');
    } finally {
      _isGenerating = false;
      notifyListeners();
    }
  }

  // Generate comprehensive recommendations
  Future<void> _generateComprehensiveRecommendations(UserProfile userProfile) async {
    _recommendations.clear();
    
    // Get data from all services
    final behaviorData = _behaviorService.exportBehaviorData();
    final userInsights = _behaviorService.getUserInsights();
    final contentData = _contentService.exportContentData();
    final predictionData = _predictionService.exportPredictionData();

    // Generate different types of recommendations
    await _generateLearningRecommendations(userProfile, behaviorData, userInsights);
    await _generateGoalRecommendations(userProfile, predictionData);
    await _generateContentRecommendations(userProfile, contentData, userInsights);
    await _generateBehaviorRecommendations(userProfile, behaviorData, userInsights);
    await _generateRiskMitigationRecommendations(userProfile, predictionData);
    await _generatePersonalizationRecommendations(userProfile, behaviorData, userInsights);

    // Sort recommendations by priority and confidence
    _recommendations.sort((a, b) {
      final priorityComparison = b.priority.compareTo(a.priority);
      if (priorityComparison != 0) return priorityComparison;
      return b.confidence.compareTo(a.confidence);
    });

    // Organize by categories
    _organizeRecommendationsByCategory();
  }

  // Generate learning recommendations
  Future<void> _generateLearningRecommendations(
    UserProfile userProfile,
    Map<String, dynamic> behaviorData,
    Map<String, dynamic> userInsights,
  ) async {
    final engagementScore = userInsights['engagement_score'] ?? 0.0;
    final learningStreak = userInsights['learning_streak'] ?? 0;
    final preferredCategories = userInsights['preferred_categories'] as List? ?? [];

    // Engagement-based recommendations
    if (engagementScore < 50) {
      _recommendations.add(AIRecommendation(
        id: 'learning_engagement_boost',
        type: 'learning',
        title: 'Boost Your Learning Engagement',
        description: 'Try interactive lessons and gamified content to increase your engagement.',
        category: 'learning',
        priority: 0.9,
        confidence: 0.85,
        data: {
          'current_engagement': engagementScore,
          'target_engagement': 70.0,
          'recommended_actions': ['Try interactive quizzes', 'Set daily learning goals', 'Join community challenges'],
        },
        tags: ['engagement', 'learning', 'motivation'],
        timestamp: DateTime.now(),
        actionUrl: '/learning/interactive',
        metadata: {
          'reason': 'Low engagement score detected',
          'urgency': 'high',
        },
      ));
    }

    // Streak-based recommendations
    if (learningStreak < 3) {
      _recommendations.add(AIRecommendation(
        id: 'learning_consistency',
        type: 'learning',
        title: 'Build Consistent Learning Habits',
        description: 'Establish a daily learning routine to improve knowledge retention.',
        category: 'learning',
        priority: 0.8,
        confidence: 0.9,
        data: {
          'current_streak': learningStreak,
          'target_streak': 7,
          'recommended_schedule': 'Daily 15-minute sessions',
        },
        tags: ['consistency', 'habits', 'learning'],
        timestamp: DateTime.now(),
        actionUrl: '/settings/notifications',
        metadata: {
          'reason': 'Inconsistent learning pattern',
          'urgency': 'medium',
        },
      ));
    }

    // Category-specific recommendations
    for (final categoryData in preferredCategories) {
      final category = categoryData['category'] as String;
      final engagement = categoryData['engagement_score'] as double? ?? 0.0;
      
      if (engagement > 70) {
        _recommendations.add(AIRecommendation(
          id: 'advanced_${category}_content',
          type: 'learning',
          title: 'Advanced ${category.toUpperCase()} Content',
          description: 'You\'re excelling in $category! Try advanced topics to challenge yourself.',
          category: category,
          priority: 0.7,
          confidence: 0.8,
          data: {
            'category': category,
            'current_level': 'intermediate',
            'recommended_level': 'advanced',
          },
          tags: ['advanced', category, 'challenge'],
          timestamp: DateTime.now(),
          actionUrl: '/learning/$category/advanced',
          metadata: {
            'reason': 'High performance in category',
            'urgency': 'low',
          },
        ));
      }
    }
  }

  // Generate goal recommendations
  Future<void> _generateGoalRecommendations(
    UserProfile userProfile,
    Map<String, dynamic> predictionData,
  ) async {
    final goalPredictions = predictionData['goal_predictions'] as Map<String, dynamic>? ?? {};

    for (final entry in goalPredictions.entries) {
      final goalType = entry.key;
      final predictionJson = entry.value as Map<String, dynamic>;
      final probability = predictionJson['achievementProbability'] ?? 0.0;
      final estimatedDays = predictionJson['estimatedDaysToCompletion'] ?? 90;
      final riskFactors = List<String>.from(predictionJson['riskFactors'] ?? []);

      if (probability < 0.6) {
        _recommendations.add(AIRecommendation(
          id: 'goal_support_$goalType',
          type: 'goal',
          title: 'Boost Your ${goalType.toUpperCase()} Goal Success',
          description: 'Your $goalType goal needs attention. Here are strategies to improve your success rate.',
          category: goalType,
          priority: 0.95,
          confidence: 0.9,
          data: {
            'goal_type': goalType,
            'current_probability': probability,
            'estimated_days': estimatedDays,
            'risk_factors': riskFactors,
            'recommended_actions': _getGoalImprovementActions(goalType, riskFactors),
          },
          tags: ['goal', goalType, 'improvement'],
          timestamp: DateTime.now(),
          actionUrl: '/goals/$goalType',
          metadata: {
            'reason': 'Low goal achievement probability',
            'urgency': 'high',
          },
        ));
      } else if (probability > 0.8) {
        _recommendations.add(AIRecommendation(
          id: 'goal_acceleration_$goalType',
          type: 'goal',
          title: 'Accelerate Your ${goalType.toUpperCase()} Progress',
          description: 'You\'re on track! Consider these advanced strategies to achieve your goal faster.',
          category: goalType,
          priority: 0.6,
          confidence: 0.85,
          data: {
            'goal_type': goalType,
            'current_probability': probability,
            'acceleration_potential': 0.2,
            'advanced_strategies': _getAdvancedGoalStrategies(goalType),
          },
          tags: ['goal', goalType, 'acceleration'],
          timestamp: DateTime.now(),
          actionUrl: '/goals/$goalType/advanced',
          metadata: {
            'reason': 'High goal achievement probability',
            'urgency': 'low',
          },
        ));
      }
    }
  }

  // Generate content recommendations
  Future<void> _generateContentRecommendations(
    UserProfile userProfile,
    Map<String, dynamic> contentData,
    Map<String, dynamic> userInsights,
  ) async {
    final currentFeed = contentData['current_feed'];
    final learningPaths = contentData['learning_paths'] as List? ?? [];

    // Recommend trending content
    if (currentFeed != null) {
      final feedItems = currentFeed['items'] as List? ?? [];
      final trendingItems = feedItems.where((item) => 
        (item['relevanceScore'] ?? 0.0) > 0.8).take(3).toList();

      for (final item in trendingItems) {
        _recommendations.add(AIRecommendation(
          id: 'trending_content_${item['id']}',
          type: 'content',
          title: 'Trending: ${item['title']}',
          description: item['description'],
          category: item['category'],
          priority: 0.7,
          confidence: 0.8,
          data: {
            'content_id': item['id'],
            'content_type': item['type'],
            'relevance_score': item['relevanceScore'],
          },
          tags: ['trending', 'content', item['category']],
          timestamp: DateTime.now(),
          actionUrl: item['actionUrl'],
          metadata: {
            'reason': 'High relevance trending content',
            'urgency': 'medium',
          },
        ));
      }
    }

    // Recommend learning paths
    for (final pathData in learningPaths) {
      final completionPercentage = pathData['completionPercentage'] ?? 0.0;
      if (completionPercentage < 100 && completionPercentage > 0) {
        _recommendations.add(AIRecommendation(
          id: 'continue_path_${pathData['id']}',
          type: 'content',
          title: 'Continue: ${pathData['title']}',
          description: 'You\'re ${completionPercentage.round()}% complete. Keep going!',
          category: 'learning',
          priority: 0.85,
          confidence: 0.9,
          data: {
            'path_id': pathData['id'],
            'completion_percentage': completionPercentage,
            'estimated_duration': pathData['estimatedDuration'],
          },
          tags: ['learning_path', 'continuation', 'progress'],
          timestamp: DateTime.now(),
          actionUrl: '/learning/path/${pathData['id']}',
          metadata: {
            'reason': 'Incomplete learning path',
            'urgency': 'medium',
          },
        ));
      }
    }
  }

  // Generate behavior recommendations
  Future<void> _generateBehaviorRecommendations(
    UserProfile userProfile,
    Map<String, dynamic> behaviorData,
    Map<String, dynamic> userInsights,
  ) async {
    final behaviorProfile = behaviorData['behavior_profile'];
    if (behaviorProfile == null) return;

    final averageSessionDuration = behaviorProfile['averageSessionDuration'] ?? 0.0;
    final totalSessions = behaviorProfile['totalSessions'] ?? 0;
    final preferredTimes = behaviorProfile['preferredLearningTimes'] as List? ?? [];

    // Session duration recommendations
    if (averageSessionDuration < 300) { // Less than 5 minutes
      _recommendations.add(AIRecommendation(
        id: 'extend_session_duration',
        type: 'behavior',
        title: 'Extend Your Learning Sessions',
        description: 'Longer sessions improve retention. Try 10-15 minute focused sessions.',
        category: 'learning',
        priority: 0.75,
        confidence: 0.8,
        data: {
          'current_duration': averageSessionDuration,
          'recommended_duration': 600, // 10 minutes
          'benefits': ['Better retention', 'Deeper understanding', 'Improved focus'],
        },
        tags: ['session_duration', 'improvement', 'retention'],
        timestamp: DateTime.now(),
        actionUrl: '/tips/session-optimization',
        metadata: {
          'reason': 'Short session duration detected',
          'urgency': 'medium',
        },
      ));
    }

    // Frequency recommendations
    if (totalSessions < 10) {
      _recommendations.add(AIRecommendation(
        id: 'increase_session_frequency',
        type: 'behavior',
        title: 'Build a Regular Learning Habit',
        description: 'Consistent daily practice leads to better results. Try to learn something new each day.',
        category: 'learning',
        priority: 0.8,
        confidence: 0.85,
        data: {
          'current_sessions': totalSessions,
          'recommended_frequency': 'daily',
          'benefits': ['Better retention', 'Habit formation', 'Steady progress'],
        },
        tags: ['frequency', 'habits', 'consistency'],
        timestamp: DateTime.now(),
        actionUrl: '/settings/reminders',
        metadata: {
          'reason': 'Low session frequency',
          'urgency': 'medium',
        },
      ));
    }

    // Time-based recommendations
    if (preferredTimes.isNotEmpty) {
      final preferredTime = preferredTimes.first;
      _recommendations.add(AIRecommendation(
        id: 'optimize_learning_time',
        type: 'behavior',
        title: 'Optimize Your Learning Schedule',
        description: 'You learn best in the $preferredTime. Schedule your most important lessons then.',
        category: 'learning',
        priority: 0.6,
        confidence: 0.75,
        data: {
          'preferred_time': preferredTime,
          'optimization_tips': [
            'Block calendar time for learning',
            'Minimize distractions during peak hours',
            'Prepare materials in advance'
          ],
        },
        tags: ['timing', 'optimization', 'schedule'],
        timestamp: DateTime.now(),
        actionUrl: '/settings/schedule',
        metadata: {
          'reason': 'Preferred learning time identified',
          'urgency': 'low',
        },
      ));
    }
  }

  // Generate risk mitigation recommendations
  Future<void> _generateRiskMitigationRecommendations(
    UserProfile userProfile,
    Map<String, dynamic> predictionData,
  ) async {
    final riskAssessments = predictionData['risk_assessments'] as List? ?? [];

    for (final riskData in riskAssessments) {
      final riskType = riskData['riskType'];
      final riskLevel = riskData['riskLevel'] ?? 0.0;
      final mitigationStrategies = List<String>.from(riskData['mitigationStrategies'] ?? []);

      if (riskLevel > 0.6) { // High risk
        _recommendations.add(AIRecommendation(
          id: 'mitigate_${riskType}_risk',
          type: 'risk_mitigation',
          title: 'Address ${riskType.replaceAll('_', ' ').toUpperCase()} Risk',
          description: 'High risk detected in $riskType. Take action to prevent issues.',
          category: 'risk',
          priority: 0.95,
          confidence: 0.9,
          data: {
            'risk_type': riskType,
            'risk_level': riskLevel,
            'mitigation_strategies': mitigationStrategies,
            'urgency': 'high',
          },
          tags: ['risk', 'mitigation', riskType],
          timestamp: DateTime.now(),
          actionUrl: '/risk-management/$riskType',
          metadata: {
            'reason': 'High risk level detected',
            'urgency': 'high',
          },
        ));
      }
    }
  }

  // Generate personalization recommendations
  Future<void> _generatePersonalizationRecommendations(
    UserProfile userProfile,
    Map<String, dynamic> behaviorData,
    Map<String, dynamic> userInsights,
  ) async {
    final mostUsedFeatures = userInsights['most_used_features'] as List? ?? [];
    final preferredCategories = userInsights['preferred_categories'] as List? ?? [];

    // Feature-based personalization
    if (mostUsedFeatures.isNotEmpty) {
      final topFeature = mostUsedFeatures.first;
      final featureName = topFeature['feature'] as String;
      
      _recommendations.add(AIRecommendation(
        id: 'personalize_${featureName}_experience',
        type: 'personalization',
        title: 'Enhance Your ${featureName.toUpperCase()} Experience',
        description: 'You love using $featureName! Here are ways to get even more value from it.',
        category: 'personalization',
        priority: 0.7,
        confidence: 0.8,
        data: {
          'feature': featureName,
          'usage_count': topFeature['usage_count'],
          'enhancement_suggestions': _getFeatureEnhancements(featureName),
        },
        tags: ['personalization', featureName, 'enhancement'],
        timestamp: DateTime.now(),
        actionUrl: '/features/$featureName/advanced',
        metadata: {
          'reason': 'High feature usage detected',
          'urgency': 'low',
        },
      ));
    }

    // Category-based personalization
    for (final categoryData in preferredCategories.take(2)) {
      final category = categoryData['category'] as String;
      final engagement = categoryData['engagement_score'] as double? ?? 0.0;
      
      _recommendations.add(AIRecommendation(
        id: 'personalize_${category}_content',
        type: 'personalization',
        title: 'Customized ${category.toUpperCase()} Content',
        description: 'Get more personalized $category content based on your interests and progress.',
        category: category,
        priority: 0.65,
        confidence: 0.75,
        data: {
          'category': category,
          'engagement_score': engagement,
          'personalization_options': _getCategoryPersonalization(category),
        },
        tags: ['personalization', category, 'content'],
        timestamp: DateTime.now(),
        actionUrl: '/personalization/$category',
        metadata: {
          'reason': 'High category engagement',
          'urgency': 'low',
        },
      ));
    }
  }

  // Organize recommendations by category
  void _organizeRecommendationsByCategory() {
    _categoryRecommendations.clear();
    
    for (final recommendation in _recommendations) {
      if (!_categoryRecommendations.containsKey(recommendation.category)) {
        _categoryRecommendations[recommendation.category] = [];
      }
      _categoryRecommendations[recommendation.category]!.add(recommendation);
    }
  }

  // Get goal improvement actions
  List<String> _getGoalImprovementActions(String goalType, List<String> riskFactors) {
    final actions = <String>[];
    
    switch (goalType) {
      case 'health':
        actions.addAll([
          'Set specific daily health targets',
          'Track your progress with health metrics',
          'Join health-focused community challenges',
          'Schedule regular health check-ins',
        ]);
        break;
      case 'wealth':
        actions.addAll([
          'Create a detailed budget plan',
          'Set up automatic savings',
          'Learn about investment basics',
          'Track your financial progress weekly',
        ]);
        break;
      default:
        actions.addAll([
          'Break goal into smaller milestones',
          'Set daily action items',
          'Track progress regularly',
          'Find an accountability partner',
        ]);
    }
    
    // Add risk-specific actions
    for (final risk in riskFactors) {
      if (risk.contains('engagement')) {
        actions.add('Try gamified learning approaches');
      }
      if (risk.contains('consistency')) {
        actions.add('Set up daily reminders');
      }
    }
    
    return actions.take(5).toList();
  }

  // Get advanced goal strategies
  List<String> _getAdvancedGoalStrategies(String goalType) {
    switch (goalType) {
      case 'health':
        return [
          'Implement advanced nutrition tracking',
          'Try high-intensity interval training',
          'Focus on sleep optimization',
          'Consider working with a health coach',
        ];
      case 'wealth':
        return [
          'Explore advanced investment strategies',
          'Consider tax optimization techniques',
          'Look into passive income streams',
          'Plan for long-term wealth building',
        ];
      default:
        return [
          'Set stretch goals beyond current target',
          'Implement advanced tracking methods',
          'Share your success to inspire others',
          'Mentor someone with similar goals',
        ];
    }
  }

  // Get feature enhancements
  List<String> _getFeatureEnhancements(String featureName) {
    switch (featureName) {
      case 'calculator':
        return [
          'Try advanced calculation scenarios',
          'Save your favorite calculations',
          'Compare different calculation methods',
          'Share results with financial advisor',
        ];
      case 'lesson':
        return [
          'Take notes during lessons',
          'Review lesson summaries',
          'Discuss lessons in community',
          'Apply lessons to real situations',
        ];
      default:
        return [
          'Explore advanced features',
          'Customize your experience',
          'Share with friends',
          'Provide feedback for improvements',
        ];
    }
  }

  // Get category personalization options
  List<String> _getCategoryPersonalization(String category) {
    switch (category) {
      case 'health':
        return [
          'Customize health metrics tracking',
          'Set personalized health goals',
          'Get nutrition recommendations',
          'Receive workout suggestions',
        ];
      case 'wealth':
        return [
          'Personalized investment advice',
          'Custom budget categories',
          'Tailored savings goals',
          'Risk-appropriate strategies',
        ];
      default:
        return [
          'Customize content preferences',
          'Set personalized reminders',
          'Choose difficulty levels',
          'Select preferred formats',
        ];
    }
  }

  // Get recommendations by category
  List<AIRecommendation> getRecommendationsByCategory(String category) {
    return _categoryRecommendations[category] ?? [];
  }

  // Get top priority recommendations
  List<AIRecommendation> getTopPriorityRecommendations({int limit = 5}) {
    return _recommendations.take(limit).toList();
  }

  // Get recommendations by type
  List<AIRecommendation> getRecommendationsByType(String type) {
    return _recommendations.where((r) => r.type == type).toList();
  }

  // Mark recommendation as acted upon
  void markRecommendationActioned(String recommendationId) {
    final index = _recommendations.indexWhere((r) => r.id == recommendationId);
    if (index != -1) {
      // In a real implementation, this would update the recommendation status
      // For now, we'll just track the action
      _behaviorService.trackEvent(
        AnalyticsEvent.featureUsed('recommendation_action', {
          'recommendation_id': recommendationId,
          'action_type': 'acted_upon',
        }),
      );
    }
  }

  // Refresh recommendations
  Future<void> refreshRecommendations(UserProfile userProfile) async {
    await initializeRecommendations(userProfile);
  }

  // Export recommendation data
  Map<String, dynamic> exportRecommendationData() {
    return {
      'recommendations': _recommendations.map((r) => r.toJson()).toList(),
      'category_recommendations': _categoryRecommendations.map(
        (key, value) => MapEntry(key, value.map((r) => r.toJson()).toList()),
      ),
      'last_update': _lastUpdate?.toIso8601String(),
    };
  }

  // Import recommendation data
  void importRecommendationData(Map<String, dynamic> data) {
    if (data['recommendations'] != null) {
      _recommendations = (data['recommendations'] as List)
          .map((r) => AIRecommendation.fromJson(r))
          .toList();
    }
    
    if (data['category_recommendations'] != null) {
      _categoryRecommendations.clear();
      final categoryData = data['category_recommendations'] as Map<String, dynamic>;
      for (final entry in categoryData.entries) {
        _categoryRecommendations[entry.key] = (entry.value as List)
            .map((r) => AIRecommendation.fromJson(r))
            .toList();
      }
    }
    
    if (data['last_update'] != null) {
      _lastUpdate = DateTime.parse(data['last_update']);
    }
    
    notifyListeners();
  }

  // Clear all recommendations
  void clearRecommendations() {
    _recommendations.clear();
    _categoryRecommendations.clear();
    _lastUpdate = null;
    notifyListeners();
  }
}