import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/ai_models.dart';
import '../../storage/enhanced_storage_service.dart';

part 'ml_pipeline_service.g.dart';

@riverpod
MLPipelineService mlPipelineService(MLPipelineServiceRef ref) {
  return MLPipelineService(ref);
}

/// Machine Learning Pipeline Service for predictive analytics
class MLPipelineService {
  final Ref _ref;
  static const String _modelDataKey = 'ml_model_data';
  static const String _trainingDataKey = 'ml_training_data';
  
  MLPipelineService(this._ref);

  /// Train health prediction model
  Future<AIModelMetrics> trainHealthPredictionModel({
    required List<Map<String, dynamic>> trainingData,
    required String modelId,
  }) async {
    try {
      final storage = _ref.read(enhancedStorageServiceProvider);
      
      // Simple linear regression for health trends
      final healthModel = _trainLinearRegressionModel(trainingData, 'health_score');
      
      // Store model
      await storage.setMap('${_modelDataKey}_health_$modelId', {
        'model': healthModel,
        'type': 'health_prediction',
        'trained_at': DateTime.now().toIso8601String(),
        'training_size': trainingData.length,
      });

      // Calculate metrics
      final metrics = _calculateModelMetrics(healthModel, trainingData, 'health_score');
      
      return AIModelMetrics(
        modelId: 'health_$modelId',
        accuracy: metrics['accuracy']!,
        precision: metrics['precision']!,
        recall: metrics['recall']!,
        f1Score: metrics['f1Score']!,
        totalPredictions: trainingData.length,
        correctPredictions: (trainingData.length * metrics['accuracy']!).round(),
        lastEvaluated: DateTime.now(),
        categoryPerformance: {
          'health': metrics['accuracy']!,
        },
      );
    } catch (e) {
      throw Exception('Failed to train health prediction model: $e');
    }
  }

  /// Train wealth prediction model
  Future<AIModelMetrics> trainWealthPredictionModel({
    required List<Map<String, dynamic>> trainingData,
    required String modelId,
  }) async {
    try {
      final storage = _ref.read(enhancedStorageServiceProvider);
      
      // Simple linear regression for wealth trends
      final wealthModel = _trainLinearRegressionModel(trainingData, 'wealth_score');
      
      // Store model
      await storage.setMap('${_modelDataKey}_wealth_$modelId', {
        'model': wealthModel,
        'type': 'wealth_prediction',
        'trained_at': DateTime.now().toIso8601String(),
        'training_size': trainingData.length,
      });

      // Calculate metrics
      final metrics = _calculateModelMetrics(wealthModel, trainingData, 'wealth_score');
      
      return AIModelMetrics(
        modelId: 'wealth_$modelId',
        accuracy: metrics['accuracy']!,
        precision: metrics['precision']!,
        recall: metrics['recall']!,
        f1Score: metrics['f1Score']!,
        totalPredictions: trainingData.length,
        correctPredictions: (trainingData.length * metrics['accuracy']!).round(),
        lastEvaluated: DateTime.now(),
        categoryPerformance: {
          'wealth': metrics['accuracy']!,
        },
      );
    } catch (e) {
      throw Exception('Failed to train wealth prediction model: $e');
    }
  }

  /// Predict health trends
  Future<List<AIPrediction>> predictHealthTrends({
    required Map<String, dynamic> currentHealthData,
    required String userId,
    int daysAhead = 30,
  }) async {
    try {
      final storage = _ref.read(enhancedStorageServiceProvider);
      final modelData = await storage.getMap('${_modelDataKey}_health_$userId');
      
      if (modelData == null) {
        return _generateDefaultHealthPredictions(currentHealthData, daysAhead);
      }

      final model = modelData['model'] as Map<String, dynamic>;
      final predictions = <AIPrediction>[];

      // Predict health score trends
      final currentScore = _calculateHealthScore(currentHealthData);
      final futureScore = _predictWithLinearModel(model, currentScore, daysAhead);
      
      predictions.add(AIPrediction(
        id: 'health_trend_${DateTime.now().millisecondsSinceEpoch}',
        type: 'health_trend',
        description: 'Predicted health score trend over next $daysAhead days',
        probability: _calculatePredictionProbability(model),
        predictedDate: DateTime.now().add(Duration(days: daysAhead)),
        factors: {
          'current_score': currentScore,
          'predicted_score': futureScore,
          'trend': futureScore > currentScore ? 'improving' : 'declining',
        },
        confidence: _getConfidenceFromAccuracy(model['accuracy'] ?? 0.7),
        createdAt: DateTime.now(),
      ));

      // Predict specific health metrics
      if (currentHealthData.containsKey('steps')) {
        final stepsPredict = _predictStepsTrend(currentHealthData, daysAhead);
        predictions.add(stepsPredict);
      }

      if (currentHealthData.containsKey('weight')) {
        final weightPredict = _predictWeightTrend(currentHealthData, daysAhead);
        predictions.add(weightPredict);
      }

      return predictions;
    } catch (e) {
      throw Exception('Failed to predict health trends: $e');
    }
  }

