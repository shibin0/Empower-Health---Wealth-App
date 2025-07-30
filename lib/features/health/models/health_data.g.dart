// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthDataImpl _$$HealthDataImplFromJson(Map<String, dynamic> json) =>
    _$HealthDataImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: $enumDecode(_$HealthMetricTypeEnumMap, json['type']),
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      isSynced: json['isSynced'] as bool? ?? false,
      lastSyncedAt: json['lastSyncedAt'] == null
          ? null
          : DateTime.parse(json['lastSyncedAt'] as String),
      source: $enumDecodeNullable(_$DataSourceEnumMap, json['source']) ??
          DataSource.manual,
    );

Map<String, dynamic> _$$HealthDataImplToJson(_$HealthDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': _$HealthMetricTypeEnumMap[instance.type]!,
      'value': instance.value,
      'unit': instance.unit,
      'metadata': instance.metadata,
      'isSynced': instance.isSynced,
      'lastSyncedAt': instance.lastSyncedAt?.toIso8601String(),
      'source': _$DataSourceEnumMap[instance.source]!,
    };

const _$HealthMetricTypeEnumMap = {
  HealthMetricType.steps: 'steps',
  HealthMetricType.heartRate: 'heart_rate',
  HealthMetricType.bloodPressureSystolic: 'blood_pressure_systolic',
  HealthMetricType.bloodPressureDiastolic: 'blood_pressure_diastolic',
  HealthMetricType.weight: 'weight',
  HealthMetricType.sleepDuration: 'sleep_duration',
  HealthMetricType.sleepQuality: 'sleep_quality',
  HealthMetricType.caloriesBurned: 'calories_burned',
  HealthMetricType.caloriesConsumed: 'calories_consumed',
  HealthMetricType.waterIntake: 'water_intake',
  HealthMetricType.mood: 'mood',
  HealthMetricType.energyLevel: 'energy_level',
  HealthMetricType.stressLevel: 'stress_level',
  HealthMetricType.exerciseDuration: 'exercise_duration',
  HealthMetricType.meditationDuration: 'meditation_duration',
};

const _$DataSourceEnumMap = {
  DataSource.manual: 'manual',
  DataSource.appleHealth: 'apple_health',
  DataSource.googleFit: 'google_fit',
  DataSource.fitbit: 'fitbit',
  DataSource.garmin: 'garmin',
  DataSource.samsungHealth: 'samsung_health',
  DataSource.api: 'api',
};

_$HealthInsightsImpl _$$HealthInsightsImplFromJson(Map<String, dynamic> json) =>
    _$HealthInsightsImpl(
      userId: json['userId'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      trends: (json['trends'] as List<dynamic>)
          .map((e) => HealthTrend.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => HealthRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      overallScore:
          HealthScore.fromJson(json['overallScore'] as Map<String, dynamic>),
      additionalData:
          json['additionalData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$HealthInsightsImplToJson(
        _$HealthInsightsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'trends': instance.trends,
      'recommendations': instance.recommendations,
      'overallScore': instance.overallScore,
      'additionalData': instance.additionalData,
    };

_$HealthTrendImpl _$$HealthTrendImplFromJson(Map<String, dynamic> json) =>
    _$HealthTrendImpl(
      type: $enumDecode(_$HealthMetricTypeEnumMap, json['type']),
      direction: $enumDecode(_$TrendDirectionEnumMap, json['direction']),
      changePercentage: (json['changePercentage'] as num).toDouble(),
      description: json['description'] as String,
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: DateTime.parse(json['periodEnd'] as String),
    );

Map<String, dynamic> _$$HealthTrendImplToJson(_$HealthTrendImpl instance) =>
    <String, dynamic>{
      'type': _$HealthMetricTypeEnumMap[instance.type]!,
      'direction': _$TrendDirectionEnumMap[instance.direction]!,
      'changePercentage': instance.changePercentage,
      'description': instance.description,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
    };

const _$TrendDirectionEnumMap = {
  TrendDirection.improving: 'improving',
  TrendDirection.declining: 'declining',
  TrendDirection.stable: 'stable',
  TrendDirection.fluctuating: 'fluctuating',
};

_$HealthRecommendationImpl _$$HealthRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthRecommendationImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: $enumDecode(_$RecommendationPriorityEnumMap, json['priority']),
      relatedMetric:
          $enumDecode(_$HealthMetricTypeEnumMap, json['relatedMetric']),
      actionItems: (json['actionItems'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$HealthRecommendationImplToJson(
        _$HealthRecommendationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': _$RecommendationPriorityEnumMap[instance.priority]!,
      'relatedMetric': _$HealthMetricTypeEnumMap[instance.relatedMetric]!,
      'actionItems': instance.actionItems,
      'metadata': instance.metadata,
    };

const _$RecommendationPriorityEnumMap = {
  RecommendationPriority.low: 'low',
  RecommendationPriority.medium: 'medium',
  RecommendationPriority.high: 'high',
  RecommendationPriority.critical: 'critical',
};

_$HealthScoreImpl _$$HealthScoreImplFromJson(Map<String, dynamic> json) =>
    _$HealthScoreImpl(
      overall: (json['overall'] as num).toDouble(),
      categoryScores: (json['categoryScores'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$HealthMetricTypeEnumMap, k), (e as num).toDouble()),
      ),
      calculatedAt: DateTime.parse(json['calculatedAt'] as String),
      interpretation: json['interpretation'] as String,
    );

Map<String, dynamic> _$$HealthScoreImplToJson(_$HealthScoreImpl instance) =>
    <String, dynamic>{
      'overall': instance.overall,
      'categoryScores': instance.categoryScores
          .map((k, e) => MapEntry(_$HealthMetricTypeEnumMap[k]!, e)),
      'calculatedAt': instance.calculatedAt.toIso8601String(),
      'interpretation': instance.interpretation,
    };
