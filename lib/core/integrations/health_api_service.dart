import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/health/models/health_data.dart';

part 'health_api_service.g.dart';

/// Health API integration service for Apple HealthKit and Google Fit
@riverpod
class HealthApiService extends _$HealthApiService {
  Health? _health;
  Timer? _syncTimer;
  bool _isInitialized = false;

  @override
  Future<HealthApiService> build() async {
    await _initializeHealthService();
    return this;
  }

  /// Initialize health service
  Future<void> _initializeHealthService() async {
    try {
      _health = Health();
      
      // Request permissions
      final hasPermissions = await _requestPermissions();
      if (hasPermissions) {
        _isInitialized = true;
        _startPeriodicSync();
        debugPrint('Health API service initialized successfully');
      } else {
        debugPrint('Health permissions not granted');
      }
    } catch (e) {
      debugPrint('Failed to initialize health service: $e');
    }
  }

  /// Request health permissions
  Future<bool> _requestPermissions() async {
    if (_health == null) return false;

    final types = [
      HealthDataType.STEPS,
      HealthDataType.HEART_RATE,
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      HealthDataType.BODY_MASS_INDEX,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.DISTANCE_WALKING_RUNNING,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.WORKOUT,
    ];

    final permissions = [
      for (final type in types) HealthDataAccess.READ,
    ];

    try {
      final granted = await _health!.requestAuthorization(types, permissions: permissions);
      return granted;
    } catch (e) {
      debugPrint('Permission request failed: $e');
      return false;
    }
  }

