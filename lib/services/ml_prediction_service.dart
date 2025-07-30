import 'package:flutter/foundation.dart';
import 'dart:math' as math;
import '../models/user_profile.dart';
import 'behavior_tracking_service.dart';
import 'ai_service.dart';

// Prediction Models
class PredictionResult {
  final String id;
  final String type;
  final String category;
  final double confidence;
  final Map<String, dynamic> prediction;
  final Map<String, dynamic> factors;
  final DateTime timestamp;
  final String? recommendation;

  const PredictionResult({
    required this.id,
    required this.type,
    required this.category,
    required this.confidence,
    required this.prediction,
    required this.factors,
    required this.timestamp,
    this.recommendation,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'category': category,
      'confidence': confidence,
      'prediction': prediction,
      'factors': factors,
      'timestamp': timestamp.toIso8601String(),
      'recommendation': recommendation,
    };
  }

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(
      id: json['id'],
      type: json['type'],
      category: json['category'],
      confidence: (json['confidence'] ?? 0.0).toDouble(),
      prediction: Map<String, dynamic>.from(json['prediction']),
      factors: Map<String, dynamic>.from(json['factors']),
      timestamp: DateTime.parse(json['timestamp']),
      recommendation: json['recommendation'],
    );
  }
}

// Goal Achievement Prediction
class GoalAchievementPrediction {
  final String goalId;
  final String goalType;
  final double achievementProbability;
  final int estimatedDaysToCompletion;
  final List<String> riskFactors;
  final List<String> successFactors;
  final Map<String, double> milestoneProgress;

  const GoalAchievementPrediction({
    required this.goalId,
    required this.goalType,
    required this.achievementProbability,
    required this.estimatedDaysToCompletion,
    required this.riskFactors,
    required this.successFactors,
    required this.milestoneProgress,
  });

  Map<String, dynamic> toJson() {
    return {
      'goalId': goalId,
      'goalType': goalType,
      'achievementProbability': achievementProbability,
      'estimatedDaysToCompletion': estimatedDaysToCompletion,
      'riskFactors': riskFactors,
      'successFactors': successFactors,
      'milestoneProgress': milestoneProgress,
    };
  }

  factory GoalAchievementPrediction.fromJson(Map<String, dynamic> json) {
    return GoalAchievementPrediction(
      goalId: json['goalId'],
      goalType: json['goalType'],
      achievementProbability: (json['achievementProbability'] ?? 0.0).toDouble(),
      estimatedDaysToCompletion: json['estimatedDaysToCompletion'] ?? 0,
      riskFactors: List<String>.from(json['riskFactors'] ?? []),
      successFactors: List<String>.from(json['successFactors'] ?? []),
      milestoneProgress: Map<String, double>.from(json['milestoneProgress'] ?? {}),
    );
  }
}

// Learning Performance Prediction
class LearningPerformancePrediction {
  final String userId;
  final double retentionRate;
  final double engagementTrend;
  final Map<String, double> categoryPerformance;
  final List<String> recommendedTopics;
  final Map<String, double> difficultyReadiness;

  const LearningPerformancePrediction({
    required this.userId,
    required this.retentionRate,
    required this.engagementTrend,
    required this.categoryPerformance,
    required this.recommendedTopics,
    required this.difficultyReadiness,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'retentionRate': retentionRate,
      'engagementTrend': engagementTrend,
      'categoryPerformance': categoryPerformance,
      'recommendedTopics': recommendedTopics,
      'difficultyReadiness': difficultyReadiness,
    };
  }

  factory LearningPerformancePrediction.fromJson(Map<String, dynamic> json) {
    return LearningPerformancePrediction(
      userId: json['userId'],
      retentionRate: (json['retentionRate'] ?? 0.0).toDouble(),
      engagementTrend: (json['engagementTrend'] ?? 0.0).toDouble(),
      categoryPerformance: Map<String, double>.from(json['categoryPerformance'] ?? {}),
      recommendedTopics: List<String>.from(json['recommendedTopics'] ?? []),
      difficultyReadiness: Map<String, double>.from(json['difficultyReadiness'] ?? {}),
    );
  }
}

