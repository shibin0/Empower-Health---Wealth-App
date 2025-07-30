import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/health_data.dart';

part 'health_providers.g.dart';

@riverpod
class HealthDataNotifier extends _$HealthDataNotifier {
  @override
  Future<List<HealthData>> build() async {
    return await _loadHealthData();
  }

  Future<List<HealthData>> _loadHealthData() async {
    // For now, return mock data until storage services are properly integrated
    return [
      HealthData(
        id: '1',
        userId: 'user1',
        type: HealthMetricType.steps,
        value: 8500,
        unit: 'steps',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        source: DataSource.manual,
      ),
      HealthData(
        id: '2',
        userId: 'user1',
        type: HealthMetricType.weight,
        value: 70.5,
        unit: 'kg',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        source: DataSource.manual,
      ),
    ];
  }

  Future<void> addHealthData(HealthData healthData) async {
    // Add to current state
    final currentData = await future;
    state = AsyncValue.data([...currentData, healthData]);
  }

  Future<void> updateHealthData(HealthData updatedData) async {
    final currentData = await future;
    final updatedList = currentData.map((data) {
      return data.id == updatedData.id ? updatedData : data;
    }).toList();

    state = AsyncValue.data(updatedList);
  }

  Future<void> deleteHealthData(String id) async {
    final currentData = await future;
    final updatedList = currentData.where((data) => data.id != id).toList();

    state = AsyncValue.data(updatedList);
  }

  Future<void> refreshData() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadHealthData());
  }
}

// Filtered providers for specific health metrics
@riverpod
Future<List<HealthData>> healthDataByType(
  HealthDataByTypeRef ref,
  HealthMetricType type,
) async {
  final allData = await ref.watch(healthDataNotifierProvider.future);
  return allData.where((data) => data.type == type).toList();
}

@riverpod
Future<List<HealthData>> healthDataByDateRange(
  HealthDataByDateRangeRef ref,
  DateTime startDate,
  DateTime endDate,
) async {
  final allData = await ref.watch(healthDataNotifierProvider.future);
  return allData.where((data) {
    return data.timestamp.isAfter(startDate) &&
        data.timestamp.isBefore(endDate);
  }).toList();
}

@riverpod
Future<List<HealthData>> recentHealthData(
  RecentHealthDataRef ref, {
  int days = 7,
}) async {
  final endDate = DateTime.now();
  final startDate = endDate.subtract(Duration(days: days));

  return ref.watch(healthDataByDateRangeProvider(startDate, endDate).future);
}

// Health statistics providers
@riverpod
Future<Map<HealthMetricType, double>> healthMetricAverages(
  HealthMetricAveragesRef ref, {
  int days = 30,
}) async {
  final recentData =
      await ref.watch(recentHealthDataProvider(days: days).future);
  final Map<HealthMetricType, List<double>> groupedData = {};

  for (final data in recentData) {
    groupedData.putIfAbsent(data.type, () => []).add(data.value);
  }

  final Map<HealthMetricType, double> averages = {};
  for (final entry in groupedData.entries) {
    final sum = entry.value.reduce((a, b) => a + b);
    averages[entry.key] = sum / entry.value.length;
  }

  return averages;
}

@riverpod
Future<Map<HealthMetricType, HealthTrend>> healthTrends(
  HealthTrendsRef ref, {
  int days = 30,
}) async {
  final endDate = DateTime.now();
  final currentPeriodStart = endDate.subtract(Duration(days: days));
  final previousPeriodStart = currentPeriodStart.subtract(Duration(days: days));

  final currentData = await ref.watch(
    healthDataByDateRangeProvider(currentPeriodStart, endDate).future,
  );
  final previousData = await ref.watch(
    healthDataByDateRangeProvider(previousPeriodStart, currentPeriodStart)
        .future,
  );

  final Map<HealthMetricType, HealthTrend> trends = {};

  // Calculate trends for each metric type
  for (final type in HealthMetricType.values) {
    final currentValues =
        currentData.where((d) => d.type == type).map((d) => d.value).toList();
    final previousValues =
        previousData.where((d) => d.type == type).map((d) => d.value).toList();

    if (currentValues.isNotEmpty && previousValues.isNotEmpty) {
      final currentAvg =
          currentValues.reduce((a, b) => a + b) / currentValues.length;
      final previousAvg =
          previousValues.reduce((a, b) => a + b) / previousValues.length;

      final changePercentage = ((currentAvg - previousAvg) / previousAvg) * 100;

      TrendDirection direction;
      if (changePercentage > 5) {
        direction = type.isHigherBetter
            ? TrendDirection.improving
            : TrendDirection.declining;
      } else if (changePercentage < -5) {
        direction = type.isHigherBetter
            ? TrendDirection.declining
            : TrendDirection.improving;
      } else {
        direction = TrendDirection.stable;
      }

      trends[type] = HealthTrend(
        type: type,
        direction: direction,
        changePercentage: changePercentage.abs(),
        description:
            _generateTrendDescription(type, direction, changePercentage),
        periodStart: currentPeriodStart,
        periodEnd: endDate,
      );
    }
  }

  return trends;
}

String _generateTrendDescription(
  HealthMetricType type,
  TrendDirection direction,
  double changePercentage,
) {
  final metricName = type.displayName;
  final change = changePercentage.abs().toStringAsFixed(1);

  switch (direction) {
    case TrendDirection.improving:
      return '$metricName has improved by $change% this period';
    case TrendDirection.declining:
      return '$metricName has declined by $change% this period';
    case TrendDirection.stable:
      return '$metricName has remained stable this period';
    case TrendDirection.fluctuating:
      return '$metricName has been fluctuating this period';
  }
}

// Health insights provider (would integrate with AI service later)
@riverpod
Future<HealthInsights?> healthInsights(HealthInsightsRef ref) async {
  final healthData = await ref.watch(healthDataNotifierProvider.future);
  final trends = await ref.watch(healthTrendsProvider().future);

  if (healthData.isEmpty) return null;

  // For now, return mock insights
  // Later this would integrate with AI service
  return HealthInsights(
    userId: 'current_user', // Would get from auth
    generatedAt: DateTime.now(),
    trends: trends.values.toList(),
    recommendations: [], // Would be generated by AI
    overallScore: HealthScore(
      overall: 75.0, // Would be calculated
      categoryScores: {}, // Would be calculated
      calculatedAt: DateTime.now(),
      interpretation: 'Good overall health status',
    ),
  );
}

// Sync status for health data (simplified for now)
@riverpod
Future<bool> healthDataSyncStatus(HealthDataSyncStatusRef ref) async {
  // For now, always return true (synced)
  // Later this would check actual sync status
  return true;
}
