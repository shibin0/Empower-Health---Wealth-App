import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/onboarding_data.dart';
import '../core/storage/enhanced_storage_service.dart';

final onboardingServiceProvider = Provider<OnboardingService>((ref) {
  return OnboardingService(ref);
});

final onboardingDataProvider = StateNotifierProvider<OnboardingDataNotifier, OnboardingData?>((ref) {
  return OnboardingDataNotifier(ref);
});

class OnboardingService {
  final Ref _ref;

  OnboardingService(this._ref);

  Future<void> saveOnboardingData(OnboardingData data) async {
    try {
      final storage = await _ref.read(enhancedStorageServiceProvider.future);
      await storage.cacheData('onboarding_data', data.toJson());
      _ref.read(onboardingDataProvider.notifier).updateData(data);
    } catch (e) {
      throw Exception('Failed to save onboarding data: $e');
    }
  }

  Future<OnboardingData?> getOnboardingData() async {
    try {
      final storage = await _ref.read(enhancedStorageServiceProvider.future);
      final data = storage.getCachedData('onboarding_data');
      if (data != null) {
        return OnboardingData.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isOnboardingCompleted() async {
    try {
      final storage = await _ref.read(enhancedStorageServiceProvider.future);
      final data = storage.getCachedData('onboarding_completed');
      return data?['completed'] ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<void> markOnboardingCompleted() async {
    try {
      final storage = await _ref.read(enhancedStorageServiceProvider.future);
      await storage.cacheData('onboarding_completed', {'completed': true});
    } catch (e) {
      throw Exception('Failed to mark onboarding as completed: $e');
    }
  }

  Future<void> resetOnboarding() async {
    try {
      final storage = await _ref.read(enhancedStorageServiceProvider.future);
      await storage.cacheData('onboarding_data', {});
      await storage.cacheData('onboarding_completed', {'completed': false});
      _ref.read(onboardingDataProvider.notifier).clearData();
    } catch (e) {
      throw Exception('Failed to reset onboarding: $e');
    }
  }

  List<String> getRecommendedModules(OnboardingData data) {
    List<String> recommendations = [];

    // Health recommendations based on goals
    if (data.healthGoal.contains('Weight') || data.interests.contains('Fitness')) {
      recommendations.add('nutrition');
      recommendations.add('exercise');
    }
    if (data.healthGoal.contains('Sleep') || data.interests.contains('Sleep')) {
      recommendations.add('sleep');
    }
    if (data.healthGoal.contains('Mental') || data.interests.contains('Mental Health')) {
      recommendations.add('mental');
    }

    // Wealth recommendations based on goals
    if (data.wealthGoal.contains('Saving') || data.interests.contains('Budgeting')) {
      recommendations.add('budgeting');
    }
    if (data.wealthGoal.contains('Investment') || data.interests.contains('Investing')) {
      recommendations.add('investing');
    }
    if (data.wealthGoal.contains('Credit') || data.interests.contains('Credit')) {
      recommendations.add('credit');
    }
    if (data.wealthGoal.contains('Insurance') || data.interests.contains('Insurance')) {
      recommendations.add('insurance');
    }

    // Default recommendations if none selected
    if (recommendations.isEmpty) {
      recommendations.addAll(['nutrition', 'budgeting']);
    }

    return recommendations;
  }

  Map<String, dynamic> generatePersonalizedContent(OnboardingData data) {
    return {
      'welcomeMessage': 'Welcome ${data.name}! Let\'s start your journey to better health and wealth.',
      'primaryFocus': data.primaryGoals.isNotEmpty ? data.primaryGoals.first : 'Overall Wellness',
      'recommendedModules': getRecommendedModules(data),
      'experienceLevel': data.experienceLevel,
      'customTips': _generateCustomTips(data),
      'goalBasedQuickActions': _generateQuickActions(data),
    };
  }

  List<String> _generateCustomTips(OnboardingData data) {
    List<String> tips = [];

    if (data.experienceLevel == 'Beginner') {
      tips.add('Start with small, achievable goals to build momentum');
      tips.add('Focus on one area at a time to avoid overwhelm');
    } else if (data.experienceLevel == 'Intermediate') {
      tips.add('Track your progress to identify patterns and improvements');
      tips.add('Consider advanced strategies in your areas of interest');
    } else {
      tips.add('Share your knowledge with the community');
      tips.add('Explore advanced modules and cutting-edge strategies');
    }

    if (data.age < 25) {
      tips.add('Building healthy habits early will compound over time');
    } else if (data.age > 40) {
      tips.add('It\'s never too late to start improving your health and wealth');
    }

    return tips;
  }

  List<Map<String, String>> _generateQuickActions(OnboardingData data) {
    List<Map<String, String>> actions = [];

    if (data.primaryGoals.contains('Health')) {
      actions.add({
        'title': 'Start Your Health Journey',
        'description': 'Begin with ${data.healthGoal.toLowerCase()}',
        'action': 'health_module',
      });
    }

    if (data.primaryGoals.contains('Wealth')) {
      actions.add({
        'title': 'Improve Your Finances',
        'description': 'Focus on ${data.wealthGoal.toLowerCase()}',
        'action': 'wealth_module',
      });
    }

    return actions;
  }
}

class OnboardingDataNotifier extends StateNotifier<OnboardingData?> {
  final Ref _ref;

  OnboardingDataNotifier(this._ref) : super(null) {
    _loadOnboardingData();
  }

  Future<void> _loadOnboardingData() async {
    try {
      final service = _ref.read(onboardingServiceProvider);
      final data = await service.getOnboardingData();
      state = data;
    } catch (e) {
      state = null;
    }
  }

  void updateData(OnboardingData data) {
    state = data;
  }

  void clearData() {
    state = null;
  }

  void updateName(String name) {
    if (state != null) {
      state = state!.copyWith(name: name);
    }
  }

  void updateAge(int age) {
    if (state != null) {
      state = state!.copyWith(age: age);
    }
  }

  void updateCity(String city) {
    if (state != null) {
      state = state!.copyWith(city: city);
    }
  }

  void updatePrimaryGoals(List<String> goals) {
    if (state != null) {
      state = state!.copyWith(primaryGoals: goals);
    }
  }

  void updateHealthGoal(String goal) {
    if (state != null) {
      state = state!.copyWith(healthGoal: goal);
    }
  }

  void updateWealthGoal(String goal) {
    if (state != null) {
      state = state!.copyWith(wealthGoal: goal);
    }
  }

  void updateExperienceLevel(String level) {
    if (state != null) {
      state = state!.copyWith(experienceLevel: level);
    }
  }

  void updateInterests(List<String> interests) {
    if (state != null) {
      state = state!.copyWith(interests: interests);
    }
  }

  void updatePreferences(Map<String, bool> preferences) {
    if (state != null) {
      state = state!.copyWith(preferences: preferences);
    }
  }
}