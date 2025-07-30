// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiDashboardDataHash() => r'af0383fca4011d914cf7df70ff73ebb25b5a7ec3';

/// Combined AI Dashboard Provider
///
/// Copied from [aiDashboardData].
@ProviderFor(aiDashboardData)
final aiDashboardDataProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
  aiDashboardData,
  name: r'aiDashboardDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aiDashboardDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AiDashboardDataRef = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$aIConfigurationNotifierHash() =>
    r'b294dae637d0abc1edfca5f1eebdae85a95474dc';

/// AI Configuration Provider
///
/// Copied from [AIConfigurationNotifier].
@ProviderFor(AIConfigurationNotifier)
final aIConfigurationNotifierProvider = AutoDisposeAsyncNotifierProvider<
    AIConfigurationNotifier, AIConfiguration>.internal(
  AIConfigurationNotifier.new,
  name: r'aIConfigurationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aIConfigurationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AIConfigurationNotifier = AutoDisposeAsyncNotifier<AIConfiguration>;
String _$aIRecommendationsNotifierHash() =>
    r'df33c4fd778442cb90ecf7a83ed9a7528e44fe28';

/// AI Recommendations Provider
///
/// Copied from [AIRecommendationsNotifier].
@ProviderFor(AIRecommendationsNotifier)
final aIRecommendationsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    AIRecommendationsNotifier, List<AIRecommendation>>.internal(
  AIRecommendationsNotifier.new,
  name: r'aIRecommendationsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aIRecommendationsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AIRecommendationsNotifier
    = AutoDisposeAsyncNotifier<List<AIRecommendation>>;
String _$aIInsightsNotifierHash() =>
    r'3faddebc0601b5f85688510183e2bc331cbe933a';

/// AI Insights Provider
///
/// Copied from [AIInsightsNotifier].
@ProviderFor(AIInsightsNotifier)
final aIInsightsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    AIInsightsNotifier, List<AIInsight>>.internal(
  AIInsightsNotifier.new,
  name: r'aIInsightsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aIInsightsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AIInsightsNotifier = AutoDisposeAsyncNotifier<List<AIInsight>>;
String _$aIPredictionsNotifierHash() =>
    r'cfe1ea9b1f6d28b019a3ccf45f0d271940823c27';

/// AI Predictions Provider
///
/// Copied from [AIPredictionsNotifier].
@ProviderFor(AIPredictionsNotifier)
final aIPredictionsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    AIPredictionsNotifier, List<AIPrediction>>.internal(
  AIPredictionsNotifier.new,
  name: r'aIPredictionsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aIPredictionsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AIPredictionsNotifier = AutoDisposeAsyncNotifier<List<AIPrediction>>;
String _$userBehaviorAnalyticsNotifierHash() =>
    r'b3f42d54542854017ea6102338b7ee57817cbc5c';

/// User Behavior Analytics Provider
///
/// Copied from [UserBehaviorAnalyticsNotifier].
@ProviderFor(UserBehaviorAnalyticsNotifier)
final userBehaviorAnalyticsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    UserBehaviorAnalyticsNotifier, UserBehaviorAnalytics>.internal(
  UserBehaviorAnalyticsNotifier.new,
  name: r'userBehaviorAnalyticsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userBehaviorAnalyticsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserBehaviorAnalyticsNotifier
    = AutoDisposeAsyncNotifier<UserBehaviorAnalytics>;
String _$aIChatNotifierHash() => r'0d5b47d639a5db92b0ab6e39e11326886cb8fa31';

/// AI Chat Provider
///
/// Copied from [AIChatNotifier].
@ProviderFor(AIChatNotifier)
final aIChatNotifierProvider = AutoDisposeAsyncNotifierProvider<AIChatNotifier,
    List<AIChatMessage>>.internal(
  AIChatNotifier.new,
  name: r'aIChatNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aIChatNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AIChatNotifier = AutoDisposeAsyncNotifier<List<AIChatMessage>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
