// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Portfolio _$PortfolioFromJson(Map<String, dynamic> json) {
  return _Portfolio.fromJson(json);
}

/// @nodoc
mixin _$Portfolio {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  List<Investment> get investments => throw _privateConstructorUsedError;
  double get totalValue => throw _privateConstructorUsedError;
  double get totalGain => throw _privateConstructorUsedError;
  double get totalGainPercentage => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;
  DateTime? get lastSyncedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this Portfolio to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Portfolio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioCopyWith<Portfolio> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioCopyWith<$Res> {
  factory $PortfolioCopyWith(Portfolio value, $Res Function(Portfolio) then) =
      _$PortfolioCopyWithImpl<$Res, Portfolio>;
  @useResult
  $Res call(
      {String id,
      String userId,
      List<Investment> investments,
      double totalValue,
      double totalGain,
      double totalGainPercentage,
      DateTime lastUpdated,
      bool isSynced,
      DateTime? lastSyncedAt,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$PortfolioCopyWithImpl<$Res, $Val extends Portfolio>
    implements $PortfolioCopyWith<$Res> {
  _$PortfolioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Portfolio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? investments = null,
    Object? totalValue = null,
    Object? totalGain = null,
    Object? totalGainPercentage = null,
    Object? lastUpdated = null,
    Object? isSynced = null,
    Object? lastSyncedAt = freezed,
    Object? metadata = null,
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
      investments: null == investments
          ? _value.investments
          : investments // ignore: cast_nullable_to_non_nullable
              as List<Investment>,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalGain: null == totalGain
          ? _value.totalGain
          : totalGain // ignore: cast_nullable_to_non_nullable
              as double,
      totalGainPercentage: null == totalGainPercentage
          ? _value.totalGainPercentage
          : totalGainPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PortfolioImplCopyWith<$Res>
    implements $PortfolioCopyWith<$Res> {
  factory _$$PortfolioImplCopyWith(
          _$PortfolioImpl value, $Res Function(_$PortfolioImpl) then) =
      __$$PortfolioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      List<Investment> investments,
      double totalValue,
      double totalGain,
      double totalGainPercentage,
      DateTime lastUpdated,
      bool isSynced,
      DateTime? lastSyncedAt,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$PortfolioImplCopyWithImpl<$Res>
    extends _$PortfolioCopyWithImpl<$Res, _$PortfolioImpl>
    implements _$$PortfolioImplCopyWith<$Res> {
  __$$PortfolioImplCopyWithImpl(
      _$PortfolioImpl _value, $Res Function(_$PortfolioImpl) _then)
      : super(_value, _then);

  /// Create a copy of Portfolio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? investments = null,
    Object? totalValue = null,
    Object? totalGain = null,
    Object? totalGainPercentage = null,
    Object? lastUpdated = null,
    Object? isSynced = null,
    Object? lastSyncedAt = freezed,
    Object? metadata = null,
  }) {
    return _then(_$PortfolioImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      investments: null == investments
          ? _value._investments
          : investments // ignore: cast_nullable_to_non_nullable
              as List<Investment>,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalGain: null == totalGain
          ? _value.totalGain
          : totalGain // ignore: cast_nullable_to_non_nullable
              as double,
      totalGainPercentage: null == totalGainPercentage
          ? _value.totalGainPercentage
          : totalGainPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PortfolioImpl implements _Portfolio {
  const _$PortfolioImpl(
      {required this.id,
      required this.userId,
      required final List<Investment> investments,
      required this.totalValue,
      required this.totalGain,
      required this.totalGainPercentage,
      required this.lastUpdated,
      this.isSynced = false,
      this.lastSyncedAt,
      final Map<String, dynamic> metadata = const {}})
      : _investments = investments,
        _metadata = metadata;

  factory _$PortfolioImpl.fromJson(Map<String, dynamic> json) =>
      _$$PortfolioImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  final List<Investment> _investments;
  @override
  List<Investment> get investments {
    if (_investments is EqualUnmodifiableListView) return _investments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_investments);
  }

  @override
  final double totalValue;
  @override
  final double totalGain;
  @override
  final double totalGainPercentage;
  @override
  final DateTime lastUpdated;
  @override
  @JsonKey()
  final bool isSynced;
  @override
  final DateTime? lastSyncedAt;
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
    return 'Portfolio(id: $id, userId: $userId, investments: $investments, totalValue: $totalValue, totalGain: $totalGain, totalGainPercentage: $totalGainPercentage, lastUpdated: $lastUpdated, isSynced: $isSynced, lastSyncedAt: $lastSyncedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._investments, _investments) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.totalGain, totalGain) ||
                other.totalGain == totalGain) &&
            (identical(other.totalGainPercentage, totalGainPercentage) ||
                other.totalGainPercentage == totalGainPercentage) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      const DeepCollectionEquality().hash(_investments),
      totalValue,
      totalGain,
      totalGainPercentage,
      lastUpdated,
      isSynced,
      lastSyncedAt,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of Portfolio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioImplCopyWith<_$PortfolioImpl> get copyWith =>
      __$$PortfolioImplCopyWithImpl<_$PortfolioImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PortfolioImplToJson(
      this,
    );
  }
}

abstract class _Portfolio implements Portfolio {
  const factory _Portfolio(
      {required final String id,
      required final String userId,
      required final List<Investment> investments,
      required final double totalValue,
      required final double totalGain,
      required final double totalGainPercentage,
      required final DateTime lastUpdated,
      final bool isSynced,
      final DateTime? lastSyncedAt,
      final Map<String, dynamic> metadata}) = _$PortfolioImpl;

  factory _Portfolio.fromJson(Map<String, dynamic> json) =
      _$PortfolioImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  List<Investment> get investments;
  @override
  double get totalValue;
  @override
  double get totalGain;
  @override
  double get totalGainPercentage;
  @override
  DateTime get lastUpdated;
  @override
  bool get isSynced;
  @override
  DateTime? get lastSyncedAt;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of Portfolio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioImplCopyWith<_$PortfolioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Investment _$InvestmentFromJson(Map<String, dynamic> json) {
  return _Investment.fromJson(json);
}

/// @nodoc
mixin _$Investment {
  String get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get shares => throw _privateConstructorUsedError;
  double get currentPrice => throw _privateConstructorUsedError;
  double get purchasePrice => throw _privateConstructorUsedError;
  DateTime get purchaseDate => throw _privateConstructorUsedError;
  InvestmentType get type => throw _privateConstructorUsedError;
  double get dividendYield => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;
  DateTime? get lastSyncedAt => throw _privateConstructorUsedError;

  /// Serializes this Investment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Investment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvestmentCopyWith<Investment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvestmentCopyWith<$Res> {
  factory $InvestmentCopyWith(
          Investment value, $Res Function(Investment) then) =
      _$InvestmentCopyWithImpl<$Res, Investment>;
  @useResult
  $Res call(
      {String id,
      String symbol,
      String name,
      double shares,
      double currentPrice,
      double purchasePrice,
      DateTime purchaseDate,
      InvestmentType type,
      double dividendYield,
      Map<String, dynamic> metadata,
      bool isSynced,
      DateTime? lastSyncedAt});
}

/// @nodoc
class _$InvestmentCopyWithImpl<$Res, $Val extends Investment>
    implements $InvestmentCopyWith<$Res> {
  _$InvestmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Investment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? symbol = null,
    Object? name = null,
    Object? shares = null,
    Object? currentPrice = null,
    Object? purchasePrice = null,
    Object? purchaseDate = null,
    Object? type = null,
    Object? dividendYield = null,
    Object? metadata = null,
    Object? isSynced = null,
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      shares: null == shares
          ? _value.shares
          : shares // ignore: cast_nullable_to_non_nullable
              as double,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
      purchasePrice: null == purchasePrice
          ? _value.purchasePrice
          : purchasePrice // ignore: cast_nullable_to_non_nullable
              as double,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InvestmentType,
      dividendYield: null == dividendYield
          ? _value.dividendYield
          : dividendYield // ignore: cast_nullable_to_non_nullable
              as double,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvestmentImplCopyWith<$Res>
    implements $InvestmentCopyWith<$Res> {
  factory _$$InvestmentImplCopyWith(
          _$InvestmentImpl value, $Res Function(_$InvestmentImpl) then) =
      __$$InvestmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String symbol,
      String name,
      double shares,
      double currentPrice,
      double purchasePrice,
      DateTime purchaseDate,
      InvestmentType type,
      double dividendYield,
      Map<String, dynamic> metadata,
      bool isSynced,
      DateTime? lastSyncedAt});
}

/// @nodoc
class __$$InvestmentImplCopyWithImpl<$Res>
    extends _$InvestmentCopyWithImpl<$Res, _$InvestmentImpl>
    implements _$$InvestmentImplCopyWith<$Res> {
  __$$InvestmentImplCopyWithImpl(
      _$InvestmentImpl _value, $Res Function(_$InvestmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Investment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? symbol = null,
    Object? name = null,
    Object? shares = null,
    Object? currentPrice = null,
    Object? purchasePrice = null,
    Object? purchaseDate = null,
    Object? type = null,
    Object? dividendYield = null,
    Object? metadata = null,
    Object? isSynced = null,
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_$InvestmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      shares: null == shares
          ? _value.shares
          : shares // ignore: cast_nullable_to_non_nullable
              as double,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
      purchasePrice: null == purchasePrice
          ? _value.purchasePrice
          : purchasePrice // ignore: cast_nullable_to_non_nullable
              as double,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InvestmentType,
      dividendYield: null == dividendYield
          ? _value.dividendYield
          : dividendYield // ignore: cast_nullable_to_non_nullable
              as double,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvestmentImpl implements _Investment {
  const _$InvestmentImpl(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.shares,
      required this.currentPrice,
      required this.purchasePrice,
      required this.purchaseDate,
      required this.type,
      this.dividendYield = 0.0,
      final Map<String, dynamic> metadata = const {},
      this.isSynced = false,
      this.lastSyncedAt})
      : _metadata = metadata;

  factory _$InvestmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvestmentImplFromJson(json);

  @override
  final String id;
  @override
  final String symbol;
  @override
  final String name;
  @override
  final double shares;
  @override
  final double currentPrice;
  @override
  final double purchasePrice;
  @override
  final DateTime purchaseDate;
  @override
  final InvestmentType type;
  @override
  @JsonKey()
  final double dividendYield;
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
  String toString() {
    return 'Investment(id: $id, symbol: $symbol, name: $name, shares: $shares, currentPrice: $currentPrice, purchasePrice: $purchasePrice, purchaseDate: $purchaseDate, type: $type, dividendYield: $dividendYield, metadata: $metadata, isSynced: $isSynced, lastSyncedAt: $lastSyncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvestmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.purchasePrice, purchasePrice) ||
                other.purchasePrice == purchasePrice) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.dividendYield, dividendYield) ||
                other.dividendYield == dividendYield) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      symbol,
      name,
      shares,
      currentPrice,
      purchasePrice,
      purchaseDate,
      type,
      dividendYield,
      const DeepCollectionEquality().hash(_metadata),
      isSynced,
      lastSyncedAt);

  /// Create a copy of Investment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvestmentImplCopyWith<_$InvestmentImpl> get copyWith =>
      __$$InvestmentImplCopyWithImpl<_$InvestmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvestmentImplToJson(
      this,
    );
  }
}

abstract class _Investment implements Investment {
  const factory _Investment(
      {required final String id,
      required final String symbol,
      required final String name,
      required final double shares,
      required final double currentPrice,
      required final double purchasePrice,
      required final DateTime purchaseDate,
      required final InvestmentType type,
      final double dividendYield,
      final Map<String, dynamic> metadata,
      final bool isSynced,
      final DateTime? lastSyncedAt}) = _$InvestmentImpl;

  factory _Investment.fromJson(Map<String, dynamic> json) =
      _$InvestmentImpl.fromJson;

  @override
  String get id;
  @override
  String get symbol;
  @override
  String get name;
  @override
  double get shares;
  @override
  double get currentPrice;
  @override
  double get purchasePrice;
  @override
  DateTime get purchaseDate;
  @override
  InvestmentType get type;
  @override
  double get dividendYield;
  @override
  Map<String, dynamic> get metadata;
  @override
  bool get isSynced;
  @override
  DateTime? get lastSyncedAt;

  /// Create a copy of Investment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvestmentImplCopyWith<_$InvestmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WealthInsights _$WealthInsightsFromJson(Map<String, dynamic> json) {
  return _WealthInsights.fromJson(json);
}

/// @nodoc
mixin _$WealthInsights {
  String get userId => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  PortfolioAnalysis get portfolioAnalysis => throw _privateConstructorUsedError;
  List<WealthRecommendation> get recommendations =>
      throw _privateConstructorUsedError;
  RiskAssessment get riskAssessment => throw _privateConstructorUsedError;
  List<WealthTrend> get trends => throw _privateConstructorUsedError;
  Map<String, dynamic> get additionalData => throw _privateConstructorUsedError;

  /// Serializes this WealthInsights to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WealthInsightsCopyWith<WealthInsights> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WealthInsightsCopyWith<$Res> {
  factory $WealthInsightsCopyWith(
          WealthInsights value, $Res Function(WealthInsights) then) =
      _$WealthInsightsCopyWithImpl<$Res, WealthInsights>;
  @useResult
  $Res call(
      {String userId,
      DateTime generatedAt,
      PortfolioAnalysis portfolioAnalysis,
      List<WealthRecommendation> recommendations,
      RiskAssessment riskAssessment,
      List<WealthTrend> trends,
      Map<String, dynamic> additionalData});

  $PortfolioAnalysisCopyWith<$Res> get portfolioAnalysis;
  $RiskAssessmentCopyWith<$Res> get riskAssessment;
}

/// @nodoc
class _$WealthInsightsCopyWithImpl<$Res, $Val extends WealthInsights>
    implements $WealthInsightsCopyWith<$Res> {
  _$WealthInsightsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? generatedAt = null,
    Object? portfolioAnalysis = null,
    Object? recommendations = null,
    Object? riskAssessment = null,
    Object? trends = null,
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
      portfolioAnalysis: null == portfolioAnalysis
          ? _value.portfolioAnalysis
          : portfolioAnalysis // ignore: cast_nullable_to_non_nullable
              as PortfolioAnalysis,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<WealthRecommendation>,
      riskAssessment: null == riskAssessment
          ? _value.riskAssessment
          : riskAssessment // ignore: cast_nullable_to_non_nullable
              as RiskAssessment,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<WealthTrend>,
      additionalData: null == additionalData
          ? _value.additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  /// Create a copy of WealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PortfolioAnalysisCopyWith<$Res> get portfolioAnalysis {
    return $PortfolioAnalysisCopyWith<$Res>(_value.portfolioAnalysis, (value) {
      return _then(_value.copyWith(portfolioAnalysis: value) as $Val);
    });
  }

  /// Create a copy of WealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskAssessmentCopyWith<$Res> get riskAssessment {
    return $RiskAssessmentCopyWith<$Res>(_value.riskAssessment, (value) {
      return _then(_value.copyWith(riskAssessment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WealthInsightsImplCopyWith<$Res>
    implements $WealthInsightsCopyWith<$Res> {
  factory _$$WealthInsightsImplCopyWith(_$WealthInsightsImpl value,
          $Res Function(_$WealthInsightsImpl) then) =
      __$$WealthInsightsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      DateTime generatedAt,
      PortfolioAnalysis portfolioAnalysis,
      List<WealthRecommendation> recommendations,
      RiskAssessment riskAssessment,
      List<WealthTrend> trends,
      Map<String, dynamic> additionalData});

  @override
  $PortfolioAnalysisCopyWith<$Res> get portfolioAnalysis;
  @override
  $RiskAssessmentCopyWith<$Res> get riskAssessment;
}

/// @nodoc
class __$$WealthInsightsImplCopyWithImpl<$Res>
    extends _$WealthInsightsCopyWithImpl<$Res, _$WealthInsightsImpl>
    implements _$$WealthInsightsImplCopyWith<$Res> {
  __$$WealthInsightsImplCopyWithImpl(
      _$WealthInsightsImpl _value, $Res Function(_$WealthInsightsImpl) _then)
      : super(_value, _then);

  /// Create a copy of WealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? generatedAt = null,
    Object? portfolioAnalysis = null,
    Object? recommendations = null,
    Object? riskAssessment = null,
    Object? trends = null,
    Object? additionalData = null,
  }) {
    return _then(_$WealthInsightsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      portfolioAnalysis: null == portfolioAnalysis
          ? _value.portfolioAnalysis
          : portfolioAnalysis // ignore: cast_nullable_to_non_nullable
              as PortfolioAnalysis,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<WealthRecommendation>,
      riskAssessment: null == riskAssessment
          ? _value.riskAssessment
          : riskAssessment // ignore: cast_nullable_to_non_nullable
              as RiskAssessment,
      trends: null == trends
          ? _value._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<WealthTrend>,
      additionalData: null == additionalData
          ? _value._additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WealthInsightsImpl implements _WealthInsights {
  const _$WealthInsightsImpl(
      {required this.userId,
      required this.generatedAt,
      required this.portfolioAnalysis,
      required final List<WealthRecommendation> recommendations,
      required this.riskAssessment,
      required final List<WealthTrend> trends,
      final Map<String, dynamic> additionalData = const {}})
      : _recommendations = recommendations,
        _trends = trends,
        _additionalData = additionalData;

  factory _$WealthInsightsImpl.fromJson(Map<String, dynamic> json) =>
      _$$WealthInsightsImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime generatedAt;
  @override
  final PortfolioAnalysis portfolioAnalysis;
  final List<WealthRecommendation> _recommendations;
  @override
  List<WealthRecommendation> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  final RiskAssessment riskAssessment;
  final List<WealthTrend> _trends;
  @override
  List<WealthTrend> get trends {
    if (_trends is EqualUnmodifiableListView) return _trends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trends);
  }

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
    return 'WealthInsights(userId: $userId, generatedAt: $generatedAt, portfolioAnalysis: $portfolioAnalysis, recommendations: $recommendations, riskAssessment: $riskAssessment, trends: $trends, additionalData: $additionalData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WealthInsightsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.portfolioAnalysis, portfolioAnalysis) ||
                other.portfolioAnalysis == portfolioAnalysis) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.riskAssessment, riskAssessment) ||
                other.riskAssessment == riskAssessment) &&
            const DeepCollectionEquality().equals(other._trends, _trends) &&
            const DeepCollectionEquality()
                .equals(other._additionalData, _additionalData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      generatedAt,
      portfolioAnalysis,
      const DeepCollectionEquality().hash(_recommendations),
      riskAssessment,
      const DeepCollectionEquality().hash(_trends),
      const DeepCollectionEquality().hash(_additionalData));

  /// Create a copy of WealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WealthInsightsImplCopyWith<_$WealthInsightsImpl> get copyWith =>
      __$$WealthInsightsImplCopyWithImpl<_$WealthInsightsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WealthInsightsImplToJson(
      this,
    );
  }
}