  /// Start periodic health data sync
  void _startPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(const Duration(hours: 1), (timer) {
      _syncHealthData();
    });
  }

  /// Sync health data from device
  Future<void> _syncHealthData() async {
    if (!_isInitialized || _health == null) return;

    try {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));

      // Fetch different types of health data
      await Future.wait([
        _syncStepsData(yesterday, now),
        _syncHeartRateData(yesterday, now),
        _syncWeightData(yesterday, now),
        _syncSleepData(yesterday, now),
        _syncWorkoutData(yesterday, now),
        _syncBloodPressureData(yesterday, now),
      ]);

      debugPrint('Health data sync completed');
    } catch (e) {
      debugPrint('Health data sync failed: $e');
    }
  }

  /// Sync steps data
  Future<void> _syncStepsData(DateTime from, DateTime to) async {
    try {
      final healthData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: from,
        endTime: to,
      );

      for (final data in healthData) {
        final healthEntry = HealthData(
          id: 'steps_${data.dateFrom.millisecondsSinceEpoch}',
          userId: 'current_user', // TODO: Get from auth service
          type: HealthMetricType.steps,
          value: (data.value as NumericHealthValue).numericValue.toDouble(),
          unit: 'steps',
          timestamp: data.dateFrom,
          source: DataSource.appleHealth,
          metadata: {
            'platform': data.sourcePlatform.name,
            'source_name': data.sourceName ?? 'Health App',
          },
        );

        // TODO: Store locally and sync later
        debugPrint('Steps data collected: ${healthEntry.value} steps');
      }
    } catch (e) {
      debugPrint('Steps sync failed: $e');
    }
  }

  /// Sync heart rate data
  Future<void> _syncHeartRateData(DateTime from, DateTime to) async {
    try {
      final healthData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: from,
        endTime: to,
      );

      for (final data in healthData) {
        final healthEntry = HealthData(
          id: 'heart_rate_${data.dateFrom.millisecondsSinceEpoch}',
          userId: 'current_user', // TODO: Get from auth service
          type: HealthMetricType.heartRate,
          value: (data.value as NumericHealthValue).numericValue.toDouble(),
          unit: 'bpm',
          timestamp: data.dateFrom,
          source: DataSource.appleHealth,
          metadata: {
            'platform': data.sourcePlatform.name,
            'source_name': data.sourceName ?? 'Health App',
          },
        );

        debugPrint('Heart rate data collected: ${healthEntry.value} bpm');
      }
    } catch (e) {
      debugPrint('Heart rate sync failed: $e');
    }
  }

  /// Sync weight data
  Future<void> _syncWeightData(DateTime from, DateTime to) async {
    try {
      final healthData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.WEIGHT],
        startTime: from,
        endTime: to,
      );

      for (final data in healthData) {
        final healthEntry = HealthData(
          id: 'weight_${data.dateFrom.millisecondsSinceEpoch}',
          userId: 'current_user', // TODO: Get from auth service
          type: HealthMetricType.weight,
          value: (data.value as NumericHealthValue).numericValue.toDouble(),
          unit: 'kg',
          timestamp: data.dateFrom,
          source: DataSource.appleHealth,
          metadata: {
            'platform': data.sourcePlatform.name,
            'source_name': data.sourceName ?? 'Health App',
          },
        );

        debugPrint('Weight data collected: ${healthEntry.value} kg');
      }
    } catch (e) {
      debugPrint('Weight sync failed: $e');
    }
  }

  /// Sync sleep data
  Future<void> _syncSleepData(DateTime from, DateTime to) async {
    try {
      final healthData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.SLEEP_IN_BED, HealthDataType.SLEEP_ASLEEP],
        startTime: from,
        endTime: to,
      );

      for (final data in healthData) {
        final healthEntry = HealthData(
          id: 'sleep_${data.dateFrom.millisecondsSinceEpoch}',
          userId: 'current_user', // TODO: Get from auth service
          type: HealthMetricType.sleepDuration,
          value: data.dateTo.difference(data.dateFrom).inMinutes.toDouble(),
          unit: 'minutes',
          timestamp: data.dateFrom,
          source: DataSource.appleHealth,
          metadata: {
            'platform': data.sourcePlatform.name,
            'source_name': data.sourceName ?? 'Health App',
            'sleep_type': data.type.name,
            'end_time': data.dateTo.toIso8601String(),
          },
        );

        debugPrint('Sleep data collected: ${healthEntry.value} minutes');
      }
    } catch (e) {
      debugPrint('Sleep sync failed: $e');
    }
  }

  /// Sync workout data
  Future<void> _syncWorkoutData(DateTime from, DateTime to) async {
    try {
      final healthData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.WORKOUT],
        startTime: from,
        endTime: to,
      );

      for (final data in healthData) {
        final workoutData = data.value as WorkoutHealthValue;
        
        final healthEntry = HealthData(
          id: 'workout_${data.dateFrom.millisecondsSinceEpoch}',
          userId: 'current_user', // TODO: Get from auth service
          type: HealthMetricType.exerciseDuration,
          value: data.dateTo.difference(data.dateFrom).inMinutes.toDouble(),
          unit: 'minutes',
          timestamp: data.dateFrom,
          source: DataSource.appleHealth,
          metadata: {
            'platform': data.sourcePlatform.name,
            'source_name': data.sourceName ?? 'Health App',
            'workout_type': workoutData.workoutActivityType.name,
            'end_time': data.dateTo.toIso8601String(),
            'total_energy_burned': workoutData.totalEnergyBurned?.toString(),
            'total_distance': workoutData.totalDistance?.toString(),
          },
        );

        debugPrint('Workout data collected: ${healthEntry.value} minutes');
      }
    } catch (e) {
      debugPrint('Workout sync failed: $e');
    }
  }

  /// Sync blood pressure data
  Future<void> _syncBloodPressureData(DateTime from, DateTime to) async {
    try {
      final systolicData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.BLOOD_PRESSURE_SYSTOLIC],
        startTime: from,
        endTime: to,
      );

      final diastolicData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.BLOOD_PRESSURE_DIASTOLIC],
        startTime: from,
        endTime: to,
      );

      // Group systolic and diastolic readings by timestamp
      final Map<DateTime, Map<String, double>> bloodPressureReadings = {};
      
      for (final data in systolicData) {
        final timestamp = data.dateFrom;
        bloodPressureReadings[timestamp] ??= {};
        bloodPressureReadings[timestamp]!['systolic'] = 
            (data.value as NumericHealthValue).numericValue.toDouble();
      }
      
      for (final data in diastolicData) {
        final timestamp = data.dateFrom;
        bloodPressureReadings[timestamp] ??= {};
        bloodPressureReadings[timestamp]!['diastolic'] = 
            (data.value as NumericHealthValue).numericValue.toDouble();
      }

      // Create health entries for complete blood pressure readings
      for (final entry in bloodPressureReadings.entries) {
        final timestamp = entry.key;
        final readings = entry.value;
        
        if (readings.containsKey('systolic') && readings.containsKey('diastolic')) {
          final systolicEntry = HealthData(
            id: 'bp_systolic_${timestamp.millisecondsSinceEpoch}',
            userId: 'current_user', // TODO: Get from auth service
            type: HealthMetricType.bloodPressureSystolic,
            value: readings['systolic']!,
            unit: 'mmHg',
            timestamp: timestamp,
            source: DataSource.appleHealth,
            metadata: {
              'systolic': readings['systolic']!,
              'diastolic': readings['diastolic']!,
              'platform': Platform.isIOS ? 'ios' : 'android',
            },
          );

          final diastolicEntry = HealthData(
            id: 'bp_diastolic_${timestamp.millisecondsSinceEpoch}',
            userId: 'current_user', // TODO: Get from auth service
            type: HealthMetricType.bloodPressureDiastolic,
            value: readings['diastolic']!,
            unit: 'mmHg',
            timestamp: timestamp,
            source: DataSource.appleHealth,
            metadata: {
              'systolic': readings['systolic']!,
              'diastolic': readings['diastolic']!,
              'platform': Platform.isIOS ? 'ios' : 'android',
            },
          );

          debugPrint('Blood pressure data collected: ${readings['systolic']}/${readings['diastolic']} mmHg');
        }
      }
    } catch (e) {
      debugPrint('Blood pressure sync failed: $e');
    }
  }

  /// Manual sync trigger
  Future<void> forceSyncHealthData() async {
    await _syncHealthData();
  }

  /// Get health data for a specific type and date range
  Future<List<HealthData>> getHealthDataByType(
    HealthMetricType type,
    DateTime from,
    DateTime to,
  ) async {
    if (!_isInitialized || _health == null) return [];

    try {
      final healthDataType = _mapHealthMetricTypeToHealthDataType(type);
      if (healthDataType == null) return [];

      final healthData = await _health!.getHealthDataFromTypes(
        types: [healthDataType],
        startTime: from,
        endTime: to,
      );

      return healthData.map((data) {
        return HealthData(
          id: '${type.name}_${data.dateFrom.millisecondsSinceEpoch}',
          userId: 'current_user', // TODO: Get from auth service
          type: type,
          value: (data.value as NumericHealthValue).numericValue.toDouble(),
          unit: _getUnitForHealthType(type),
          timestamp: data.dateFrom,
          source: DataSource.appleHealth,
          metadata: {
            'platform': data.sourcePlatform.name,
            'source_name': data.sourceName ?? 'Health App',
          },
        );
      }).toList();
    } catch (e) {
      debugPrint('Failed to get health data for type $type: $e');
      return [];
    }
  }

  /// Map HealthMetricType to HealthDataType
  HealthDataType? _mapHealthMetricTypeToHealthDataType(HealthMetricType type) {
    switch (type) {
      case HealthMetricType.steps:
        return HealthDataType.STEPS;
      case HealthMetricType.heartRate:
        return HealthDataType.HEART_RATE;
      case HealthMetricType.weight:
        return HealthDataType.WEIGHT;
      case HealthMetricType.sleepDuration:
        return HealthDataType.SLEEP_IN_BED;
      case HealthMetricType.exerciseDuration:
        return HealthDataType.WORKOUT;
      case HealthMetricType.bloodPressureSystolic:
        return HealthDataType.BLOOD_PRESSURE_SYSTOLIC;
      case HealthMetricType.bloodPressureDiastolic:
        return HealthDataType.BLOOD_PRESSURE_DIASTOLIC;
      default:
        return null;
    }
  }

  /// Get unit for health type
  String _getUnitForHealthType(HealthMetricType type) {
    switch (type) {
      case HealthMetricType.steps:
        return 'steps';
      case HealthMetricType.heartRate:
        return 'bpm';
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
      case HealthMetricType.bloodPressureSystolic:
      case HealthMetricType.bloodPressureDiastolic:
        return 'mmHg';
    }
  }

  /// Check if health data is available
  Future<bool> isHealthDataAvailable() async {
    if (_health == null) return false;
    
    try {
      return _health!.isDataTypeAvailable(HealthDataType.STEPS);
    } catch (e) {
      return false;
    }
  }

  /// Get health permissions status
  Future<Map<HealthDataType, HealthDataAccess>> getPermissionsStatus() async {
    if (_health == null) return {};

    final types = [
      HealthDataType.STEPS,
      HealthDataType.HEART_RATE,
      HealthDataType.WEIGHT,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.WORKOUT,
    ];

    try {
      // Note: hasPermissions returns bool, not Map
      // For now, return empty map as this is a placeholder implementation
      return {};
    } catch (e) {
      debugPrint('Failed to get permissions status: $e');
      return {};
    }
  }

  /// Dispose resources
  void dispose() {
    _syncTimer?.cancel();
  }
}