  /// Predict wealth trends
  Future<List<AIPrediction>> predictWealthTrends({
    required Map<String, dynamic> currentWealthData,
    required String userId,
    int daysAhead = 30,
  }) async {
    try {
      final storage = _ref.read(enhancedStorageServiceProvider);
      final modelData = await storage.getMap('${_modelDataKey}_wealth_$userId');
      
      if (modelData == null) {
        return _generateDefaultWealthPredictions(currentWealthData, daysAhead);
      }

      final model = modelData['model'] as Map<String, dynamic>;
      final predictions = <AIPrediction>[];

      // Predict wealth score trends
      final currentScore = _calculateWealthScore(currentWealthData);
      final futureScore = _predictWithLinearModel(model, currentScore, daysAhead);
      
      predictions.add(AIPrediction(
        id: 'wealth_trend_${DateTime.now().millisecondsSinceEpoch}',
        type: 'wealth_trend',
        description: 'Predicted wealth score trend over next $daysAhead days',
        probability: _calculatePredictionProbability(model),
        predictedDate: DateTime.now().add(Duration(days: daysAhead)),
        factors: {
          'current_score': currentScore,
          'predicted_score': futureScore,
          'trend': futureScore > currentScore ? 'growing' : 'declining',
        },
        confidence: _getConfidenceFromAccuracy(model['accuracy'] ?? 0.7),
        createdAt: DateTime.now(),
      ));

      // Predict savings growth
      if (currentWealthData.containsKey('savings')) {
        final savingsPredict = _predictSavingsGrowth(currentWealthData, daysAhead);
        predictions.add(savingsPredict);
      }

      // Predict investment returns
      if (currentWealthData.containsKey('investments')) {
        final investmentPredict = _predictInvestmentReturns(currentWealthData, daysAhead);
        predictions.add(investmentPredict);
      }

      return predictions;
    } catch (e) {
      throw Exception('Failed to predict wealth trends: $e');
    }
  }

  /// Analyze user behavior patterns using clustering
  Future<UserBehaviorAnalytics> analyzeUserBehaviorPatterns({
    required String userId,
    required List<Map<String, dynamic>> activityData,
  }) async {
    try {
      // Simple clustering analysis
      final patterns = _performSimpleClustering(activityData);
      final engagementScores = _calculateEngagementScores(activityData);
      final actionCounts = _countActions(activityData);
      final preferredCategories = _identifyPreferredCategories(activityData);
      
      return UserBehaviorAnalytics(
        userId: userId,
        actionCounts: actionCounts,
        engagementScores: engagementScores,
        preferredCategories: preferredCategories,
        lastActivityTimes: _getLastActivityTimes(activityData),
        overallEngagementScore: _calculateOverallEngagement(engagementScores),
        lastUpdated: DateTime.now(),
        patterns: patterns,
        interests: _extractInterests(activityData),
      );
    } catch (e) {
      throw Exception('Failed to analyze user behavior patterns: $e');
    }
  }

  /// Risk assessment using ML
  Future<List<AIPrediction>> assessRisks({
    required Map<String, dynamic> userData,
    required String userId,
  }) async {
    try {
      final risks = <AIPrediction>[];
      
      // Health risks
      final healthRisks = _assessHealthRisks(userData);
      risks.addAll(healthRisks);
      
      // Financial risks
      final financialRisks = _assessFinancialRisks(userData);
      risks.addAll(financialRisks);
      
      // Behavioral risks
      final behavioralRisks = _assessBehavioralRisks(userData);
      risks.addAll(behavioralRisks);
      
      return risks;
    } catch (e) {
      throw Exception('Failed to assess risks: $e');
    }
  }

  // Private helper methods