abstract class _WealthInsights implements WealthInsights {
  const factory _WealthInsights(
      {required final String userId,
      required final DateTime generatedAt,
      required final PortfolioAnalysis portfolioAnalysis,
      required final List<WealthRecommendation> recommendations,
      required final RiskAssessment riskAssessment,
      required final List<WealthTrend> trends,
      final Map<String, dynamic> additionalData}) = _$WealthInsightsImpl;

  factory _WealthInsights.fromJson(Map<String, dynamic> json) =
      _$WealthInsightsImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get generatedAt;
  @override
  PortfolioAnalysis get portfolioAnalysis;
  @override
  List<WealthRecommendation> get recommendations;
  @override
  RiskAssessment get riskAssessment;
  @override
  List<WealthTrend> get trends;
  @override
  Map<String, dynamic> get additionalData;

  /// Create a copy of WealthInsights
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WealthInsightsImplCopyWith<_$WealthInsightsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PortfolioAnalysis _$PortfolioAnalysisFromJson(Map<String, dynamic> json) {
  return _PortfolioAnalysis.fromJson(json);
}

/// @nodoc
mixin _$PortfolioAnalysis {
  double get totalValue => throw _privateConstructorUsedError;
  double get totalReturn => throw _privateConstructorUsedError;
  double get totalReturnPercentage => throw _privateConstructorUsedError;
  double get annualizedReturn => throw _privateConstructorUsedError;
  double get volatility => throw _privateConstructorUsedError;
  double get sharpeRatio => throw _privateConstructorUsedError;
  Map<AssetClass, double> get assetAllocation =>
      throw _privateConstructorUsedError;
  Map<String, double> get sectorAllocation =>
      throw _privateConstructorUsedError;
  DateTime get analysisDate => throw _privateConstructorUsedError;

  /// Serializes this PortfolioAnalysis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PortfolioAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioAnalysisCopyWith<PortfolioAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioAnalysisCopyWith<$Res> {
  factory $PortfolioAnalysisCopyWith(
          PortfolioAnalysis value, $Res Function(PortfolioAnalysis) then) =
      _$PortfolioAnalysisCopyWithImpl<$Res, PortfolioAnalysis>;
  @useResult
  $Res call(
      {double totalValue,
      double totalReturn,
      double totalReturnPercentage,
      double annualizedReturn,
      double volatility,
      double sharpeRatio,
      Map<AssetClass, double> assetAllocation,
      Map<String, double> sectorAllocation,
      DateTime analysisDate});
}

/// @nodoc
class _$PortfolioAnalysisCopyWithImpl<$Res, $Val extends PortfolioAnalysis>
    implements $PortfolioAnalysisCopyWith<$Res> {
  _$PortfolioAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortfolioAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalValue = null,
    Object? totalReturn = null,
    Object? totalReturnPercentage = null,
    Object? annualizedReturn = null,
    Object? volatility = null,
    Object? sharpeRatio = null,
    Object? assetAllocation = null,
    Object? sectorAllocation = null,
    Object? analysisDate = null,
  }) {
    return _then(_value.copyWith(
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalReturn: null == totalReturn
          ? _value.totalReturn
          : totalReturn // ignore: cast_nullable_to_non_nullable
              as double,
      totalReturnPercentage: null == totalReturnPercentage
          ? _value.totalReturnPercentage
          : totalReturnPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      annualizedReturn: null == annualizedReturn
          ? _value.annualizedReturn
          : annualizedReturn // ignore: cast_nullable_to_non_nullable
              as double,
      volatility: null == volatility
          ? _value.volatility
          : volatility // ignore: cast_nullable_to_non_nullable
              as double,
      sharpeRatio: null == sharpeRatio
          ? _value.sharpeRatio
          : sharpeRatio // ignore: cast_nullable_to_non_nullable
              as double,
      assetAllocation: null == assetAllocation
          ? _value.assetAllocation
          : assetAllocation // ignore: cast_nullable_to_non_nullable
              as Map<AssetClass, double>,
      sectorAllocation: null == sectorAllocation
          ? _value.sectorAllocation
          : sectorAllocation // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      analysisDate: null == analysisDate
          ? _value.analysisDate
          : analysisDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PortfolioAnalysisImplCopyWith<$Res>
    implements $PortfolioAnalysisCopyWith<$Res> {
  factory _$$PortfolioAnalysisImplCopyWith(_$PortfolioAnalysisImpl value,
          $Res Function(_$PortfolioAnalysisImpl) then) =
      __$$PortfolioAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalValue,
      double totalReturn,
      double totalReturnPercentage,
      double annualizedReturn,
      double volatility,
      double sharpeRatio,
      Map<AssetClass, double> assetAllocation,
      Map<String, double> sectorAllocation,
      DateTime analysisDate});
}

/// @nodoc
class __$$PortfolioAnalysisImplCopyWithImpl<$Res>
    extends _$PortfolioAnalysisCopyWithImpl<$Res, _$PortfolioAnalysisImpl>
    implements _$$PortfolioAnalysisImplCopyWith<$Res> {
  __$$PortfolioAnalysisImplCopyWithImpl(_$PortfolioAnalysisImpl _value,
      $Res Function(_$PortfolioAnalysisImpl) _then)
      : super(_value, _then);

  /// Create a copy of PortfolioAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalValue = null,
    Object? totalReturn = null,
    Object? totalReturnPercentage = null,
    Object? annualizedReturn = null,
    Object? volatility = null,
    Object? sharpeRatio = null,
    Object? assetAllocation = null,
    Object? sectorAllocation = null,
    Object? analysisDate = null,
  }) {
    return _then(_$PortfolioAnalysisImpl(
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalReturn: null == totalReturn
          ? _value.totalReturn
          : totalReturn // ignore: cast_nullable_to_non_nullable
              as double,
      totalReturnPercentage: null == totalReturnPercentage
          ? _value.totalReturnPercentage
          : totalReturnPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      annualizedReturn: null == annualizedReturn
          ? _value.annualizedReturn
          : annualizedReturn // ignore: cast_nullable_to_non_nullable
              as double,
      volatility: null == volatility
          ? _value.volatility
          : volatility // ignore: cast_nullable_to_non_nullable
              as double,
      sharpeRatio: null == sharpeRatio
          ? _value.sharpeRatio
          : sharpeRatio // ignore: cast_nullable_to_non_nullable
              as double,
      assetAllocation: null == assetAllocation
          ? _value._assetAllocation
          : assetAllocation // ignore: cast_nullable_to_non_nullable
              as Map<AssetClass, double>,
      sectorAllocation: null == sectorAllocation
          ? _value._sectorAllocation
          : sectorAllocation // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      analysisDate: null == analysisDate
          ? _value.analysisDate
          : analysisDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PortfolioAnalysisImpl implements _PortfolioAnalysis {
  const _$PortfolioAnalysisImpl(
      {required this.totalValue,
      required this.totalReturn,
      required this.totalReturnPercentage,
      required this.annualizedReturn,
      required this.volatility,
      required this.sharpeRatio,
      required final Map<AssetClass, double> assetAllocation,
      required final Map<String, double> sectorAllocation,
      required this.analysisDate})
      : _assetAllocation = assetAllocation,
        _sectorAllocation = sectorAllocation;

  factory _$PortfolioAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$PortfolioAnalysisImplFromJson(json);

  @override
  final double totalValue;
  @override
  final double totalReturn;
  @override
  final double totalReturnPercentage;
  @override
  final double annualizedReturn;
  @override
  final double volatility;
  @override
  final double sharpeRatio;
  final Map<AssetClass, double> _assetAllocation;
  @override
  Map<AssetClass, double> get assetAllocation {
    if (_assetAllocation is EqualUnmodifiableMapView) return _assetAllocation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_assetAllocation);
  }

  final Map<String, double> _sectorAllocation;
  @override
  Map<String, double> get sectorAllocation {
    if (_sectorAllocation is EqualUnmodifiableMapView) return _sectorAllocation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sectorAllocation);
  }

  @override
  final DateTime analysisDate;

  @override
  String toString() {
    return 'PortfolioAnalysis(totalValue: $totalValue, totalReturn: $totalReturn, totalReturnPercentage: $totalReturnPercentage, annualizedReturn: $annualizedReturn, volatility: $volatility, sharpeRatio: $sharpeRatio, assetAllocation: $assetAllocation, sectorAllocation: $sectorAllocation, analysisDate: $analysisDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioAnalysisImpl &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.totalReturn, totalReturn) ||
                other.totalReturn == totalReturn) &&
            (identical(other.totalReturnPercentage, totalReturnPercentage) ||
                other.totalReturnPercentage == totalReturnPercentage) &&
            (identical(other.annualizedReturn, annualizedReturn) ||
                other.annualizedReturn == annualizedReturn) &&
            (identical(other.volatility, volatility) ||
                other.volatility == volatility) &&
            (identical(other.sharpeRatio, sharpeRatio) ||
                other.sharpeRatio == sharpeRatio) &&
            const DeepCollectionEquality()
                .equals(other._assetAllocation, _assetAllocation) &&
            const DeepCollectionEquality()
                .equals(other._sectorAllocation, _sectorAllocation) &&
            (identical(other.analysisDate, analysisDate) ||
                other.analysisDate == analysisDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalValue,
      totalReturn,
      totalReturnPercentage,
      annualizedReturn,
      volatility,
      sharpeRatio,
      const DeepCollectionEquality().hash(_assetAllocation),
      const DeepCollectionEquality().hash(_sectorAllocation),
      analysisDate);

  /// Create a copy of PortfolioAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioAnalysisImplCopyWith<_$PortfolioAnalysisImpl> get copyWith =>
      __$$PortfolioAnalysisImplCopyWithImpl<_$PortfolioAnalysisImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PortfolioAnalysisImplToJson(
      this,
    );
  }
}

