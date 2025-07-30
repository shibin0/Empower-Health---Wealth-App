import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/ai_models.dart';
import '../services/openai_service.dart';
import '../../storage/enhanced_storage_service.dart';
import '../../providers/app_providers.dart';
import '../../models/user_profile.dart';
import '../../features/health/providers/health_providers.dart';
import '../../features/wealth/providers/wealth_providers.dart';

part 'ai_providers.g.dart';

/// AI Configuration Provider
@riverpod
class AIConfigurationNotifier extends _$AIConfigurationNotifier {
  @override
  Future<AIConfiguration> build() async {
    return _loadConfiguration();
  }

  Future<AIConfiguration> _loadConfiguration() async {
    try {
      final storage = ref.read(enhancedStorageServiceProvider);
      final userProfile = await ref.read(userProfileProvider.future);
      
      final configJson = await storage.getString('ai_configuration_${userProfile.id}');
      
      if (configJson != null) {
        final Map<String, dynamic> configMap = 
            Map<String, dynamic>.from(await storage.getMap('ai_configuration_${userProfile.id}') ?? {});
        return AIConfiguration.fromJson(configMap);
      }
      
      // Default configuration
      return AIConfiguration(
        userId: userProfile.id,
        enablePersonalization: true,
        enablePredictions: true,
        enableRecommendations: true,
        confidenceThreshold: 0.7,
        enabledCategories: ['health', 'wealth', 'lifestyle', 'goal'],
        preferences: {},
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to load AI configuration: $e');
    }
  }

  Future<void> updateConfiguration(AIConfiguration config) async {
    try {
      final storage = ref.read(enhancedStorageServiceProvider);
      await storage.setMap('ai_configuration_${config.userId}', config.toJson());
      state = AsyncValue.data(config);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updatePreference(String key, dynamic value) async {
    final currentConfig = await future;
    final updatedPreferences = Map<String, dynamic>.from(currentConfig.preferences);
    updatedPreferences[key] = value;
    
    final updatedConfig = currentConfig.copyWith(
      preferences: updatedPreferences,
      lastUpdated: DateTime.now(),
    );
    
    await updateConfiguration(updatedConfig);
  }
}

/// AI Recommendations Provider
@riverpod
class AIRecommendationsNotifier extends _$AIRecommendationsNotifier {
  @override
  Future<List<AIRecommendation>> build() async {
    return _generateRecommendations();
  }

  Future<List<AIRecommendation>> _generateRecommendations() async {
    try {
      final openAIService = ref.read(openAIServiceProvider);
      final userProfile = await ref.read(userProfileProvider.future);
      final healthData = await ref.read(healthDataProvider.future);
      final wealthData = await ref.read(wealthDataProvider.future);
      final config = await ref.read(aIConfigurationNotifierProvider.future);

      final recommendations = <AIRecommendation>[];

      // Generate health recommendations if enabled
      if (config.enabledCategories.contains('health')) {
        final healthRecommendations = await openAIService.generateHealthRecommendations(
          healthData: healthData.toJson(),
          userProfile: userProfile.toJson(),
          maxRecommendations: 3,
        );
        recommendations.addAll(healthRecommendations);
      }

      // Generate wealth recommendations if enabled
      if (config.enabledCategories.contains('wealth')) {
        final wealthRecommendations = await openAIService.generateWealthRecommendations(
          financialData: wealthData.toJson(),
          userProfile: userProfile.toJson(),
          maxRecommendations: 3,
        );
        recommendations.addAll(wealthRecommendations);
      }

      // Filter by confidence threshold
      final filteredRecommendations = recommendations
          .where((rec) => _getConfidenceScore(rec.confidence) >= config.confidenceThreshold)
          .toList();

      // Sort by score (highest first)
      filteredRecommendations.sort((a, b) => b.score.compareTo(a.score));

      return filteredRecommendations.take(10).toList();
    } catch (e) {
      throw Exception('Failed to generate recommendations: $e');
    }
  }

  double _getConfidenceScore(ConfidenceLevel confidence) {
    switch (confidence) {
      case ConfidenceLevel.low:
        return 0.3;
      case ConfidenceLevel.medium:
        return 0.6;
      case ConfidenceLevel.high:
        return 0.8;
      case ConfidenceLevel.veryHigh:
        return 0.95;
    }
  }

  Future<void> refreshRecommendations() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _generateRecommendations());
  }

  Future<void> dismissRecommendation(String recommendationId) async {
    final currentRecommendations = await future;
    final updatedRecommendations = currentRecommendations
        .where((rec) => rec.id != recommendationId)
        .toList();
    state = AsyncValue.data(updatedRecommendations);
  }
}

/// AI Insights Provider
@riverpod
class AIInsightsNotifier extends _$AIInsightsNotifier {
  @override
  Future<List<AIInsight>> build() async {
    return _generateInsights();
  }