  Map<String, dynamic> _trainLinearRegressionModel(
    List<Map<String, dynamic>> data,
    String targetField,
  ) {
    if (data.isEmpty) {
      return {'slope': 0.0, 'intercept': 0.0, 'accuracy': 0.5};
    }

    // Simple linear regression implementation
    final n = data.length;
    double sumX = 0, sumY = 0, sumXY = 0, sumXX = 0;
    
    for (int i = 0; i < n; i++) {
      final x = i.toDouble(); // Time index
      final y = (data[i][targetField] as num?)?.toDouble() ?? 0.0;
      
      sumX += x;
      sumY += y;
      sumXY += x * y;
      sumXX += x * x;
    }
    
    final slope = (n * sumXY - sumX * sumY) / (n * sumXX - sumX * sumX);
    final intercept = (sumY - slope * sumX) / n;
    
    // Calculate R-squared for accuracy
    double ssRes = 0, ssTot = 0;
    final meanY = sumY / n;
    
    for (int i = 0; i < n; i++) {
      final x = i.toDouble();
      final y = (data[i][targetField] as num?)?.toDouble() ?? 0.0;
      final predicted = slope * x + intercept;
      
      ssRes += pow(y - predicted, 2);
      ssTot += pow(y - meanY, 2);
    }
    
    final rSquared = ssTot == 0 ? 0.0 : 1 - (ssRes / ssTot);
    
    return {
      'slope': slope,
      'intercept': intercept,
      'accuracy': rSquared.clamp(0.0, 1.0),
      'n': n,
    };
  }

  Map<String, double> _calculateModelMetrics(
    Map<String, dynamic> model,
    List<Map<String, dynamic>> testData,
    String targetField,
  ) {
    final accuracy = (model['accuracy'] as num?)?.toDouble() ?? 0.7;
    
    return {
      'accuracy': accuracy,
      'precision': accuracy * 0.95, // Simplified
      'recall': accuracy * 0.9,     // Simplified
      'f1Score': accuracy * 0.92,   // Simplified
    };
  }

  double _calculateHealthScore(Map<String, dynamic> healthData) {
    double score = 0.0;
    int factors = 0;
    
    // Steps contribution (0-30 points)
    if (healthData.containsKey('steps')) {
      final steps = (healthData['steps'] as num?)?.toDouble() ?? 0;
      score += (steps / 10000 * 30).clamp(0, 30);
      factors++;
    }
    
    // Sleep contribution (0-25 points)
    if (healthData.containsKey('sleep_hours')) {
      final sleep = (healthData['sleep_hours'] as num?)?.toDouble() ?? 0;
      score += ((sleep - 4) / 4 * 25).clamp(0, 25);
      factors++;
    }
    
    // Exercise contribution (0-25 points)
    if (healthData.containsKey('exercise_minutes')) {
      final exercise = (healthData['exercise_minutes'] as num?)?.toDouble() ?? 0;
      score += (exercise / 60 * 25).clamp(0, 25);
      factors++;
    }
    
    // Heart rate contribution (0-20 points)
    if (healthData.containsKey('resting_heart_rate')) {
      final hr = (healthData['resting_heart_rate'] as num?)?.toDouble() ?? 70;
      final normalizedHR = (100 - (hr - 60).abs()) / 100 * 20;
      score += normalizedHR.clamp(0, 20);
      factors++;
    }
    
    return factors > 0 ? score / factors * 100 / 100 : 0.5; // Normalize to 0-1
  }

  double _calculateWealthScore(Map<String, dynamic> wealthData) {
    double score = 0.0;
    int factors = 0;
    
    // Savings rate contribution (0-30 points)
    if (wealthData.containsKey('savings_rate')) {
      final savingsRate = (wealthData['savings_rate'] as num?)?.toDouble() ?? 0;
      score += (savingsRate * 30).clamp(0, 30);
      factors++;
    }
    
    // Investment diversity contribution (0-25 points)
    if (wealthData.containsKey('investment_diversity')) {
      final diversity = (wealthData['investment_diversity'] as num?)?.toDouble() ?? 0;
      score += (diversity * 25).clamp(0, 25);
      factors++;
    }
    
    // Debt-to-income ratio contribution (0-25 points)
    if (wealthData.containsKey('debt_to_income')) {
      final debtRatio = (wealthData['debt_to_income'] as num?)?.toDouble() ?? 0;
      score += ((1 - debtRatio) * 25).clamp(0, 25);
      factors++;
    }
    
    // Emergency fund contribution (0-20 points)
    if (wealth