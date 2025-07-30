import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_models.freezed.dart';
part 'ai_models.g.dart';

/// AI Recommendation Types
enum RecommendationType {
  health,
  wealth,
  lifestyle,
  goal,
  risk,
  educational
}

/// AI Confidence Levels
enum ConfidenceLevel {
  low,
  medium,
  high,
  veryHigh
}

/// AI Insight Categories
enum InsightCategory {
  trend,
  prediction,
  recommendation,
  alert,
  achievement,
  optimization
}

/// AI Recommendation Model
@freezed
class AIRecommendation with _$AIRecommendation {
  const factory AIRecommendation({
    required String id,
    required String title,
    required String description,
    required RecommendationType type,
    required ConfidenceLevel confidence,
    required double score,
    required List<String> tags,
    required Map<String, dynamic> metadata,
    required DateTime createdAt,
    DateTime? expiresAt,
    String? actionUrl,
    bool? isPersonalized,
    @Default([]) List<String> reasons,
  }) = _AIRecommendation;

  factory AIRecommendation.fromJson(Map<String, dynamic> json) =>
      _$AIRecommendationFromJson(json);
}

/// AI Insight Model
@freezed
class AIInsight with _$AIInsight {
  const factory AIInsight({
    required String id,
    required String title,
    required String content,
    required InsightCategory category,
    required ConfidenceLevel confidence,
    required double relevanceScore,
    required DateTime generatedAt,
    required Map<String, dynamic> data,
    @Default([]) List<String> visualizations,
    @Default([]) List<AIRecommendation> relatedRecommendations,
    String? sourceDataId,
    bool? isActionable,
  }) = _AIInsight;

  factory AIInsight.fromJson(Map<String, dynamic> json) =>
      _$AIInsightFromJson(json);
}

/// User Behavior Analytics Model
@freezed
class UserBehaviorAnalytics with _$UserBehaviorAnalytics {
  const factory UserBehaviorAnalytics({
    required String userId,
    required Map<String, int> actionCounts,
    required Map<String, double> engagementScores,
    required List<String> preferredCategories,
    required Map<String, DateTime> lastActivityTimes,
    required double overallEngagementScore,
    required DateTime lastUpdated,
    @Default({}) Map<String, dynamic> patterns,
    @Default([]) List<String> interests,
  }) = _UserBehaviorAnalytics;

  factory UserBehaviorAnalytics.fromJson(Map<String, dynamic> json) =>
      _$UserBehaviorAnalyticsFromJson(json);
}

/// AI Prediction Model
@freezed
class AIPrediction with _$AIPrediction {
  const factory AIPrediction({
    required String id,
    required String type,
    required String description,
    required double probability,
    required DateTime predictedDate,
    required Map<String, dynamic> factors,
    required ConfidenceLevel confidence,
    required DateTime createdAt,
    @Default({}) Map<String, double> alternativeOutcomes,
    String? category,
    bool? isPositive,
  }) = _AIPrediction;

  factory AIPrediction.fromJson(Map<String, dynamic> json) =>
      _$AIPredictionFromJson(json);
}

/// AI Chat Message Model
@freezed
class AIChatMessage with _$AIChatMessage {
  const factory AIChatMessage({
    required String id,
    required String content,
    required bool isUser,
    required DateTime timestamp,
    @Default([]) List<AIRecommendation> recommendations,
    @Default([]) List<AIInsight> insights,
    String? context,
    Map<String, dynamic>? metadata,
  }) = _AIChatMessage;

  factory AIChatMessage.fromJson(Map<String, dynamic> json) =>
      _$AIChatMessageFromJson(json);
}

/// AI Model Performance Metrics
@freezed
class AIModelMetrics with _$AIModelMetrics {
  const factory AIModelMetrics({
    required String modelId,
    required double accuracy,
    required double precision,
    required double recall,
    required double f1Score,
    required int totalPredictions,
    required int correctPredictions,
    required DateTime lastEvaluated,
    @Default({}) Map<String, double> categoryPerformance,
  }) = _AIModelMetrics;

  factory AIModelMetrics.fromJson(Map<String, dynamic> json) =>
      _$AIModelMetricsFromJson(json);
}

/// AI Configuration Model
@freezed
class AIConfiguration with _$AIConfiguration {
  const factory AIConfiguration({
    required String userId,
    required bool enablePersonalization,
    required bool enablePredictions,
    required bool enableRecommendations,
    required double confidenceThreshold,
    required List<String> enabledCategories,
    required Map<String, dynamic> preferences,
    required DateTime lastUpdated,
    @Default(true) bool enableLearning,
    @Default(0.7) double relevanceThreshold,
  }) = _AIConfiguration;

  factory AIConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AIConfigurationFromJson(json);
}