import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_data.freezed.dart';
part 'health_data.g.dart';

@freezed
class HealthData with _$HealthData {
  const factory HealthData({
    required String id,
    required String userId,
    required DateTime timestamp,
    required HealthMetricType type,
    required double value,
    required String unit,
    @Default({}) Map<String, dynamic> metadata,
    @Default(false) bool isSynced,
    DateTime? lastSyncedAt,
    @Default(DataSource.manual) DataSource source,
  }) = _HealthData;

  factory HealthData.fromJson(Map<String, dynamic> json) =>
      _$HealthDataFromJson(json);
}

@freezed
class HealthInsights with _$HealthInsights {
  const factory HealthInsights({
    required String userId,
    required DateTime generatedAt,
    required List<HealthTrend> trends,
    required List<HealthRecommendation> recommendations,
    required HealthScore overallScore,
    @Default({}) Map<String, dynamic> additionalData,
  }) = _HealthInsights;

  factory HealthInsights.fromJson(Map<String, dynamic> json) =>
      _$HealthInsightsFromJson(json);
}

@freezed
class HealthTrend with _$HealthTrend {
  const factory HealthTrend({
    required HealthMetricType type,
    required TrendDirection direction,
    required double changePercentage,
    required String description,
    required DateTime periodStart,
    required DateTime periodEnd,
  }) = _HealthTrend;

  factory HealthTrend.fromJson(Map<String, dynamic> json) =>
      _$HealthTrendFromJson(json);
}

@freezed
class HealthRecommendation with _$HealthRecommendation {
  const factory HealthRecommendation({
    required String id,
    required String title,
    required String description,
    required RecommendationPriority priority,
    required HealthMetricType relatedMetric,
    required List<String> actionItems,
    @Default({}) Map<String, dynamic> metadata,
  }) = _HealthRecommendation;

  factory HealthRecommendation.fromJson(Map<String, dynamic> json) =>
      _$HealthRecommendationFromJson(json);
}

@freezed
class HealthScore with _$HealthScore {
  const factory HealthScore({
    required double overall,
    required Map<HealthMetricType, double> categoryScores,
    required DateTime calculatedAt,
    required String interpretation,
  }) = _HealthScore;

  factory HealthScore.fromJson(Map<String, dynamic> json) =>
      _$HealthScoreFromJson(json);
}

enum HealthMetricType {
  @JsonValue('steps')
  steps,
  @JsonValue('heart_rate')
  heartRate,
  @JsonValue('blood_pressure_systolic')
  bloodPressureSystolic,
  @JsonValue('blood_pressure_diastolic')
  bloodPressureDiastolic,
  @JsonValue('weight')
  weight,
  @JsonValue('sleep_duration')
  sleepDuration,
  @JsonValue('sleep_quality')
  sleepQuality,
  @JsonValue('calories_burned')
  caloriesBurned,
  @JsonValue('calories_consumed')
  caloriesConsumed,
  @JsonValue('water_intake')
  waterIntake,
  @JsonValue('mood')
  mood,
  @JsonValue('energy_level')
  energyLevel,
  @JsonValue('stress_level')
  stressLevel,
  @JsonValue('exercise_duration')
  exerciseDuration,
  @JsonValue('meditation_duration')
  meditationDuration,
}

enum DataSource {
  @JsonValue('manual')
  manual,
  @JsonValue('apple_health')
  appleHealth,
  @JsonValue('google_fit')
  googleFit,
  @JsonValue('fitbit')
  fitbit,
  @JsonValue('garmin')
  garmin,
  @JsonValue('samsung_health')
  samsungHealth,
  @JsonValue('api')
  api,
}

enum TrendDirection {
  @JsonValue('improving')
  improving,
  @JsonValue('declining')
  declining,
  @JsonValue('stable')
  stable,
  @JsonValue('fluctuating')
  fluctuating,
}

enum RecommendationPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}

// Extension methods for better usability
extension HealthMetricTypeExtension on HealthMetricType {
  String get displayName {
    switch (this) {
      case HealthMetricType.steps:
        return 'Steps';
      case HealthMetricType.heartRate:
        return 'Heart Rate';
      case HealthMetricType.bloodPressureSystolic:
        return 'Blood Pressure (Systolic)';
      case HealthMetricType.bloodPressureDiastolic:
        return 'Blood Pressure (Diastolic)';
      case HealthMetricType.weight:
        return 'Weight';
      case HealthMetricType.sleepDuration:
        return 'Sleep Duration';
      case HealthMetricType.sleepQuality:
        return 'Sleep Quality';
      case HealthMetricType.caloriesBurned:
        return 'Calories Burned';
      case HealthMetricType.caloriesConsumed:
        return 'Calories Consumed';
      case HealthMetricType.waterIntake:
        return 'Water Intake';
      case HealthMetricType.mood:
        return 'Mood';
      case HealthMetricType.energyLevel:
        return 'Energy Level';
      case HealthMetricType.stressLevel:
        return 'Stress Level';
      case HealthMetricType.exerciseDuration:
        return 'Exercise Duration';
      case HealthMetricType.meditationDuration:
        return 'Meditation Duration';
    }
  }

  String get defaultUnit {
    switch (this) {
      case HealthMetricType.steps:
        return 'steps';
      case HealthMetricType.heartRate:
        return 'bpm';
      case HealthMetricType.bloodPressureSystolic:
      case HealthMetricType.bloodPressureDiastolic:
        return 'mmHg';
      case HealthMetricType.weight:
        return 'kg';
      case HealthMetricType.sleepDuration:
      case HealthMetricType.exerciseDuration:
      case HealthMetricType.meditationDuration:
        return 'minutes';
      case HealthMetricType.sleepQuality:
      case HealthMetricType.mood:
      case HealthMetricType.energyLevel:
      case HealthMetricType.stressLevel:
        return 'score';
      case HealthMetricType.caloriesBurned:
      case HealthMetricType.caloriesConsumed:
        return 'kcal';
      case HealthMetricType.waterIntake:
        return 'ml';
    }
  }

  bool get isHigherBetter {
    switch (this) {
      case HealthMetricType.steps:
      case HealthMetricType.sleepDuration:
      case HealthMetricType.sleepQuality:
      case HealthMetricType.caloriesBurned:
      case HealthMetricType.waterIntake:
      case HealthMetricType.mood:
      case HealthMetricType.energyLevel:
      case HealthMetricType.exerciseDuration:
      case HealthMetricType.meditationDuration:
        return true;
      case HealthMetricType.heartRate:
      case HealthMetricType.bloodPressureSystolic:
      case HealthMetricType.bloodPressureDiastolic:
      case HealthMetricType.weight:
      case HealthMetricType.caloriesConsumed:
      case HealthMetricType.stressLevel:
        return false;
    }
  }
}