// Risk Assessment
class RiskAssessment {
  final String riskType;
  final double riskLevel;
  final List<String> riskFactors;
  final List<String> mitigationStrategies;
  final Map<String, double> riskBreakdown;

  const RiskAssessment({
    required this.riskType,
    required this.riskLevel,
    required this.riskFactors,
    required this.mitigationStrategies,
    required this.riskBreakdown,
  });

  Map<String, dynamic> toJson() {
    return {
      'riskType': riskType,
      'riskLevel': riskLevel,
      'riskFactors': riskFactors,
      'mitigationStrategies': mitigationStrategies,
      'riskBreakdown': riskBreakdown,
    };
  }

  factory RiskAssessment.fromJson(Map<String, dynamic> json) {
    return RiskAssessment(
      riskType: json['riskType'],
      riskLevel: (json['riskLevel'] ?? 0.0).toDouble(),
      riskFactors: List<String>.from(json['riskFactors'] ?? []),
      mitigationStrategies: List<String>.from(json['mitigationStrategies'] ?? []),
      riskBreakdown: Map<String, double>.from(json['riskBreakdown'] ?? {}),
    );
  }
}

// ML Prediction Service
class MLPredictionService extends ChangeNotifier {
  static final MLPredictionService _instance = MLPredictionService._internal();
  factory MLPredictionService() => _instance;
  MLPredictionService._internal();

  final BehaviorTrackingService _behaviorService = BehaviorTrackingService();
  final AIService _aiService = AIService();

  List<PredictionResult> _predictions = [];
  Map<String, GoalAchievementPrediction> _goalPredictions = {};
  LearningPerformancePrediction? _learningPrediction;
  List<RiskAssessment> _riskAssessments = [];
  bool _isProcessing = false;

  List<PredictionResult> get predictions => _predictions;
  Map<String, GoalAchievementPrediction> get goalPredictions => _goalPredictions;
  LearningPerformancePrediction? get learningPrediction => _learningPrediction;
  List<RiskAssessment> get riskAssessments => _riskAssessments;
  bool get isProcessing => _isProcessing;

