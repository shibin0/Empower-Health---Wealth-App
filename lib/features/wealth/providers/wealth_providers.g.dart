// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wealth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$investmentsByTypeHash() => r'c62ef658bd50c8bb214c9268c0c17a08987d4850';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [investmentsByType].
@ProviderFor(investmentsByType)
const investmentsByTypeProvider = InvestmentsByTypeFamily();

/// See also [investmentsByType].
class InvestmentsByTypeFamily extends Family<AsyncValue<List<Investment>>> {
  /// See also [investmentsByType].
  const InvestmentsByTypeFamily();

  /// See also [investmentsByType].
  InvestmentsByTypeProvider call(
    InvestmentType type,
  ) {
    return InvestmentsByTypeProvider(
      type,
    );
  }

  @override
  InvestmentsByTypeProvider getProviderOverride(
    covariant InvestmentsByTypeProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'investmentsByTypeProvider';
}

/// See also [investmentsByType].
class InvestmentsByTypeProvider
    extends AutoDisposeFutureProvider<List<Investment>> {
  /// See also [investmentsByType].
  InvestmentsByTypeProvider(
    InvestmentType type,
  ) : this._internal(
          (ref) => investmentsByType(
            ref as InvestmentsByTypeRef,
            type,
          ),
          from: investmentsByTypeProvider,
          name: r'investmentsByTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$investmentsByTypeHash,
          dependencies: InvestmentsByTypeFamily._dependencies,
          allTransitiveDependencies:
              InvestmentsByTypeFamily._allTransitiveDependencies,
          type: type,
        );

  InvestmentsByTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final InvestmentType type;

  @override
  Override overrideWith(
    FutureOr<List<Investment>> Function(InvestmentsByTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvestmentsByTypeProvider._internal(
        (ref) => create(ref as InvestmentsByTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Investment>> createElement() {
    return _InvestmentsByTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvestmentsByTypeProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InvestmentsByTypeRef on AutoDisposeFutureProviderRef<List<Investment>> {
  /// The parameter `type` of this provider.
  InvestmentType get type;
}

class _InvestmentsByTypeProviderElement
    extends AutoDisposeFutureProviderElement<List<Investment>>
    with InvestmentsByTypeRef {
  _InvestmentsByTypeProviderElement(super.provider);

  @override
  InvestmentType get type => (origin as InvestmentsByTypeProvider).type;
}

String _$portfolioAnalysisHash() => r'55d528dac3bb0d682068f0c7da666b74007488d8';

/// See also [portfolioAnalysis].
@ProviderFor(portfolioAnalysis)
final portfolioAnalysisProvider =
    AutoDisposeFutureProvider<PortfolioAnalysis?>.internal(
  portfolioAnalysis,
  name: r'portfolioAnalysisProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$portfolioAnalysisHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PortfolioAnalysisRef = AutoDisposeFutureProviderRef<PortfolioAnalysis?>;
String _$wealthTrendsHash() => r'3fbdc5b8d672237b6f3b300959077958182c7bb7';

/// See also [wealthTrends].
@ProviderFor(wealthTrends)
final wealthTrendsProvider =
    AutoDisposeFutureProvider<List<WealthTrend>>.internal(
  wealthTrends,
  name: r'wealthTrendsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$wealthTrendsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WealthTrendsRef = AutoDisposeFutureProviderRef<List<WealthTrend>>;
String _$wealthInsightsHash() => r'97b0d9f962b90fa118bd9faca26138b44edaeb1c';

/// See also [wealthInsights].
@ProviderFor(wealthInsights)
final wealthInsightsProvider =
    AutoDisposeFutureProvider<WealthInsights?>.internal(
  wealthInsights,
  name: r'wealthInsightsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wealthInsightsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WealthInsightsRef = AutoDisposeFutureProviderRef<WealthInsights?>;
String _$goalProgressHash() => r'18165d0868167b50bce3f43aa1aa01cec11eb35b';

/// See also [goalProgress].
@ProviderFor(goalProgress)
final goalProgressProvider =
    AutoDisposeFutureProvider<Map<String, double>>.internal(
  goalProgress,
  name: r'goalProgressProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$goalProgressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GoalProgressRef = AutoDisposeFutureProviderRef<Map<String, double>>;
String _$wealthDataSyncStatusHash() =>
    r'126bcd8156067bd9434b6e1fc75b028e271403bb';

/// See also [wealthDataSyncStatus].
@ProviderFor(wealthDataSyncStatus)
final wealthDataSyncStatusProvider = AutoDisposeFutureProvider<bool>.internal(
  wealthDataSyncStatus,
  name: r'wealthDataSyncStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wealthDataSyncStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WealthDataSyncStatusRef = AutoDisposeFutureProviderRef<bool>;
String _$portfolioNotifierHash() => r'9d945773b4916c3971956144146683edcde5cc09';

/// See also [PortfolioNotifier].
@ProviderFor(PortfolioNotifier)
final portfolioNotifierProvider =
    AutoDisposeAsyncNotifierProvider<PortfolioNotifier, Portfolio?>.internal(
  PortfolioNotifier.new,
  name: r'portfolioNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$portfolioNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PortfolioNotifier = AutoDisposeAsyncNotifier<Portfolio?>;
String _$financialGoalsNotifierHash() =>
    r'd297dd271e24ead6c97311f89baa32c97a182001';

/// See also [FinancialGoalsNotifier].
@ProviderFor(FinancialGoalsNotifier)
final financialGoalsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    FinancialGoalsNotifier, List<FinancialGoal>>.internal(
  FinancialGoalsNotifier.new,
  name: r'financialGoalsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$financialGoalsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FinancialGoalsNotifier
    = AutoDisposeAsyncNotifier<List<FinancialGoal>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
