// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HealthData _$HealthDataFromJson(Map<String, dynamic> json) {
  return _HealthData.fromJson(json);
}

/// @nodoc
mixin _$HealthData {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  HealthMetricType get type => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;
  DateTime? get lastSyncedAt => throw _privateConstructorUsedError;
  DataSource get source => throw _privateConstructorUsedError;

  /// Serializes this HealthData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthDataCopyWith<HealthData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthDataCopyWith<$Res> {
  factory $HealthDataCopyWith(
          HealthData value, $Res Function(HealthData) then) =
      _$HealthDataCopyWithImpl<$Res, HealthData>;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime timestamp,
      HealthMetricType type,
      double value,
      String unit,
      Map<String, dynamic> metadata,
      bool isSynced,
      DateTime? lastSyncedAt,
      DataSource source});
}

/// @nodoc
class _$HealthDataCopyWithImpl<$Res, $Val extends HealthData>
    implements $HealthDataCopyWith<$Res> {
  _$HealthDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? type = null,
    Object? value = null,
    Object? unit = null,
    Object? metadata = null,
    Object? isSynced = null,
    Object? lastSyncedAt = freezed,
    Object? source = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HealthMetricType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as DataSource,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthDataImplCopyWith<$Res>
    implements $HealthDataCopyWith<$Res> {
  factory _$$HealthDataImplCopyWith(
          _$HealthDataImpl value, $Res Function(_$HealthDataImpl) then) =
      __$$HealthDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime timestamp,
      HealthMetricType type,
      double value,
      String unit,
      Map<String, dynamic> metadata,
      bool isSynced,
      DateTime? lastSyncedAt,
      DataSource source});
}

