// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AIRecommendationImpl _$$AIRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$AIRecommendationImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$RecommendationTypeEnumMap, json['type']),
      confidence: $enumDecode(_$ConfidenceLevelEnumMap, json['confidence']),
      score: (json['score'] as num).toDouble(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      metadata: json['metadata'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      actionUrl: json['actionUrl'] as String?,
      isPersonalized: json['isPersonalized'] as bool?,
      reasons: (json['reasons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AIRecommendationImplToJson(
        _$AIRecommendationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$RecommendationTypeEnumMap[instance.type]!,
      'confidence': _$ConfidenceLevelEnumMap[instance.confidence]!,
      'score': instance.score,
      'tags': instance.tags,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'actionUrl': instance.actionUrl,
      'isPersonalized': instance.isPersonalized,
      'reasons': instance.reasons,
    };

const _$RecommendationTypeEnumMap = {
  RecommendationType.health: 'health',
  RecommendationType.wealth: 'wealth',
  RecommendationType.lifestyle: 'lifestyle',
  RecommendationType.goal: 'goal',
  RecommendationType.risk: 'risk',
  RecommendationType.educational: 'educational',
};

const _$ConfidenceLevelEnumMap = {
  ConfidenceLevel.low: 'low',
  ConfidenceLevel.medium: 'medium',
  ConfidenceLevel.high: 'high',
  ConfidenceLevel.veryHigh: 'veryHigh',
};

_$AIInsightImpl _$$AIInsightImplFromJson(Map<String, dynamic> json) =>
    _$AIInsightImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      category: $enumDecode(_$InsightCategoryEnumMap, json['category']),
      confidence: $enumDecode(_$ConfidenceLevelEnumMap, json['confidence']),
      relevanceScore: (json['relevanceScore'] as num).toDouble(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      data: json['data'] as Map<String, dynamic>,
      visualizations: (json['visualizations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      relatedRecommendations: (json['relatedRecommendations'] as List<dynamic>?)
              ?.map((e) => AIRecommendation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sourceDataId: json['sourceDataId'] as String?,
      isActionable: json['isActionable'] as bool?,
    );

Map<String, dynamic> _$$AIInsightImplToJson(_$AIInsightImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'category': _$InsightCategoryEnumMap[instance.category]!,
      'confidence': _$ConfidenceLevelEnumMap[instance.confidence]!,
      'relevanceScore': instance.relevanceScore,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'data': instance.data,
      'visualizations': instance.visualizations,
      'relatedRecommendations': instance.relatedRecommendations,
      'sourceDataId': instance.sourceDataId,
      'isActionable': instance.isActionable,
    };

const _$InsightCategoryEnumMap = {
  InsightCategory.trend: 'trend',
  InsightCategory.prediction: 'prediction',
  InsightCategory.recommendation: 'recommendation',
  InsightCategory.alert: 'alert',
  InsightCategory.achievement: 'achievement',
  InsightCategory.optimization: 'optimization',
};

_$UserBehaviorAnalyticsImpl _$$UserBehaviorAnalyticsImplFromJson(
        Map<String, dynamic> json) =>
    _$UserBehaviorAnalyticsImpl(
      userId: json['userId'] as String,
      actionCounts: Map<String, int>.from(json['actionCounts'] as Map),
      engagementScores: (json['engagementScores'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      preferredCategories: (json['preferredCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastActivityTimes:
          (json['lastActivityTimes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, DateTime.parse(e as String)),
      ),
      overallEngagementScore:
          (json['overallEngagementScore'] as num).toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      patterns: json['patterns'] as Map<String, dynamic>? ?? const {},
      interests: (json['interests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserBehaviorAnalyticsImplToJson(
        _$UserBehaviorAnalyticsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'actionCounts': instance.actionCounts,
      'engagementScores': instance.engagementScores,
      'preferredCategories': instance.preferredCategories,
      'lastActivityTimes': instance.lastActivityTimes
          .map((k, e) => MapEntry(k, e.toIso8601String())),
      'overallEngagementScore': instance.overallEngagementScore,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'patterns': instance.patterns,
      'interests': instance.interests,
    };

_$AIPredictionImpl _$$AIPredictionImplFromJson(Map<String, dynamic> json) =>
    _$AIPredictionImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      probability: (json['probability'] as num).toDouble(),
      predictedDate: DateTime.parse(json['predictedDate'] as String),
      factors: json['factors'] as Map<String, dynamic>,
      confidence: $enumDecode(_$ConfidenceLevelEnumMap, json['confidence']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      alternativeOutcomes:
          (json['alternativeOutcomes'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      category: json['category'] as String?,
      isPositive: json['isPositive'] as bool?,
    );

Map<String, dynamic> _$$AIPredictionImplToJson(_$AIPredictionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'description': instance.description,
      'probability': instance.probability,
      'predictedDate': instance.predictedDate.toIso8601String(),
      'factors': instance.factors,
      'confidence': _$ConfidenceLevelEnumMap[instance.confidence]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'alternativeOutcomes': instance.alternativeOutcomes,
      'category': instance.category,
      'isPositive': instance.isPositive,
    };

_$AIChatMessageImpl _$$AIChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$AIChatMessageImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      isUser: json['isUser'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      recommendations: (json['recommendations'] as List<dynamic>?)
              ?.map((e) => AIRecommendation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      insights: (json['insights'] as List<dynamic>?)
              ?.map((e) => AIInsight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      context: json['context'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AIChatMessageImplToJson(_$AIChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isUser': instance.isUser,
      'timestamp': instance.timestamp.toIso8601String(),
      'recommendations': instance.recommendations,
      'insights': instance.insights,
      'context': instance.context,
      'metadata': instance.metadata,
    };

_$AIModelMetricsImpl _$$AIModelMetricsImplFromJson(Map<String, dynamic> json) =>
    _$AIModelMetricsImpl(
      modelId: json['modelId'] as String,
      accuracy: (json['accuracy'] as num).toDouble(),
      precision: (json['precision'] as num).toDouble(),
      recall: (json['recall'] as num).toDouble(),
      f1Score: (json['f1Score'] as num).toDouble(),
      totalPredictions: (json['totalPredictions'] as num).toInt(),
      correctPredictions: (json['correctPredictions'] as num).toInt(),
      lastEvaluated: DateTime.parse(json['lastEvaluated'] as String),
      categoryPerformance:
          (json['categoryPerformance'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
    );

Map<String, dynamic> _$$AIModelMetricsImplToJson(
        _$AIModelMetricsImpl instance) =>
    <String, dynamic>{
      'modelId': instance.modelId,
      'accuracy': instance.accuracy,
      'precision': instance.precision,
      'recall': instance.recall,
      'f1Score': instance.f1Score,
      'totalPredictions': instance.totalPredictions,
      'correctPredictions': instance.correctPredictions,
      'lastEvaluated': instance.lastEvaluated.toIso8601String(),
      'categoryPerformance': instance.categoryPerformance,
    };

_$AIConfigurationImpl _$$AIConfigurationImplFromJson(
        Map<String, dynamic> json) =>
    _$AIConfigurationImpl(
      userId: json['userId'] as String,
      enablePersonalization: json['enablePersonalization'] as bool,
      enablePredictions: json['enablePredictions'] as bool,
      enableRecommendations: json['enableRecommendations'] as bool,
      confidenceThreshold: (json['confidenceThreshold'] as num).toDouble(),
      enabledCategories: (json['enabledCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      preferences: json['preferences'] as Map<String, dynamic>,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      enableLearning: json['enableLearning'] as bool? ?? true,
      relevanceThreshold:
          (json['relevanceThreshold'] as num?)?.toDouble() ?? 0.7,
    );

Map<String, dynamic> _$$AIConfigurationImplToJson(
        _$AIConfigurationImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'enablePersonalization': instance.enablePersonalization,
      'enablePredictions': instance.enablePredictions,
      'enableRecommendations': instance.enableRecommendations,
      'confidenceThreshold': instance.confidenceThreshold,
      'enabledCategories': instance.enabledCategories,
      'preferences': instance.preferences,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'enableLearning': instance.enableLearning,
      'relevanceThreshold': instance.relevanceThreshold,
    };
