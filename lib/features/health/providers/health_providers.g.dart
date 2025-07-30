// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$healthDataByTypeHash() => r'b38bd3cf0dfac593cdaaed4485949e2bb023bd6d';

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

/// See also [healthDataByType].
@ProviderFor(healthDataByType)
const healthDataByTypeProvider = HealthDataByTypeFamily();

/// See also [healthDataByType].
class HealthDataByTypeFamily extends Family<AsyncValue<List<HealthData>>> {
  /// See also [healthDataByType].
  const HealthDataByTypeFamily();

  /// See also [healthDataByType].
  HealthDataByTypeProvider call(
    HealthMetricType type,
  ) {
    return HealthDataByTypeProvider(
      type,
    );
  }

  @override
  HealthDataByTypeProvider getProviderOverride(
    covariant HealthDataByTypeProvider provider,
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
  String? get name => r'healthDataByTypeProvider';
}

/// See also [healthDataByType].
class HealthDataByTypeProvider
    extends AutoDisposeFutureProvider<List<HealthData>> {
  /// See also [healthDataByType].
  HealthDataByTypeProvider(
    HealthMetricType type,
  ) : this._internal(
          (ref) => healthDataByType(
            ref as HealthDataByTypeRef,
            type,
          ),
          from: healthDataByTypeProvider,
          name: r'healthDataByTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$healthDataByTypeHash,
          dependencies: HealthDataByTypeFamily._dependencies,
          allTransitiveDependencies:
              HealthDataByTypeFamily._allTransitiveDependencies,
          type: type,
        );

  HealthDataByTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final HealthMetricType type;

  @override
  Override overrideWith(
    FutureOr<List<HealthData>> Function(HealthDataByTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HealthDataByTypeProvider._internal(
        (ref) => create(ref as HealthDataByTypeRef),
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
  AutoDisposeFutureProviderElement<List<HealthData>> createElement() {
    return _HealthDataByTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HealthDataByTypeProvider && other.type == type;
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
mixin HealthDataByTypeRef on AutoDisposeFutureProviderRef<List<HealthData>> {
  /// The parameter `type` of this provider.
  HealthMetricType get type;
}

class _HealthDataByTypeProviderElement
    extends AutoDisposeFutureProviderElement<List<HealthData>>
    with HealthDataByTypeRef {
  _HealthDataByTypeProviderElement(super.provider);

  @override
  HealthMetricType get type => (origin as HealthDataByTypeProvider).type;
}

String _$healthDataByDateRangeHash() =>
    r'490e869afb920e3728d092ae2209beb954acb9af';

/// See also [healthDataByDateRange].
@ProviderFor(healthDataByDateRange)
const healthDataByDateRangeProvider = HealthDataByDateRangeFamily();

/// See also [healthDataByDateRange].
class HealthDataByDateRangeFamily extends Family<AsyncValue<List<HealthData>>> {
  /// See also [healthDataByDateRange].
  const HealthDataByDateRangeFamily();

  /// See also [healthDataByDateRange].
  HealthDataByDateRangeProvider call(
    DateTime startDate,
    DateTime endDate,
  ) {
    return HealthDataByDateRangeProvider(
      startDate,
      endDate,
    );
  }

  @override
  HealthDataByDateRangeProvider getProviderOverride(
    covariant HealthDataByDateRangeProvider provider,
  ) {
    return call(
      provider.startDate,
      provider.endDate,
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
  String? get name => r'healthDataByDateRangeProvider';
}

/// See also [healthDataByDateRange].
class HealthDataByDateRangeProvider
    extends AutoDisposeFutureProvider<List<HealthData>> {
  /// See also [healthDataByDateRange].
  HealthDataByDateRangeProvider(
    DateTime startDate,
    DateTime endDate,
  ) : this._internal(
          (ref) => healthDataByDateRange(
            ref as HealthDataByDateRangeRef,
            startDate,
            endDate,
          ),
          from: healthDataByDateRangeProvider,
          name: r'healthDataByDateRangeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$healthDataByDateRangeHash,
          dependencies: HealthDataByDateRangeFamily._dependencies,
          allTransitiveDependencies:
              HealthDataByDateRangeFamily._allTransitiveDependencies,
          startDate: startDate,
          endDate: endDate,
        );

  HealthDataByDateRangeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.startDate,
    required this.endDate,
  }) : super.internal();

  final DateTime startDate;
  final DateTime endDate;

  @override
  Override overrideWith(
    FutureOr<List<HealthData>> Function(HealthDataByDateRangeRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HealthDataByDateRangeProvider._internal(
        (ref) => create(ref as HealthDataByDateRangeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<HealthData>> createElement() {
    return _HealthDataByDateRangeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HealthDataByDateRangeProvider &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, startDate.hashCode);
    hash = _SystemHash.combine(hash, endDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HealthDataByDateRangeRef
    on AutoDisposeFutureProviderRef<List<HealthData>> {
  /// The parameter `startDate` of this provider.
  DateTime get startDate;

  /// The parameter `endDate` of this provider.
  DateTime get endDate;
}

class _HealthDataByDateRangeProviderElement
    extends AutoDisposeFutureProviderElement<List<HealthData>>
    with HealthDataByDateRangeRef {
  _HealthDataByDateRangeProviderElement(super.provider);

  @override
  DateTime get startDate => (origin as HealthDataByDateRangeProvider).startDate;
  @override
  DateTime get endDate => (origin as HealthDataByDateRangeProvider).endDate;
}

String _$recentHealthDataHash() => r'db93e63fa351077e80a7319fd96128baa4110445';

/// See also [recentHealthData].
@ProviderFor(recentHealthData)
const recentHealthDataProvider = RecentHealthDataFamily();

/// See also [recentHealthData].
class RecentHealthDataFamily extends Family<AsyncValue<List<HealthData>>> {
  /// See also [recentHealthData].
  const RecentHealthDataFamily();

  /// See also [recentHealthData].
  RecentHealthDataProvider call({
    int days = 7,
  }) {
    return RecentHealthDataProvider(
      days: days,
    );
  }

  @override
  RecentHealthDataProvider getProviderOverride(
    covariant RecentHealthDataProvider provider,
  ) {
    return call(
      days: provider.days,
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
  String? get name => r'recentHealthDataProvider';
}

/// See also [recentHealthData].
class RecentHealthDataProvider
    extends AutoDisposeFutureProvider<List<HealthData>> {
  /// See also [recentHealthData].
  RecentHealthDataProvider({
    int days = 7,
  }) : this._internal(
          (ref) => recentHealthData(
            ref as RecentHealthDataRef,
            days: days,
          ),
          from: recentHealthDataProvider,
          name: r'recentHealthDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recentHealthDataHash,
          dependencies: RecentHealthDataFamily._dependencies,
          allTransitiveDependencies:
              RecentHealthDataFamily._allTransitiveDependencies,
          days: days,
        );

  RecentHealthDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    FutureOr<List<HealthData>> Function(RecentHealthDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecentHealthDataProvider._internal(
        (ref) => create(ref as RecentHealthDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<HealthData>> createElement() {
    return _RecentHealthDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecentHealthDataProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecentHealthDataRef on AutoDisposeFutureProviderRef<List<HealthData>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _RecentHealthDataProviderElement
    extends AutoDisposeFutureProviderElement<List<HealthData>>
    with RecentHealthDataRef {
  _RecentHealthDataProviderElement(super.provider);

  @override
  int get days => (origin as RecentHealthDataProvider).days;
}

String _$healthMetricAveragesHash() =>
    r'1594c598e7bb32ae848d0b73bfdc5cdda550861e';

/// See also [healthMetricAverages].
@ProviderFor(healthMetricAverages)
const healthMetricAveragesProvider = HealthMetricAveragesFamily();

/// See also [healthMetricAverages].
class HealthMetricAveragesFamily
    extends Family<AsyncValue<Map<HealthMetricType, double>>> {
  /// See also [healthMetricAverages].
  const HealthMetricAveragesFamily();

  /// See also [healthMetricAverages].
  HealthMetricAveragesProvider call({
    int days = 30,
  }) {
    return HealthMetricAveragesProvider(
      days: days,
    );
  }

  @override
  HealthMetricAveragesProvider getProviderOverride(
    covariant HealthMetricAveragesProvider provider,
  ) {
    return call(
      days: provider.days,
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
  String? get name => r'healthMetricAveragesProvider';
}

/// See also [healthMetricAverages].
class HealthMetricAveragesProvider
    extends AutoDisposeFutureProvider<Map<HealthMetricType, double>> {
  /// See also [healthMetricAverages].
  HealthMetricAveragesProvider({
    int days = 30,
  }) : this._internal(
          (ref) => healthMetricAverages(
            ref as HealthMetricAveragesRef,
            days: days,
          ),
          from: healthMetricAveragesProvider,
          name: r'healthMetricAveragesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$healthMetricAveragesHash,
          dependencies: HealthMetricAveragesFamily._dependencies,
          allTransitiveDependencies:
              HealthMetricAveragesFamily._allTransitiveDependencies,
          days: days,
        );

  HealthMetricAveragesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    FutureOr<Map<HealthMetricType, double>> Function(
            HealthMetricAveragesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HealthMetricAveragesProvider._internal(
        (ref) => create(ref as HealthMetricAveragesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<HealthMetricType, double>>
      createElement() {
    return _HealthMetricAveragesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HealthMetricAveragesProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HealthMetricAveragesRef
    on AutoDisposeFutureProviderRef<Map<HealthMetricType, double>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _HealthMetricAveragesProviderElement
    extends AutoDisposeFutureProviderElement<Map<HealthMetricType, double>>
    with HealthMetricAveragesRef {
  _HealthMetricAveragesProviderElement(super.provider);

  @override
  int get days => (origin as HealthMetricAveragesProvider).days;
}

String _$healthTrendsHash() => r'58db989407b53aa47b2221e3178e98592fb1a26c';

/// See also [healthTrends].
@ProviderFor(healthTrends)
const healthTrendsProvider = HealthTrendsFamily();

/// See also [healthTrends].
class HealthTrendsFamily
    extends Family<AsyncValue<Map<HealthMetricType, HealthTrend>>> {
  /// See also [healthTrends].
  const HealthTrendsFamily();

  /// See also [healthTrends].
  HealthTrendsProvider call({
    int days = 30,
  }) {
    return HealthTrendsProvider(
      days: days,
    );
  }

  @override
  HealthTrendsProvider getProviderOverride(
    covariant HealthTrendsProvider provider,
  ) {
    return call(
      days: provider.days,
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
  String? get name => r'healthTrendsProvider';
}

/// See also [healthTrends].
class HealthTrendsProvider
    extends AutoDisposeFutureProvider<Map<HealthMetricType, HealthTrend>> {
  /// See also [healthTrends].
  HealthTrendsProvider({
    int days = 30,
  }) : this._internal(
          (ref) => healthTrends(
            ref as HealthTrendsRef,
            days: days,
          ),
          from: healthTrendsProvider,
          name: r'healthTrendsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$healthTrendsHash,
          dependencies: HealthTrendsFamily._dependencies,
          allTransitiveDependencies:
              HealthTrendsFamily._allTransitiveDependencies,
          days: days,
        );

  HealthTrendsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    FutureOr<Map<HealthMetricType, HealthTrend>> Function(
            HealthTrendsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HealthTrendsProvider._internal(
        (ref) => create(ref as HealthTrendsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<HealthMetricType, HealthTrend>>
      createElement() {
    return _HealthTrendsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HealthTrendsProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HealthTrendsRef
    on AutoDisposeFutureProviderRef<Map<HealthMetricType, HealthTrend>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _HealthTrendsProviderElement
    extends AutoDisposeFutureProviderElement<Map<HealthMetricType, HealthTrend>>
    with HealthTrendsRef {
  _HealthTrendsProviderElement(super.provider);

  @override
  int get days => (origin as HealthTrendsProvider).days;
}

String _$healthInsightsHash() => r'fdf1ad126a92cb5eafbfa7c7ee7a396b3c4e6ecb';

/// See also [healthInsights].
@ProviderFor(healthInsights)
final healthInsightsProvider =
    AutoDisposeFutureProvider<HealthInsights?>.internal(
  healthInsights,
  name: r'healthInsightsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthInsightsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HealthInsightsRef = AutoDisposeFutureProviderRef<HealthInsights?>;
String _$healthDataSyncStatusHash() =>
    r'216c7dcb611732744f29ecf7743c851da0e1ee3e';

/// See also [healthDataSyncStatus].
@ProviderFor(healthDataSyncStatus)
final healthDataSyncStatusProvider = AutoDisposeFutureProvider<bool>.internal(
  healthDataSyncStatus,
  name: r'healthDataSyncStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthDataSyncStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HealthDataSyncStatusRef = AutoDisposeFutureProviderRef<bool>;
String _$healthDataNotifierHash() =>
    r'38d86df3feb955aaa35c378fd4d54a93b6c06699';

/// See also [HealthDataNotifier].
@ProviderFor(HealthDataNotifier)
final healthDataNotifierProvider = AutoDisposeAsyncNotifierProvider<
    HealthDataNotifier, List<HealthData>>.internal(
  HealthDataNotifier.new,
  name: r'healthDataNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthDataNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HealthDataNotifier = AutoDisposeAsyncNotifier<List<HealthData>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