  Future<List<AIInsight>> _generateInsights() async {
    try {
      final openAIService = ref.read(openAIServiceProvider);
      final userProfile = await ref.read(userProfileProvider.future);
      final healthData = await ref.read(healthDataProvider.future);
      final wealthData = await ref.read(wealthDataProvider.future);
      final config = await ref.read(aIConfigurationNotifierProvider.future);

      // Combine user data
      final userData = {
        'profile': userProfile.toJson(),
        'health': healthData.toJson(),
        'wealth': wealthData.toJson(),
        'timestamp': DateTime.now().toIso8601String(),
      };

      final insights = await openAIService.generateInsights(
        userData: userData,
        categories: config.enabledCategories,
      );

      // Filter by relevance threshold
      final filteredInsights = insights
          .where((insight) => insight.relevanceScore >= config.relevanceThreshold)
          .toList();

      // Sort by relevance score (highest first)
      filteredInsights.sort((a, b) => b.relevanceScore.compareTo(a.relevanceScore));

      return filteredInsights.take(5).toList();
    } catch (e) {
      throw Exception('Failed to generate insights: $e');
    }
  }

  Future<void> refreshInsights() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _generateInsights());
  }
}

/// AI Predictions Provider
@riverpod
class AIPredictionsNotifier extends _$AIPredictionsNotifier {
  @override
  Future<List<AIPrediction>> build() async {
    return _generatePredictions();
  }

  Future<List<AIPrediction>> _generatePredictions() async {
    try {
      final openAIService = ref.read(openAIServiceProvider);
      final userProfile = await ref.read(userProfileProvider.future);
      final healthData = await ref.read(healthDataProvider.future);
      final wealthData = await ref.read(wealthDataProvider.future);
      final config = await ref.read(aIConfigurationNotifierProvider.future);

      if (!config.enablePredictions) {
        return [];
      }

      // Combine user data
      final userData = {
        'profile': userProfile.toJson(),
        'health': healthData.toJson(),
        'wealth': wealthData.toJson(),
        'timestamp': DateTime.now().toIso8601String(),
      };

      final predictionTypes = [
        'health_trends',
        'financial_goals',
        'risk_assessment',
        'achievement_likelihood',
      ];

      final predictions = await openAIService.generatePredictions(
        userData: userData,
        predictionTypes: predictionTypes,
      );

      // Filter by confidence threshold
      final filteredPredictions = predictions
          .where((pred) => _getConfidenceScore(pred.confidence) >= config.confidenceThreshold)
          .toList();

      // Sort by probability (highest first)
      filteredPredictions.sort((a, b) => b.probability.compareTo(a.probability));

      return filteredPredictions.take(5).toList();
    } catch (e) {
      throw Exception('Failed to generate predictions: $e');
    }
  }

  double _getConfidenceScore(ConfidenceLevel confidence) {
    switch (confidence) {
      case ConfidenceLevel.low:
        return 0.3;
      case ConfidenceLevel.medium:
        return 0.6;
      case ConfidenceLevel.high:
        return 0.8;
      case ConfidenceLevel.veryHigh:
        return 0.95;
    }
  }

  Future<void> refreshPredictions() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _generatePredictions());
  }
}

/// User Behavior Analytics Provider
@riverpod
class UserBehaviorAnalyticsNotifier extends _$UserBehaviorAnalyticsNotifier {
  @override
  Future<UserBehaviorAnalytics> build() async {
    return _analyzeUserBehavior();
  }