abstract class _PortfolioAnalysis implements PortfolioAnalysis {
  const factory _PortfolioAnalysis(
      {required final double totalValue,
      required final double totalReturn,
      required final double totalReturnPercentage,
      required final double annualizedReturn,
      required final double volatility,
      required final double sharpeRatio,
      required final Map<AssetClass, double> assetAllocation,
      required final Map<String, double> sectorAllocation,
      required final DateTime analysisDate}) = _$PortfolioAnalysisImpl;

  factory _PortfolioAnalysis.fromJson(Map<String, dynamic> json) =
      _$PortfolioAnalysisImpl.fromJson;

  @override
  double get totalValue;
  @override
  double get totalReturn;
  @override
  double get totalReturnPercentage;
  @override
  double get annualizedReturn;
  @override
  double get volatility;
  @override
  double get sharpeRatio;
  @override
  Map<AssetClass, double> get assetAllocation;
  @override
  Map<String, double> get sectorAllocation;
  @override
  DateTime get analysisDate;

  /// Create a copy of PortfolioAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioAnalysisImplCopyWith<_$PortfolioAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WealthRecommendation _$WealthRecommendationFromJson(Map<String, dynamic> json) {
  return _WealthRecommendation.fromJson(json);
}

/// @nodoc
mixin _$WealthRecommendation {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  RecommendationPriority get priority => throw _privateConstructorUsedError;
  WealthRecommendationType get type => throw _privateConstructorUsedError;
  List<String> get actionItems => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this WealthRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WealthRecommendationCopyWith<WealthRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WealthRecommendationCopyWith<$Res> {
  factory $WealthRecommendationCopyWith(WealthRecommendation value,
          $Res Function(WealthRecommendation) then) =
      _$WealthRecommendationCopyWithImpl<$Res, WealthRecommendation>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      RecommendationPriority priority,
      WealthRecommendationType type,
      List<String> actionItems,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$WealthRecommendationCopyWithImpl<$Res,
        $Val extends WealthRecommendation>
    implements $WealthRecommendationCopyWith<$Res> {
  _$WealthRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? type = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WealthRecommendationType,
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
abstract class _$$WealthRecommendationImplCopyWith<$Res>
    implements $WealthRecommendationCopyWith<$Res> {
  factory _$$WealthRecommendationImplCopyWith(_$WealthRecommendationImpl value,
          $Res Function(_$WealthRecommendationImpl) then) =
      __$$WealthRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      RecommendationPriority priority,
      WealthRecommendationType type,
      List<String> actionItems,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$WealthRecommendationImplCopyWithImpl<$Res>
    extends _$WealthRecommendationCopyWithImpl<$Res, _$WealthRecommendationImpl>
    implements _$$WealthRecommendationImplCopyWith<$Res> {
  __$$WealthRecommendationImplCopyWithImpl(_$WealthRecommendationImpl _value,
      $Res Function(_$WealthRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of WealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? type = null,
    Object? actionItems = null,
    Object? metadata = null,
  }) {
    return _then(_$WealthRecommendationImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WealthRecommendationType,
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
class _$WealthRecommendationImpl implements _WealthRecommendation {
  const _$WealthRecommendationImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.priority,
      required this.type,
      required final List<String> actionItems,
      final Map<String, dynamic> metadata = const {}})
      : _actionItems = actionItems,
        _metadata = metadata;

  factory _$WealthRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$WealthRecommendationImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final RecommendationPriority priority;
  @override
  final WealthRecommendationType type;
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
    return 'WealthRecommendation(id: $id, title: $title, description: $description, priority: $priority, type: $type, actionItems: $actionItems, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WealthRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.type, type) || other.type == type) &&
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
      type,
      const DeepCollectionEquality().hash(_actionItems),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of WealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WealthRecommendationImplCopyWith<_$WealthRecommendationImpl>
      get copyWith =>
          __$$WealthRecommendationImplCopyWithImpl<_$WealthRecommendationImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WealthRecommendationImplToJson(
      this,
    );
  }
}

abstract class _WealthRecommendation implements WealthRecommendation {
  const factory _WealthRecommendation(
      {required final String id,
      required final String title,
      required final String description,
      required final RecommendationPriority priority,
      required final WealthRecommendationType type,
      required final List<String> actionItems,
      final Map<String, dynamic> metadata}) = _$WealthRecommendationImpl;

  factory _WealthRecommendation.fromJson(Map<String, dynamic> json) =
      _$WealthRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  RecommendationPriority get priority;
  @override
  WealthRecommendationType get type;
  @override
  List<String> get actionItems;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of WealthRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WealthRecommendationImplCopyWith<_$WealthRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

RiskAssessment _$RiskAssessmentFromJson(Map<String, dynamic> json) {
  return _RiskAssessment.fromJson(json);
}

/// @nodoc
mixin _$RiskAssessment {
  RiskLevel get overallRisk => throw _privateConstructorUsedError;
  double get riskScore => throw _privateConstructorUsedError;
  Map<RiskCategory, double> get categoryRisks =>
      throw _privateConstructorUsedError;
  List<RiskFactor> get riskFactors => throw _privateConstructorUsedError;
  DateTime get assessmentDate => throw _privateConstructorUsedError;

  /// Serializes this RiskAssessment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RiskAssessmentCopyWith<RiskAssessment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskAssessmentCopyWith<$Res> {
  factory $RiskAssessmentCopyWith(
          RiskAssessment value, $Res Function(RiskAssessment) then) =
      _$RiskAssessmentCopyWithImpl<$Res, RiskAssessment>;
  @useResult
  $Res call(
      {RiskLevel overallRisk,
      double riskScore,
      Map<RiskCategory, double> categoryRisks,
      List<RiskFactor> riskFactors,
      DateTime assessmentDate});
}

/// @nodoc
class _$RiskAssessmentCopyWithImpl<$Res, $Val extends RiskAssessment>
    implements $RiskAssessmentCopyWith<$Res> {
  _$RiskAssessmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallRisk = null,
    Object? riskScore = null,
    Object? categoryRisks = null,
    Object? riskFactors = null,
    Object? assessmentDate = null,
  }) {
    return _then(_value.copyWith(
      overallRisk: null == overallRisk
          ? _value.overallRisk
          : overallRisk // ignore: cast_nullable_to_non_nullable
              as RiskLevel,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      categoryRisks: null == categoryRisks
          ? _value.categoryRisks
          : categoryRisks // ignore: cast_nullable_to_non_nullable
              as Map<RiskCategory, double>,
      riskFactors: null == riskFactors
          ? _value.riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<RiskFactor>,
      assessmentDate: null == assessmentDate
          ? _value.assessmentDate
          : assessmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskAssessmentImplCopyWith<$Res>
    implements $RiskAssessmentCopyWith<$Res> {
  factory _$$RiskAssessmentImplCopyWith(_$RiskAssessmentImpl value,
          $Res Function(_$RiskAssessmentImpl) then) =
      __$$RiskAssessmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RiskLevel overallRisk,
      double riskScore,
      Map<RiskCategory, double> categoryRisks,
      List<RiskFactor> riskFactors,
      DateTime assessmentDate});
}

/// @nodoc
class __$$RiskAssessmentImplCopyWithImpl<$Res>
    extends _$RiskAssessmentCopyWithImpl<$Res, _$RiskAssessmentImpl>
    implements _$$RiskAssessmentImplCopyWith<$Res> {
  __$$RiskAssessmentImplCopyWithImpl(
      _$RiskAssessmentImpl _value, $Res Function(_$RiskAssessmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallRisk = null,
    Object? riskScore = null,
    Object? categoryRisks = null,
    Object? riskFactors = null,
    Object? assessmentDate = null,
  }) {
    return _then(_$RiskAssessmentImpl(
      overallRisk: null == overallRisk
          ? _value.overallRisk
          : overallRisk // ignore: cast_nullable_to_non_nullable
              as RiskLevel,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      categoryRisks: null == categoryRisks
          ? _value._categoryRisks
          : categoryRisks // ignore: cast_nullable_to_non_nullable
              as Map<RiskCategory, double>,
      riskFactors: null == riskFactors
          ? _value._riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<RiskFactor>,
      assessmentDate: null == assessmentDate
          ? _value.assessmentDate
          : assessmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskAssessmentImpl implements _RiskAssessment {
  const _$RiskAssessmentImpl(
      {required this.overallRisk,
      required this.riskScore,
      required final Map<RiskCategory, double> categoryRisks,
      required final List<RiskFactor> riskFactors,
      required this.assessmentDate})
      : _categoryRisks = categoryRisks,
        _riskFactors = riskFactors;

  factory _$RiskAssessmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskAssessmentImplFromJson(json);

  @override
  final RiskLevel overallRisk;
  @override
  final double riskScore;
  final Map<RiskCategory, double> _categoryRisks;
  @override
  Map<RiskCategory, double> get categoryRisks {
    if (_categoryRisks is EqualUnmodifiableMapView) return _categoryRisks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryRisks);
  }

  final List<RiskFactor> _riskFactors;
  @override
  List<RiskFactor> get riskFactors {
    if (_riskFactors is EqualUnmodifiableListView) return _riskFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_riskFactors);
  }

  @override
  final DateTime assessmentDate;

  @override
  String toString() {
    return 'RiskAssessment(overallRisk: $overallRisk, riskScore: $riskScore, categoryRisks: $categoryRisks, riskFactors: $riskFactors, assessmentDate: $assessmentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskAssessmentImpl &&
            (identical(other.overallRisk, overallRisk) ||
                other.overallRisk == overallRisk) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            const DeepCollectionEquality()
                .equals(other._categoryRisks, _categoryRisks) &&
            const DeepCollectionEquality()
                .equals(other._riskFactors, _riskFactors) &&
            (identical(other.assessmentDate, assessmentDate) ||
                other.assessmentDate == assessmentDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      overallRisk,
      riskScore,
      const DeepCollectionEquality().hash(_categoryRisks),
      const DeepCollectionEquality().hash(_riskFactors),
      assessmentDate);

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskAssessmentImplCopyWith<_$RiskAssessmentImpl> get copyWith =>
      __$$RiskAssessmentImplCopyWithImpl<_$RiskAssessmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskAssessmentImplToJson(
      this,
    );
  }
}

abstract class _RiskAssessment implements RiskAssessment {
  const factory _RiskAssessment(
      {required final RiskLevel overallRisk,
      required final double riskScore,
      required final Map<RiskCategory, double> categoryRisks,
      required final List<RiskFactor> riskFactors,
      required final DateTime assessmentDate}) = _$RiskAssessmentImpl;

  factory _RiskAssessment.fromJson(Map<String, dynamic> json) =
      _$RiskAssessmentImpl.fromJson;

  @override
  RiskLevel get overallRisk;
  @override
  double get riskScore;
  @override
  Map<RiskCategory, double> get categoryRisks;
  @override
  List<RiskFactor> get riskFactors;
  @override
  DateTime get assessmentDate;

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskAssessmentImplCopyWith<_$RiskAssessmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WealthTrend _$WealthTrendFromJson(Map<String, dynamic> json) {
  return _WealthTrend.fromJson(json);
}

/// @nodoc
mixin _$WealthTrend {
  WealthMetricType get type => throw _privateConstructorUsedError;
  TrendDirection get direction => throw _privateConstructorUsedError;
  double get changePercentage => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;

  /// Serializes this WealthTrend to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WealthTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WealthTrendCopyWith<WealthTrend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WealthTrendCopyWith<$Res> {
  factory $WealthTrendCopyWith(
          WealthTrend value, $Res Function(WealthTrend) then) =
      _$WealthTrendCopyWithImpl<$Res, WealthTrend>;
  @useResult
  $Res call(
      {WealthMetricType type,
      TrendDirection direction,
      double changePercentage,
      String description,
      DateTime periodStart,
      DateTime periodEnd});
}

/// @nodoc
class _$WealthTrendCopyWithImpl<$Res, $Val extends WealthTrend>
    implements $WealthTrendCopyWith<$Res> {
  _$WealthTrendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WealthTrend
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
              as WealthMetricType,
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
abstract class _$$WealthTrendImplCopyWith<$Res>
    implements $WealthTrendCopyWith<$Res> {
  factory _$$WealthTrendImplCopyWith(
          _$WealthTrendImpl value, $Res Function(_$WealthTrendImpl) then) =
      __$$WealthTrendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WealthMetricType type,
      TrendDirection direction,
      double changePercentage,
      String description,
      DateTime periodStart,
      DateTime periodEnd});
}

/// @nodoc
class __$$WealthTrendImplCopyWithImpl<$Res>
    extends _$WealthTrendCopyWithImpl<$Res, _$WealthTrendImpl>
    implements _$$WealthTrendImplCopyWith<$Res> {
  __$$WealthTrendImplCopyWithImpl(
      _$WealthTrendImpl _value, $Res Function(_$WealthTrendImpl) _then)
      : super(_value, _then);

  /// Create a copy of WealthTrend
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
    return _then(_$WealthTrendImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WealthMetricType,
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
class _$WealthTrendImpl implements _WealthTrend {
  const _$WealthTrendImpl(
      {required this.type,
      required this.direction,
      required this.changePercentage,
      required this.description,
      required this.periodStart,
      required this.periodEnd});

  factory _$WealthTrendImpl.fromJson(Map<String, dynamic> json) =>
      _$$WealthTrendImplFromJson(json);

  @override
  final WealthMetricType type;
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
    return 'WealthTrend(type: $type, direction: $direction, changePercentage: $changePercentage, description: $description, periodStart: $periodStart, periodEnd: $periodEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WealthTrendImpl &&
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

  /// Create a copy of WealthTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WealthTrendImplCopyWith<_$WealthTrendImpl> get copyWith =>
      __$$WealthTrendImplCopyWithImpl<_$WealthTrendImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WealthTrendImplToJson(
      this,
    );
  }
}

abstract class _WealthTrend implements WealthTrend {
  const factory _WealthTrend(
      {required final WealthMetricType type,
      required final TrendDirection direction,
      required final double changePercentage,
      required final String description,
      required final DateTime periodStart,
      required final DateTime periodEnd}) = _$WealthTrendImpl;

  factory _WealthTrend.fromJson(Map<String, dynamic> json) =
      _$WealthTrendImpl.fromJson;

  @override
  WealthMetricType get type;
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

  /// Create a copy of WealthTrend
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WealthTrendImplCopyWith<_$WealthTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RiskFactor _$RiskFactorFromJson(Map<String, dynamic> json) {
  return _RiskFactor.fromJson(json);
}

/// @nodoc
mixin _$RiskFactor {
  String get name => throw _privateConstructorUsedError;
  RiskLevel get level => throw _privateConstructorUsedError;
  double get impact => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this RiskFactor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RiskFactor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RiskFactorCopyWith<RiskFactor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskFactorCopyWith<$Res> {
  factory $RiskFactorCopyWith(
          RiskFactor value, $Res Function(RiskFactor) then) =
      _$RiskFactorCopyWithImpl<$Res, RiskFactor>;
  @useResult
  $Res call({String name, RiskLevel level, double impact, String description});
}

/// @nodoc
class _$RiskFactorCopyWithImpl<$Res, $Val extends RiskFactor>
    implements $RiskFactorCopyWith<$Res> {
  _$RiskFactorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RiskFactor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? level = null,
    Object? impact = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as RiskLevel,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskFactorImplCopyWith<$Res>
    implements $RiskFactorCopyWith<$Res> {
  factory _$$RiskFactorImplCopyWith(
          _$RiskFactorImpl value, $Res Function(_$RiskFactorImpl) then) =
      __$$RiskFactorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, RiskLevel level, double impact, String description});
}

/// @nodoc
class __$$RiskFactorImplCopyWithImpl<$Res>
    extends _$RiskFactorCopyWithImpl<$Res, _$RiskFactorImpl>
    implements _$$RiskFactorImplCopyWith<$Res> {
  __$$RiskFactorImplCopyWithImpl(
      _$RiskFactorImpl _value, $Res Function(_$RiskFactorImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskFactor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? level = null,
    Object? impact = null,
    Object? description = null,
  }) {
    return _then(_$RiskFactorImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as RiskLevel,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskFactorImpl implements _RiskFactor {
  const _$RiskFactorImpl(
      {required this.name,
      required this.level,
      required this.impact,
      required this.description});

  factory _$RiskFactorImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskFactorImplFromJson(json);

  @override
  final String name;
  @override
  final RiskLevel level;
  @override
  final double impact;
  @override
  final String description;

  @override
  String toString() {
    return 'RiskFactor(name: $name, level: $level, impact: $impact, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskFactorImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.impact, impact) || other.impact == impact) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, level, impact, description);

  /// Create a copy of RiskFactor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskFactorImplCopyWith<_$RiskFactorImpl> get copyWith =>
      __$$RiskFactorImplCopyWithImpl<_$RiskFactorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskFactorImplToJson(
      this,
    );
  }
}

abstract class _RiskFactor implements RiskFactor {
  const factory _RiskFactor(
      {required final String name,
      required final RiskLevel level,
      required final double impact,
      required final String description}) = _$RiskFactorImpl;

  factory _RiskFactor.fromJson(Map<String, dynamic> json) =
      _$RiskFactorImpl.fromJson;

  @override
  String get name;
  @override
  RiskLevel get level;
  @override
  double get impact;
  @override
  String get description;

  /// Create a copy of RiskFactor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskFactorImplCopyWith<_$RiskFactorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FinancialGoal _$FinancialGoalFromJson(Map<String, dynamic> json) {
  return _FinancialGoal.fromJson(json);
}

/// @nodoc
mixin _$FinancialGoal {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get targetAmount => throw _privateConstructorUsedError;
  double get currentAmount => throw _privateConstructorUsedError;
  DateTime get targetDate => throw _privateConstructorUsedError;
  GoalCategory get category => throw _privateConstructorUsedError;
  GoalPriority get priority => throw _privateConstructorUsedError;
  GoalStatus get status => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;
  DateTime? get lastSyncedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this FinancialGoal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FinancialGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FinancialGoalCopyWith<FinancialGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialGoalCopyWith<$Res> {
  factory $FinancialGoalCopyWith(
          FinancialGoal value, $Res Function(FinancialGoal) then) =
      _$FinancialGoalCopyWithImpl<$Res, FinancialGoal>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String description,
      double targetAmount,
      double currentAmount,
      DateTime targetDate,
      GoalCategory category,
      GoalPriority priority,
      GoalStatus status,
      bool isSynced,
      DateTime? lastSyncedAt,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$FinancialGoalCopyWithImpl<$Res, $Val extends FinancialGoal>
    implements $FinancialGoalCopyWith<$Res> {
  _$FinancialGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FinancialGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? targetAmount = null,
    Object? currentAmount = null,
    Object? targetDate = null,
    Object? category = null,
    Object? priority = null,
    Object? status = null,
    Object? isSynced = null,
    Object? lastSyncedAt = freezed,
    Object? metadata = null,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      targetAmount: null == targetAmount
          ? _value.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      currentAmount: null == currentAmount
          ? _value.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as GoalCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as GoalPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GoalStatus,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinancialGoalImplCopyWith<$Res>
    implements $FinancialGoalCopyWith<$Res> {
  factory _$$FinancialGoalImplCopyWith(
          _$FinancialGoalImpl value, $Res Function(_$FinancialGoalImpl) then) =
      __$$FinancialGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String description,
      double targetAmount,
      double currentAmount,
      DateTime targetDate,
      GoalCategory category,
      GoalPriority priority,
      GoalStatus status,
      bool isSynced,
      DateTime? lastSyncedAt,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$FinancialGoalImplCopyWithImpl<$Res>
    extends _$FinancialGoalCopyWithImpl<$Res, _$FinancialGoalImpl>
    implements _$$FinancialGoalImplCopyWith<$Res> {
  __$$FinancialGoalImplCopyWithImpl(
      _$FinancialGoalImpl _value, $Res Function(_$FinancialGoalImpl) _then)
      : super(_value, _then);

  /// Create a copy of FinancialGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? targetAmount = null,
    Object? currentAmount = null,
    Object? targetDate = null,
    Object? category = null,
    Object? priority = null,
    Object? status = null,
    Object? isSynced = null,
    Object? lastSyncedAt = freezed,
    Object? metadata = null,
  }) {
    return _then(_$FinancialGoalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      targetAmount: null == targetAmount
          ? _value.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      currentAmount: null == currentAmount
          ? _value.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as GoalCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as GoalPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GoalStatus,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialGoalImpl implements _FinancialGoal {
  const _$FinancialGoalImpl(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.targetAmount,
      required this.currentAmount,
      required this.targetDate,
      required this.category,
      required this.priority,
      this.status = GoalStatus.active,
      this.isSynced = false,
      this.lastSyncedAt,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$FinancialGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialGoalImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String description;
  @override
  final double targetAmount;
  @override
  final double currentAmount;
  @override
  final DateTime targetDate;
  @override
  final GoalCategory category;
  @override
  final GoalPriority priority;
  @override
  @JsonKey()
  final GoalStatus status;
  @override
  @JsonKey()
  final bool isSynced;
  @override
  final DateTime? lastSyncedAt;
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
    return 'FinancialGoal(id: $id, userId: $userId, title: $title, description: $description, targetAmount: $targetAmount, currentAmount: $currentAmount, targetDate: $targetDate, category: $category, priority: $priority, status: $status, isSynced: $isSynced, lastSyncedAt: $lastSyncedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialGoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.currentAmount, currentAmount) ||
                other.currentAmount == currentAmount) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      description,
      targetAmount,
      currentAmount,
      targetDate,
      category,
      priority,
      status,
      isSynced,
      lastSyncedAt,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of FinancialGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialGoalImplCopyWith<_$FinancialGoalImpl> get copyWith =>
      __$$FinancialGoalImplCopyWithImpl<_$FinancialGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FinancialGoalImplToJson(
      this,
    );
  }
}

abstract class _FinancialGoal implements FinancialGoal {
  const factory _FinancialGoal(
      {required final String id,
      required final String userId,
      required final String title,
      required final String description,
      required final double targetAmount,
      required final double currentAmount,
      required final DateTime targetDate,
      required final GoalCategory category,
      required final GoalPriority priority,
      final GoalStatus status,
      final bool isSynced,
      final DateTime? lastSyncedAt,
      final Map<String, dynamic> metadata}) = _$FinancialGoalImpl;

  factory _FinancialGoal.fromJson(Map<String, dynamic> json) =
      _$FinancialGoalImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get description;
  @override
  double get targetAmount;
  @override
  double get currentAmount;
  @override
  DateTime get targetDate;
  @override
  GoalCategory get category;
  @override
  GoalPriority get priority;
  @override
  GoalStatus get status;
  @override
  bool get isSynced;
  @override
  DateTime? get lastSyncedAt;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of FinancialGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FinancialGoalImplCopyWith<_$FinancialGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