/// @nodoc
class __$$HealthDataImplCopyWithImpl<$Res>
    extends _$HealthDataCopyWithImpl<$Res, _$HealthDataImpl>
    implements _$$HealthDataImplCopyWith<$Res> {
  __$$HealthDataImplCopyWithImpl(
      _$HealthDataImpl _value, $Res Function(_$HealthDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? type = null,
    Object? value = null,
    Object? unit = null,
    Object? metadata = null,
    Object? isSynced = null,
    Object? lastSyncedAt = freezed,
    Object? source = null,
  }) {
    return _then(_$HealthDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HealthMetricType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as DataSource,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthDataImpl implements _HealthData {
  const _$HealthDataImpl(
      {required this.id,
      required this.userId,
      required this.timestamp,
      required this.type,
      required this.value,
      required this.unit,
      final Map<String, dynamic> metadata = const {},
      this.isSynced = false,
      this.lastSyncedAt,
      this.source = DataSource.manual})
      : _metadata = metadata;

  factory _$HealthDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthDataImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime timestamp;
  @override
  final HealthMetricType type;
  @override
  final double value;
  @override
  final String unit;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  @JsonKey()
  final bool isSynced;
  @override
  final DateTime? lastSyncedAt;
  @override
  @JsonKey()
  final DataSource source;

  @override
  String toString() {
    return 'HealthData(id: $id, userId: $userId, timestamp: $timestamp, type: $type, value: $value, unit: $unit, metadata: $metadata, isSynced: $isSynced, lastSyncedAt: $lastSyncedAt, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      timestamp,
      type,
      value,
      unit,
      const DeepCollectionEquality().hash(_metadata),
      isSynced,
      lastSyncedAt,
      source);

  /// Create a copy of HealthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthDataImplCopyWith<_$HealthDataImpl> get copyWith =>
      __$$HealthDataImplCopyWithImpl<_$HealthDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthDataImplToJson(
      this,
    );
  }
}

abstract class _HealthData implements HealthData {
  const factory _HealthData(
      {required final String id,
      required final String userId,
      required final DateTime timestamp,
      required final HealthMetricType type,
      required final double value,
      required final String unit,
      final Map<String, dynamic> metadata,
      final bool isSynced,
      final DateTime? lastSyncedAt,
      final DataSource source}) = _$HealthDataImpl;

  factory _HealthData.fromJson(Map<String, dynamic> json) =
      _$HealthDataImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  DateTime get timestamp;
  @override
  HealthMetricType get type;
  @override
  double get value;
  @override
  String get unit;
  @override
  Map<String, dynamic> get metadata;
  @override
  bool get isSynced;
  @override
  DateTime? get lastSyncedAt;
  @override
  DataSource get source;

  /// Create a copy of HealthData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthDataImplCopyWith<_$HealthDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthInsights _$HealthInsightsFromJson(Map<String, dynamic> json) {
  return _HealthInsights.fromJson(json);
}

/// @nodoc
mixin _$HealthInsights {
  String get userId => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  List<HealthTrend> get trends => throw _privateConstructorUsedError;
  List<HealthRecommendation> get recommendations =>
      throw _privateConstructorUsedError;
  HealthScore get overallScore => throw _privateConstructorUsedError;
  Map<String, dynamic> get additionalData => throw _privateConstructorUsedError;

  /// Serializes this HealthInsights to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthInsightsCopyWith<HealthInsights> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthInsightsCopyWith<$Res> {
  factory $HealthInsightsCopyWith(
          HealthInsights value, $Res Function(HealthInsights) then) =
      _$HealthInsightsCopyWithImpl<$Res, HealthInsights>;
  @useResult
  $Res call(
      {String userId,
      DateTime generatedAt,
      List<HealthTrend> trends,
      List<HealthRecommendation> recommendations,
      HealthScore overallScore,
      Map<String, dynamic> additionalData});

  $HealthScoreCopyWith<$Res> get overallScore;
}

/// @nodoc
class _$HealthInsightsCopyWithImpl<$Res, $Val extends HealthInsights>
    implements $HealthInsightsCopyWith<$Res> {
  _$HealthInsightsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? generatedAt = null,
    Object? trends = null,
    Object? recommendations = null,
    Object? overallScore = null,
    Object? additionalData = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<HealthTrend>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<HealthRecommendation>,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as HealthScore,
      additionalData: null == additionalData
          ? _value.additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  /// Create a copy of HealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HealthScoreCopyWith<$Res> get overallScore {
    return $HealthScoreCopyWith<$Res>(_value.overallScore, (value) {
      return _then(_value.copyWith(overallScore: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HealthInsightsImplCopyWith<$Res>
    implements $HealthInsightsCopyWith<$Res> {
  factory _$$HealthInsightsImplCopyWith(_$HealthInsightsImpl value,
          $Res Function(_$HealthInsightsImpl) then) =
      __$$HealthInsightsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      DateTime generatedAt,
      List<HealthTrend> trends,
      List<HealthRecommendation> recommendations,
      HealthScore overallScore,
      Map<String, dynamic> additionalData});

  @override
  $HealthScoreCopyWith<$Res> get overallScore;
}

/// @nodoc
class __$$HealthInsightsImplCopyWithImpl<$Res>
    extends _$HealthInsightsCopyWithImpl<$Res, _$HealthInsightsImpl>
    implements _$$HealthInsightsImplCopyWith<$Res> {
  __$$HealthInsightsImplCopyWithImpl(
      _$HealthInsightsImpl _value, $Res Function(_$HealthInsightsImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? generatedAt = null,
    Object? trends = null,
    Object? recommendations = null,
    Object? overallScore = null,
    Object? additionalData = null,
  }) {
    return _then(_$HealthInsightsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trends: null == trends
          ? _value._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<HealthTrend>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<HealthRecommendation>,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as HealthScore,
      additionalData: null == additionalData
          ? _value._additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthInsightsImpl implements _HealthInsights {
  const _$HealthInsightsImpl(
      {required this.userId,
      required this.generatedAt,
      required final List<HealthTrend> trends,
      required final List<HealthRecommendation> recommendations,
      required this.overallScore,
      final Map<String, dynamic> additionalData = const {}})
      : _trends = trends,
        _recommendations = recommendations,
        _additionalData = additionalData;

  factory _$HealthInsightsImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthInsightsImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime generatedAt;
  final List<HealthTrend> _trends;
  @override
  List<HealthTrend> get trends {
    if (_trends is EqualUnmodifiableListView) return _trends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trends);
  }

  final List<HealthRecommendation> _recommendations;
  @override
  List<HealthRecommendation> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  final HealthScore overallScore;
  final Map<String, dynamic> _additionalData;
  @override
  @JsonKey()
  Map<String, dynamic> get additionalData {
    if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_additionalData);
  }

  @override
  String toString() {
    return 'HealthInsights(userId: $userId, generatedAt: $generatedAt, trends: $trends, recommendations: $recommendations, overallScore: $overallScore, additionalData: $additionalData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthInsightsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            const DeepCollectionEquality().equals(other._trends, _trends) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore) &&
            const DeepCollectionEquality()
                .equals(other._additionalData, _additionalData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      generatedAt,
      const DeepCollectionEquality().hash(_trends),
      const DeepCollectionEquality().hash(_recommendations),
      overallScore,
      const DeepCollectionEquality().hash(_additionalData));

  /// Create a copy of HealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthInsightsImplCopyWith<_$HealthInsightsImpl> get copyWith =>
      __$$HealthInsightsImplCopyWithImpl<_$HealthInsightsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthInsightsImplToJson(
      this,
    );
  }
}

abstract class _HealthInsights implements HealthInsights {
  const factory _HealthInsights(
      {required final String userId,
      required final DateTime generatedAt,
      required final List<HealthTrend> trends,
      required final List<HealthRecommendation> recommendations,
      required final HealthScore overallScore,
      final Map<String, dynamic> additionalData}) = _$HealthInsightsImpl;

  factory _HealthInsights.fromJson(Map<String, dynamic> json) =
      _$HealthInsightsImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get generatedAt;
  @override
  List<HealthTrend> get trends;
  @override
  List<HealthRecommendation> get recommendations;
  @override
  HealthScore get overallScore;
  @override
  Map<String, dynamic> get additionalData;

  /// Create a copy of HealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthInsightsImplCopyWith<_$HealthInsightsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthTrend _$HealthTrendFromJson(Map<String, dynamic> json) {
  return _HealthTrend.fromJson(json);
}

/// @nodoc
mixin _$HealthTrend {
  HealthMetricType get type => throw _privateConstructorUsedError;
  TrendDirection get direction => throw _privateConstructorUsedError;
  double get changePercentage => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;

  /// Serializes this HealthTrend to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthTrendCopyWith<HealthTrend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthTrendCopyWith<$Res> {
  factory $HealthTrendCopyWith(
          HealthTrend value, $Res Function(HealthTrend) then) =
      _$HealthTrendCopyWithImpl<$Res, HealthTrend>;
  @useResult
  $Res call(
      {HealthMetricType type,
      TrendDirection direction,
      double changePercentage,
      String description,
      DateTime periodStart,
      DateTime periodEnd});
}

/// @nodoc
class _$HealthTrendCopyWithImpl<$Res, $Val extends HealthTrend>
    implements $HealthTrendCopyWith<$Res> {
  _$HealthTrendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthTrend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? direction = null,
    Object? changePercentage = null,
    Object? description = null,
    Object? periodStart = null,
    Object? periodEnd = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HealthMetricType,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthTrendImplCopyWith<$Res>
    implements $HealthTrendCopyWith<$Res> {
  factory _$$HealthTrendImplCopyWith(
          _$HealthTrendImpl value, $Res Function(_$HealthTrendImpl) then) =
      __$$HealthTrendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {HealthMetricType type,
      TrendDirection direction,
      double changePercentage,
      String description,
      DateTime periodStart,
      DateTime periodEnd});
}

/// @nodoc
class __$$HealthTrendImplCopyWithImpl<$Res>
    extends _$HealthTrendCopyWithImpl<$Res, _$HealthTrendImpl>
    implements _$$HealthTrendImplCopyWith<$Res> {
  __$$HealthTrendImplCopyWithImpl(
      _$HealthTrendImpl _value, $Res Function(_$HealthTrendImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthTrend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? direction = null,
    Object? changePercentage = null,
    Object? description = null,
    Object? periodStart = null,
    Object? periodEnd = null,
  }) {
    return _then(_$HealthTrendImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HealthMetricType,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthTrendImpl implements _HealthTrend {
  const _$HealthTrendImpl(
      {required this.type,
      required this.direction,
      required this.changePercentage,
      required this.description,
      required this.periodStart,
      required this.periodEnd});

  factory _$HealthTrendImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthTrendImplFromJson(json);

  @override
  final HealthMetricType type;
  @override
  final TrendDirection direction;
  @override
  final double changePercentage;
  @override
  final String description;
  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;

  @override
  String toString() {
    return 'HealthTrend(type: $type, direction: $direction, changePercentage: $changePercentage, description: $description, periodStart: $periodStart, periodEnd: $periodEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthTrendImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, direction,
      changePercentage, description, periodStart, periodEnd);

  /// Create a copy of HealthTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthTrendImplCopyWith<_$HealthTrendImpl> get copyWith =>
      __$$HealthTrendImplCopyWithImpl<_$HealthTrendImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthTrendImplToJson(
      this,
    );
  }
}

abstract class _HealthTrend implements HealthTrend {
  const factory _HealthTrend(
      {required final HealthMetricType type,
      required final TrendDirection direction,
      required final double changePercentage,
      required final String description,
      required final DateTime periodStart,
      required final DateTime periodEnd}) = _$HealthTrendImpl;

  factory _HealthTrend.fromJson(Map<String, dynamic> json) =
      _$HealthTrendImpl.fromJson;

  @override
  HealthMetricType get type;
  @override
  TrendDirection get direction;
  @override
  double get changePercentage;
  @override
  String get description;
  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;

  /// Create a copy of HealthTrend
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthTrendImplCopyWith<_$HealthTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HealthRecommendation _$HealthRecommendationFromJson(Map<String, dynamic> json) {
  return _HealthRecommendation.fromJson(json);
}

/// @nodoc
mixin _$HealthRecommendation {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  RecommendationPriority get priority => throw _privateConstructorUsedError;
  HealthMetricType get relatedMetric => throw _privateConstructorUsedError;
  List<String> get actionItems => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this HealthRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthRecommendationCopyWith<HealthRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthRecommendationCopyWith<$Res> {
  factory $HealthRecommendationCopyWith(HealthRecommendation value,
          $Res Function(HealthRecommendation) then) =
      _$HealthRecommendationCopyWithImpl<$Res, HealthRecommendation>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      RecommendationPriority priority,
      HealthMetricType relatedMetric,
      List<String> actionItems,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$HealthRecommendationCopyWithImpl<$Res,
        $Val extends HealthRecommendation>
    implements $HealthRecommendationCopyWith<$Res> {
  _$HealthRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? relatedMetric = null,
    Object? actionItems = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as RecommendationPriority,
      relatedMetric: null == relatedMetric
          ? _value.relatedMetric
          : relatedMetric // ignore: cast_nullable_to_non_nullable
              as HealthMetricType,
      actionItems: null == actionItems
          ? _value.actionItems
          : actionItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthRecommendationImplCopyWith<$Res>
    implements $HealthRecommendationCopyWith<$Res> {
  factory _$$HealthRecommendationImplCopyWith(_$HealthRecommendationImpl value,
          $Res Function(_$HealthRecommendationImpl) then) =
      __$$HealthRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      RecommendationPriority priority,
      HealthMetricType relatedMetric,
      List<String> actionItems,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$HealthRecommendationImplCopyWithImpl<$Res>
    extends _$HealthRecommendationCopyWithImpl<$Res, _$HealthRecommendationImpl>
    implements _$$HealthRecommendationImplCopyWith<$Res> {
  __$$HealthRecommendationImplCopyWithImpl(_$HealthRecommendationImpl _value,
      $Res Function(_$HealthRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? relatedMetric = null,
    Object? actionItems = null,
    Object? metadata = null,
  }) {
    return _then(_$HealthRecommendationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as RecommendationPriority,
      relatedMetric: null == relatedMetric
          ? _value.relatedMetric
          : relatedMetric // ignore: cast_nullable_to_non_nullable
              as HealthMetricType,
      actionItems: null == actionItems
          ? _value._actionItems
          : actionItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthRecommendationImpl implements _HealthRecommendation {
  const _$HealthRecommendationImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.priority,
      required this.relatedMetric,
      required final List<String> actionItems,
      final Map<String, dynamic> metadata = const {}})
      : _actionItems = actionItems,
        _metadata = metadata;

  factory _$HealthRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthRecommendationImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final RecommendationPriority priority;
  @override
  final HealthMetricType relatedMetric;
  final List<String> _actionItems;
  @override
  List<String> get actionItems {
    if (_actionItems is EqualUnmodifiableListView) return _actionItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actionItems);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'HealthRecommendation(id: $id, title: $title, description: $description, priority: $priority, relatedMetric: $relatedMetric, actionItems: $actionItems, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.relatedMetric, relatedMetric) ||
                other.relatedMetric == relatedMetric) &&
            const DeepCollectionEquality()
                .equals(other._actionItems, _actionItems) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      priority,
      relatedMetric,
      const DeepCollectionEquality().hash(_actionItems),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of HealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthRecommendationImplCopyWith<_$HealthRecommendationImpl>
      get copyWith =>
          __$$HealthRecommendationImplCopyWithImpl<_$HealthRecommendationImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthRecommendationImplToJson(
      this,
    );
  }
}

abstract class _HealthRecommendation implements HealthRecommendation {
  const factory _HealthRecommendation(
      {required final String id,
      required final String title,
      required final String description,
      required final RecommendationPriority priority,
      required final HealthMetricType relatedMetric,
      required final List<String> actionItems,
      final Map<String, dynamic> metadata}) = _$HealthRecommendationImpl;

  factory _HealthRecommendation.fromJson(Map<String, dynamic> json) =
      _$HealthRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  RecommendationPriority get priority;
  @override
  HealthMetricType get relatedMetric;
  @override
  List<String> get actionItems;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of HealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthRecommendationImplCopyWith<_$HealthRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HealthScore _$HealthScoreFromJson(Map<String, dynamic> json) {
  return _HealthScore.fromJson(json);
}

/// @nodoc
mixin _$HealthScore {
  double get overall => throw _privateConstructorUsedError;
  Map<HealthMetricType, double> get categoryScores =>
      throw _privateConstructorUsedError;
  DateTime get calculatedAt => throw _privateConstructorUsedError;
  String get interpretation => throw _privateConstructorUsedError;

  /// Serializes this HealthScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthScoreCopyWith<HealthScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthScoreCopyWith<$Res> {
  factory $HealthScoreCopyWith(
          HealthScore value, $Res Function(HealthScore) then) =
      _$HealthScoreCopyWithImpl<$Res, HealthScore>;
  @useResult
  $Res call(
      {double overall,
      Map<HealthMetricType, double> categoryScores,
      DateTime calculatedAt,
      String interpretation});
}

/// @nodoc
class _$HealthScoreCopyWithImpl<$Res, $Val extends HealthScore>
    implements $HealthScoreCopyWith<$Res> {
  _$HealthScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overall = null,
    Object? categoryScores = null,
    Object? calculatedAt = null,
    Object? interpretation = null,
  }) {
    return _then(_value.copyWith(
      overall: null == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as double,
      categoryScores: null == categoryScores
          ? _value.categoryScores
          : categoryScores // ignore: cast_nullable_to_non_nullable
              as Map<HealthMetricType, double>,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      interpretation: null == interpretation
          ? _value.interpretation
          : interpretation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthScoreImplCopyWith<$Res>
    implements $HealthScoreCopyWith<$Res> {
  factory _$$HealthScoreImplCopyWith(
          _$HealthScoreImpl value, $Res Function(_$HealthScoreImpl) then) =
      __$$HealthScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double overall,
      Map<HealthMetricType, double> categoryScores,
      DateTime calculatedAt,
      String interpretation});
}

/// @nodoc
class __$$HealthScoreImplCopyWithImpl<$Res>
    extends _$HealthScoreCopyWithImpl<$Res, _$HealthScoreImpl>
    implements _$$HealthScoreImplCopyWith<$Res> {
  __$$HealthScoreImplCopyWithImpl(
      _$HealthScoreImpl _value, $Res Function(_$HealthScoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overall = null,
    Object? categoryScores = null,
    Object? calculatedAt = null,
    Object? interpretation = null,
  }) {
    return _then(_$HealthScoreImpl(
      overall: null == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as double,
      categoryScores: null == categoryScores
          ? _value._categoryScores
          : categoryScores // ignore: cast_nullable_to_non_nullable
              as Map<HealthMetricType, double>,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      interpretation: null == interpretation
          ? _value.interpretation
          : interpretation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthScoreImpl implements _HealthScore {
  const _$HealthScoreImpl(
      {required this.overall,
      required final Map<HealthMetricType, double> categoryScores,
      required this.calculatedAt,
      required this.interpretation})
      : _categoryScores = categoryScores;

  factory _$HealthScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthScoreImplFromJson(json);

  @override
  final double overall;
  final Map<HealthMetricType, double> _categoryScores;
  @override
  Map<HealthMetricType, double> get categoryScores {
    if (_categoryScores is EqualUnmodifiableMapView) return _categoryScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryScores);
  }

  @override
  final DateTime calculatedAt;
  @override
  final String interpretation;

  @override
  String toString() {
    return 'HealthScore(overall: $overall, categoryScores: $categoryScores, calculatedAt: $calculatedAt, interpretation: $interpretation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthScoreImpl &&
            (identical(other.overall, overall) || other.overall == overall) &&
            const DeepCollectionEquality()
                .equals(other._categoryScores, _categoryScores) &&
            (identical(other.calculatedAt, calculatedAt) ||
                other.calculatedAt == calculatedAt) &&
            (identical(other.interpretation, interpretation) ||
                other.interpretation == interpretation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      overall,
      const DeepCollectionEquality().hash(_categoryScores),
      calculatedAt,
      interpretation);

  /// Create a copy of HealthScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthScoreImplCopyWith<_$HealthScoreImpl> get copyWith =>
      __$$HealthScoreImplCopyWithImpl<_$HealthScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthScoreImplToJson(
      this,
    );
  }
}

abstract class _HealthScore implements HealthScore {
  const factory _HealthScore(
      {required final double overall,
      required final Map<HealthMetricType, double> categoryScores,
      required final DateTime calculatedAt,
      required final String interpretation}) = _$HealthScoreImpl;

  factory _HealthScore.fromJson(Map<String, dynamic> json) =
      _$HealthScoreImpl.fromJson;

  @override
  double get overall;
  @override
  Map<HealthMetricType, double> get categoryScores;
  @override
  DateTime get calculatedAt;
  @override
  String get interpretation;

  /// Create a copy of HealthScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthScoreImplCopyWith<_$HealthScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