  Future<UserBehaviorAnalytics> _analyzeUserBehavior() async {
    try {
      final openAIService = ref.read(openAIServiceProvider);
      final userProfile = await ref.read(userProfileProvider.future);
      final storage = ref.read(enhancedStorageServiceProvider);

      // Load activity data from storage
      final activityData = await storage.getMap('user_activity_${userProfile.id}') ?? {};

      final analytics = await openAIService.analyzeUserBehavior(
        userId: userProfile.id,
        activityData: activityData,
      );

      // Store updated analytics
      await storage.setMap('user_behavior_analytics_${userProfile.id}', analytics.toJson());

      return analytics;
    } catch (e) {
      throw Exception('Failed to analyze user behavior: $e');
    }
  }

  Future<void> trackUserAction(String action, Map<String, dynamic> context) async {
    try {
      final userProfile = await ref.read(userProfileProvider.future);
      final storage = ref.read(enhancedStorageServiceProvider);

      // Load existing activity data
      final activityData = Map<String, dynamic>.from(
        await storage.getMap('user_activity_${userProfile.id}') ?? {},
      );

      // Update activity data
      final timestamp = DateTime.now().toIso8601String();
      activityData[timestamp] = {
        'action': action,
        'context': context,
      };

      // Keep only last 1000 actions
      if (activityData.length > 1000) {
        final sortedKeys = activityData.keys.toList()..sort();
        final keysToRemove = sortedKeys.take(activityData.length - 1000);
        for (final key in keysToRemove) {
          activityData.remove(key);
        }
      }

      // Save updated activity data
      await storage.setMap('user_activity_${userProfile.id}', activityData);

      // Refresh analytics
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() => _analyzeUserBehavior());
    } catch (e) {
      print('Error tracking user action: $e');
    }
  }

  Future<void> refreshAnalytics() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _analyzeUserBehavior());
  }
}

/// AI Chat Provider
@riverpod
class AIChatNotifier extends _$AIChatNotifier {
  @override
  Future<List<AIChatMessage>> build() async {
    return _loadChatHistory();
  }

  Future<List<AIChatMessage>> _loadChatHistory() async {
    try {
      final openAIService = ref.read(openAIServiceProvider);
      final userProfile = await ref.read(userProfileProvider.future);
      
      // This would load from the OpenAI service's conversation history
      return []; // Placeholder - actual implementation would load from storage
    } catch (e) {
      throw Exception('Failed to load chat history: $e');
    }
  }

  Future<AIChatMessage> sendMessage(String message) async {
    try {
      final openAIService = ref.read(openAIServiceProvider);
      final userProfile = await ref.read(userProfileProvider.future);
      final currentMessages = await future;

      // Add user message to state
      final userMessage = AIChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: message,
        isUser: true,
        timestamp: DateTime.now(),
      );

      state = AsyncValue.data([...currentMessages, userMessage]);

      // Get AI response
      final aiResponse = await openAIService.chatWithAssistant(
        userMessage: message,
        userId: userProfile.id,
        conversationHistory: currentMessages,
      );

      // Add AI response to state
      final updatedMessages = [...currentMessages, userMessage, aiResponse];
      state = AsyncValue.data(updatedMessages);

      // Track user interaction
      ref.read(userBehaviorAnalyticsNotifierProvider.notifier)
          .trackUserAction('ai_chat', {'message_length': message.length});

      return aiResponse;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  Future<void> clearChat() async {
    try {
      final openAIService = ref.read(openAIServiceProvider);
      final userProfile = await ref.read(userProfileProvider.future);
      
      await openAIService.clearConversationHistory(userProfile.id);
      state = const AsyncValue.data([]);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

/// Combined AI Dashboard Provider
@riverpod
Future<Map<String, dynamic>> aiDashboardData(AiDashboardDataRef ref) async {
  final recommendations = await ref.watch(aIRecommendationsNotifierProvider.future);
  final insights = await ref.watch(aIInsightsNotifierProvider.future);
  final predictions = await ref.watch(aIPredictionsNotifierProvider.future);
  final analytics = await ref.watch(userBehaviorAnalyticsNotifierProvider.future);

  return {
    'recommendations': recommendations,
    'insights': insights,
    'predictions': predictions,
    'analytics': analytics,
    'lastUpdated': DateTime.now().toIso8601String(),
  };
}