  // Initialize ML predictions for user
  Future<void> initializePredictions(UserProfile userProfile) async {
    _isProcessing = true;
    notifyListeners();

    try {
      await _generateGoalPredictions(userProfile);
      await _generateLearningPredictions(userProfile);
      await _generateRiskAssessments(userProfile);
      await _generateGeneralPredictions(userProfile);
    } catch (e) {
      debugPrint('Error initializing ML predictions: $e');
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }

  // Generate goal achievement predictions
  Future<void> _generateGoalPredictions(UserProfile userProfile) async {
    final behaviorData = _behaviorService.exportBehaviorData();
    final userInsights = _behaviorService.getUserInsights();
    
    if (userProfile.healthGoal.isNotEmpty) {
      _goalPredictions['health'] = _predictGoalAchievement(
        'health', userProfile.healthGoal, behaviorData, userInsights);
    }
    
    if (userProfile.wealthGoal.isNotEmpty) {
      _goalPredictions['wealth'] = _predictGoalAchievement(
        'wealth', userProfile.wealthGoal, behaviorData, userInsights);
    }
    
    for (final goal in userProfile.primaryGoals) {
      _goalPredictions[goal] = _predictGoalAchievement(
        'primary', goal, behaviorData, userInsights);
    }
  }

  // Predict goal achievement
  GoalAchievementPrediction _predictGoalAchievement(
    String goalType,
    String goalDescription,
    Map<String, dynamic> behaviorData,
    Map<String, dynamic> userInsights,
  ) {
    final engagementScore = userInsights['engagement_score'] ?? 0.0;
    final learningStreak = userInsights['learning_streak'] ?? 0;
    
    double probability = 0.5;
    probability += (engagementScore / 100) * 0.3;
    probability += math.min(learningStreak / 10, 0.2);
    probability = probability.clamp(0.0, 1.0);
    
    final baseDays = goalType == 'health' ? 90 : goalType == 'wealth' ? 180 : 60;
    final estimatedDays = (baseDays * (2.0 - probability)).round();
    
    final riskFactors = <String>[];
    final successFactors = <String>[];
    
    if (engagementScore < 30) riskFactors.add('Low engagement');
    if (learningStreak < 2) riskFactors.add('Inconsistent learning');
    if (engagementScore > 70) successFactors.add('High engagement');
    if (learningStreak > 5) successFactors.add('Consistent habits');
    
    final milestones = <String, double>{};
    switch (goalType) {
      case 'health':
        milestones['foundation'] = 0.8;
        milestones['habits'] = 0.6;
        milestones['advanced'] = 0.3;
        break;
      case 'wealth':
        milestones['budgeting'] = 0.9;
        milestones['saving'] = 0.7;
        milestones['investing'] = 0.4;
        break;
      default:
        milestones['start'] = 0.8;
        milestones['progress'] = 0.5;
        milestones['completion'] = 0.2;
    }
    
    return GoalAchievementPrediction(
      goalId: '${goalType}_goal',
      goalType: goalType,
      achievementProbability: probability,
      estimatedDaysToCompletion: estimatedDays,
      riskFactors: riskFactors,
      successFactors: successFactors,
      milestoneProgress: milestones,
    );
  }

  // Generate learning performance predictions
  Future<void> _generateLearningPredictions(UserProfile userProfile) async {
    final behaviorData = _behaviorService.exportBehaviorData();
    final userInsights = _behaviorService.getUserInsights();
    
    final engagementScore = userInsights['engagement_score'] ?? 0.0;
    final learningStreak = userInsights['learning_streak'] ?? 0;
    
    final retentionRate = (0.5 + (learningStreak / 10) * 0.3 + (engagementScore / 100) * 0.2).clamp(0.0, 1.0);
    final engagementTrend = engagementScore > 70 ? 0.15 : engagementScore > 40 ? 0.05 : -0.1;
    
    final categoryPerformance = <String, double>{
      'health': 0.5,
      'wealth': 0.5,
      'learning': 0.5,
      'tools': 0.5,
    };
    
    final recommendedTopics = <String>['Goal Setting', 'Habit Formation', 'Progress Tracking'];
    if (userProfile.healthGoal.isNotEmpty) recommendedTopics.add('Health Fundamentals');
    if (userProfile.wealthGoal.isNotEmpty) recommendedTopics.add('Financial Basics');
    
    final difficultyReadiness = <String, double>{
      'beginner': 1.0,
      'intermediate': ((engagementScore / 100) + (learningStreak / 10)).clamp(0.0, 1.0),
      'advanced': ((engagementScore / 100) * 0.8 + (learningStreak / 15) * 0.2).clamp(0.0, 1.0),
    };
    
    _learningPrediction = LearningPerformancePrediction(
      userId: userProfile.id ?? '',
      retentionRate: retentionRate,
      engagementTrend: engagementTrend,
      categoryPerformance: categoryPerformance,
      recommendedTopics: recommendedTopics.take(5).toList(),
      difficultyReadiness: difficultyReadiness,
    );
  }

  // Generate risk assessments
  Future<void> _generateRiskAssessments(UserProfile userProfile) async {
    final userInsights = _behaviorService.getUserInsights();
    final engagementScore = userInsights['engagement_score'] ?? 0.0;
    final learningStreak = userInsights['learning_streak'] ?? 0;
    
    // Engagement risk
    double engagementRisk = 0.0;
    final engagementRiskFactors = <String>[];
    final engagementMitigation = <String>[];
    
    if (engagementScore < 30) {
      engagementRisk += 0.4;
      engagementRiskFactors.add('Very low engagement score');
      engagementMitigation.add('Introduce gamification elements');
    }
    
    if (learningStreak < 2) {
      engagementRisk += 0.3;
      engagementRiskFactors.add('Inconsistent learning pattern');
      engagementMitigation.add('Set up daily reminders');
    }
    
    _riskAssessments = [
      RiskAssessment(
        riskType: 'engagement',
        riskLevel: engagementRisk.clamp(0.0, 1.0),
        riskFactors: engagementRiskFactors,
        mitigationStrategies: engagementMitigation,
        riskBreakdown: {
          'engagement': engagementScore / 100,
          'consistency': learningStreak / 10,
        },
      ),
    ];
  }

  // Generate general predictions
  Future<void> _generateGeneralPredictions(UserProfile userProfile) async {
    final behaviorData = _behaviorService.exportBehaviorData();
    final userInsights = _behaviorService.getUserInsights();
    
    _predictions.add(PredictionResult(
      id: 'activity_prediction',
      type: 'activity',
      category: 'engagement',
      confidence: 0.8,
      prediction: {
        'next_session_probability': 0.75,
        'optimal_session_time': 'morning',
        'preferred_content_type': 'mixed_content',
      },
      factors: {
        'engagement_score': userInsights['engagement_score'],
        'learning_streak': userInsights['learning_streak'],
      },
      timestamp: DateTime.now(),
      recommendation: 'Schedule learning sessions during predicted optimal times',
    ));
    
    _predictions.add(PredictionResult(
      id: 'progress_prediction',
      type: 'progress',
      category: 'achievement',
      confidence: 0.75,
      prediction: {
        'weekly_progress_rate': 0.15,
        'milestone_completion_date': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        'skill_development_rate': 0.12,
      },
      factors: {
        'current_engagement': userInsights['engagement_score'],
        'goal_alignment': 0.8,
        'learning_efficiency': 0.7,
      },
      timestamp: DateTime.now(),
      recommendation: 'Maintain current pace to achieve milestones on schedule',
    ));
  }

  // Get prediction by type
  PredictionResult? getPredictionByType(String type) {
    try {
      return _predictions.firstWhere((p) => p.type == type);
    } catch (e) {
      return null;
    }
  }

  // Get goal prediction by type
  GoalAchievementPrediction? getGoalPrediction(String goalType) {
    return _goalPredictions[goalType];
  }

  // Get risk assessment by type
  RiskAssessment? getRiskAssessment(String riskType) {
    try {
      return _riskAssessments.firstWhere((r) => r.riskType == riskType);
    } catch (e) {
      return null;
    }
  }

  // Update predictions
  Future<void> updatePredictions(UserProfile userProfile) async {
    await initializePredictions(userProfile);
  }

  // Export prediction data
  Map<String, dynamic> exportPredictionData() {
    return {
      'predictions': _predictions.map((p) => p.toJson()).toList(),
      'goal_predictions': _goalPredictions.map((key, value) => MapEntry(key, value.toJson())),
      'learning_prediction': _learningPrediction?.toJson(),
      'risk_assessments': _riskAssessments.map((r) => r.toJson()).toList(),
    };
  }

  // Import prediction data
  void importPredictionData(Map<String, dynamic> data) {
    if (data['predictions'] != null) {
      _predictions = (data['predictions'] as List)
          .map((p) => PredictionResult.fromJson(p))
          .toList();
    }
    
    if (data['goal_predictions'] != null) {
      _goalPredictions.clear();
      final goalData = data['goal_predictions'] as Map<String, dynamic>;
      for (final entry in goalData.entries) {
        _goalPredictions[entry.key] = GoalAchievementPrediction.fromJson(entry.value);
      }
    }
    
    if (data['learning_prediction'] != null) {
      _learningPrediction = LearningPerformancePrediction.fromJson(data['learning_prediction']);
    }
    
    if (data['risk_assessments'] != null) {
      _riskAssessments = (data['risk_assessments'] as List)
          .map((r) => RiskAssessment.fromJson(r))
          .toList();
    }
    
    notifyListeners();
  }

  // Clear all predictions
  void clearPredictions() {
    _predictions.clear();
    _goalPredictions.clear();
    _learningPrediction = null;
    _riskAssessments.clear();
    notifyListeners();
  }

  // Get summary insights
  Map<String, dynamic> getSummaryInsights() {
    final goalAchievementAvg = _goalPredictions.values.isNotEmpty
        ? _goalPredictions.values.map((g) => g.achievementProbability).reduce((a, b) => a + b) / _goalPredictions.values.length
        : 0.0;
    
    final highRiskCount = _riskAssessments.where((r) => r.riskLevel > 0.6).length;
    
    return {
      'total_predictions': _predictions.length,
      'goal_achievement_average': goalAchievementAvg,
      'learning_retention_rate': _learningPrediction?.retentionRate ?? 0.0,
      'high_risk_areas': highRiskCount,
      'engagement_trend': _learningPrediction?.engagementTrend ?? 0.0,
    };
  }
}