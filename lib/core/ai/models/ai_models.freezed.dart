// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AIRecommendation _$AIRecommendationFromJson(Map<String, dynamic> json) {
  return _AIRecommendation.fromJson(json);
}

/// @nodoc
mixin _$AIRecommendation {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  RecommendationType get type => throw _privateConstructorUsedError;
  ConfidenceLevel get confidence => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  String? get actionUrl => throw _privateConstructorUsedError;
  bool? get isPersonalized => throw _privateConstructorUsedError;
  List<String> get reasons => throw _privateConstructorUsedError;

  /// Serializes this AIRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIRecommendationCopyWith<AIRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIRecommendationCopyWith<$Res> {
  factory $AIRecommendationCopyWith(
          AIRecommendation value, $Res Function(AIRecommendation) then) =
      _$AIRecommendationCopyWithImpl<$Res, AIRecommendation>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      RecommendationType type,
      ConfidenceLevel confidence,
      double score,
      List<String> tags,
      Map<String, dynamic> metadata,
      DateTime createdAt,
      DateTime? expiresAt,
      String? actionUrl,
      bool? isPersonalized,
      List<String> reasons});
}

/// @nodoc
class _$AIRecommendationCopyWithImpl<$Res, $Val extends AIRecommendation>
    implements $AIRecommendationCopyWith<$Res> {
  _$AIRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? confidence = null,
    Object? score = null,
    Object? tags = null,
    Object? metadata = null,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? actionUrl = freezed,
    Object? isPersonalized = freezed,
    Object? reasons = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecommendationType,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as ConfidenceLevel,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isPersonalized: freezed == isPersonalized
          ? _value.isPersonalized
          : isPersonalized // ignore: cast_nullable_to_non_nullable
              as bool?,
      reasons: null == reasons
          ? _value.reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIRecommendationImplCopyWith<$Res>
    implements $AIRecommendationCopyWith<$Res> {
  factory _$$AIRecommendationImplCopyWith(_$AIRecommendationImpl value,
          $Res Function(_$AIRecommendationImpl) then) =
      __$$AIRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      RecommendationType type,
      ConfidenceLevel confidence,
      double score,
      List<String> tags,
      Map<String, dynamic> metadata,
      DateTime createdAt,
      DateTime? expiresAt,
      String? actionUrl,
      bool? isPersonalized,
      List<String> reasons});
}

/// @nodoc
class __$$AIRecommendationImplCopyWithImpl<$Res>
    extends _$AIRecommendationCopyWithImpl<$Res, _$AIRecommendationImpl>
    implements _$$AIRecommendationImplCopyWith<$Res> {
  __$$AIRecommendationImplCopyWithImpl(_$AIRecommendationImpl _value,
      $Res Function(_$AIRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? confidence = null,
    Object? score = null,
    Object? tags = null,
    Object? metadata = null,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? actionUrl = freezed,
    Object? isPersonalized = freezed,
    Object? reasons = null,
  }) {
    return _then(_$AIRecommendationImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecommendationType,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as ConfidenceLevel,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isPersonalized: freezed == isPersonalized
          ? _value.isPersonalized
          : isPersonalized // ignore: cast_nullable_to_non_nullable
              as bool?,
      reasons: null == reasons
          ? _value._reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIRecommendationImpl implements _AIRecommendation {
  const _$AIRecommendationImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.confidence,
      required this.score,
      required final List<String> tags,
      required final Map<String, dynamic> metadata,
      required this.createdAt,
      this.expiresAt,
      this.actionUrl,
      this.isPersonalized,
      final List<String> reasons = const []})
      : _tags = tags,
        _metadata = metadata,
        _reasons = reasons;

  factory _$AIRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIRecommendationImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final RecommendationType type;
  @override
  final ConfidenceLevel confidence;
  @override
  final double score;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final Map<String, dynamic> _metadata;
  @override
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? expiresAt;
  @override
  final String? actionUrl;
  @override
  final bool? isPersonalized;
  final List<String> _reasons;
  @override
  @JsonKey()
  List<String> get reasons {
    if (_reasons is EqualUnmodifiableListView) return _reasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reasons);
  }

  @override
  String toString() {
    return 'AIRecommendation(id: $id, title: $title, description: $description, type: $type, confidence: $confidence, score: $score, tags: $tags, metadata: $metadata, createdAt: $createdAt, expiresAt: $expiresAt, actionUrl: $actionUrl, isPersonalized: $isPersonalized, reasons: $reasons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.actionUrl, actionUrl) ||
                other.actionUrl == actionUrl) &&
            (identical(other.isPersonalized, isPersonalized) ||
                other.isPersonalized == isPersonalized) &&
            const DeepCollectionEquality().equals(other._reasons, _reasons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      type,
      confidence,
      score,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_metadata),
      createdAt,
      expiresAt,
      actionUrl,
      isPersonalized,
      const DeepCollectionEquality().hash(_reasons));

  /// Create a copy of AIRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIRecommendationImplCopyWith<_$AIRecommendationImpl> get copyWith =>
      __$$AIRecommendationImplCopyWithImpl<_$AIRecommendationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIRecommendationImplToJson(
      this,
    );
  }
}

abstract class _AIRecommendation implements AIRecommendation {
  const factory _AIRecommendation(
      {required final String id,
      required final String title,
      required final String description,
      required final RecommendationType type,
      required final ConfidenceLevel confidence,
      required final double score,
      required final List<String> tags,
      required final Map<String, dynamic> metadata,
      required final DateTime createdAt,
      final DateTime? expiresAt,
      final String? actionUrl,
      final bool? isPersonalized,
      final List<String> reasons}) = _$AIRecommendationImpl;

  factory _AIRecommendation.fromJson(Map<String, dynamic> json) =
      _$AIRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  RecommendationType get type;
  @override
  ConfidenceLevel get confidence;
  @override
  double get score;
  @override
  List<String> get tags;
  @override
  Map<String, dynamic> get metadata;
  @override
  DateTime get createdAt;
  @override
  DateTime? get expiresAt;
  @override
  String? get actionUrl;
  @override
  bool? get isPersonalized;
  @override
  List<String> get reasons;

  /// Create a copy of AIRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIRecommendationImplCopyWith<_$AIRecommendationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AIInsight _$AIInsightFromJson(Map<String, dynamic> json) {
  return _AIInsight.fromJson(json);
}

/// @nodoc
mixin _$AIInsight {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  InsightCategory get category => throw _privateConstructorUsedError;
  ConfidenceLevel get confidence => throw _privateConstructorUsedError;
  double get relevanceScore => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  List<String> get visualizations => throw _privateConstructorUsedError;
  List<AIRecommendation> get relatedRecommendations =>
      throw _privateConstructorUsedError;
  String? get sourceDataId => throw _privateConstructorUsedError;
  bool? get isActionable => throw _privateConstructorUsedError;

  /// Serializes this AIInsight to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIInsight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIInsightCopyWith<AIInsight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIInsightCopyWith<$Res> {
  factory $AIInsightCopyWith(AIInsight value, $Res Function(AIInsight) then) =
      _$AIInsightCopyWithImpl<$Res, AIInsight>;
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      InsightCategory category,
      ConfidenceLevel confidence,
      double relevanceScore,
      DateTime generatedAt,
      Map<String, dynamic> data,
      List<String> visualizations,
      List<AIRecommendation> relatedRecommendations,
      String? sourceDataId,
      bool? isActionable});
}

/// @nodoc
class _$AIInsightCopyWithImpl<$Res, $Val extends AIInsight>
    implements $AIInsightCopyWith<$Res> {
  _$AIInsightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIInsight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? category = null,
    Object? confidence = null,
    Object? relevanceScore = null,
    Object? generatedAt = null,
    Object? data = null,
    Object? visualizations = null,
    Object? relatedRecommendations = null,
    Object? sourceDataId = freezed,
    Object? isActionable = freezed,
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
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as InsightCategory,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as ConfidenceLevel,
      relevanceScore: null == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as double,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      visualizations: null == visualizations
          ? _value.visualizations
          : visualizations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      relatedRecommendations: null == relatedRecommendations
          ? _value.relatedRecommendations
          : relatedRecommendations // ignore: cast_nullable_to_non_nullable
              as List<AIRecommendation>,
      sourceDataId: freezed == sourceDataId
          ? _value.sourceDataId
          : sourceDataId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActionable: freezed == isActionable
          ? _value.isActionable
          : isActionable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIInsightImplCopyWith<$Res>
    implements $AIInsightCopyWith<$Res> {
  factory _$$AIInsightImplCopyWith(
          _$AIInsightImpl value, $Res Function(_$AIInsightImpl) then) =
      __$$AIInsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      InsightCategory category,
      ConfidenceLevel confidence,
      double relevanceScore,
      DateTime generatedAt,
      Map<String, dynamic> data,
      List<String> visualizations,
      List<AIRecommendation> relatedRecommendations,
      String? sourceDataId,
      bool? isActionable});
}

/// @nodoc
class __$$AIInsightImplCopyWithImpl<$Res>
    extends _$AIInsightCopyWithImpl<$Res, _$AIInsightImpl>
    implements _$$AIInsightImplCopyWith<$Res> {
  __$$AIInsightImplCopyWithImpl(
      _$AIInsightImpl _value, $Res Function(_$AIInsightImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIInsight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? category = null,
    Object? confidence = null,
    Object? relevanceScore = null,
    Object? generatedAt = null,
    Object? data = null,
    Object? visualizations = null,
    Object? relatedRecommendations = null,
    Object? sourceDataId = freezed,
    Object? isActionable = freezed,
  }) {
    return _then(_$AIInsightImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as InsightCategory,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as ConfidenceLevel,
      relevanceScore: null == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as double,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      visualizations: null == visualizations
          ? _value._visualizations
          : visualizations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      relatedRecommendations: null == relatedRecommendations
          ? _value._relatedRecommendations
          : relatedRecommendations // ignore: cast_nullable_to_non_nullable
              as List<AIRecommendation>,
      sourceDataId: freezed == sourceDataId
          ? _value.sourceDataId
          : sourceDataId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActionable: freezed == isActionable
          ? _value.isActionable
          : isActionable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIInsightImpl implements _AIInsight {
  const _$AIInsightImpl(
      {required this.id,
      required this.title,
      required this.content,
      required this.category,
      required this.confidence,
      required this.relevanceScore,
      required this.generatedAt,
      required final Map<String, dynamic> data,
      final List<String> visualizations = const [],
      final List<AIRecommendation> relatedRecommendations = const [],
      this.sourceDataId,
      this.isActionable})
      : _data = data,
        _visualizations = visualizations,
        _relatedRecommendations = relatedRecommendations;

  factory _$AIInsightImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIInsightImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final InsightCategory category;
  @override
  final ConfidenceLevel confidence;
  @override
  final double relevanceScore;
  @override
  final DateTime generatedAt;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  final List<String> _visualizations;
  @override
  @JsonKey()
  List<String> get visualizations {
    if (_visualizations is EqualUnmodifiableListView) return _visualizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visualizations);
  }

  final List<AIRecommendation> _relatedRecommendations;
  @override
  @JsonKey()
  List<AIRecommendation> get relatedRecommendations {
    if (_relatedRecommendations is EqualUnmodifiableListView)
      return _relatedRecommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedRecommendations);
  }

  @override
  final String? sourceDataId;
  @override
  final bool? isActionable;

  @override
  String toString() {
    return 'AIInsight(id: $id, title: $title, content: $content, category: $category, confidence: $confidence, relevanceScore: $relevanceScore, generatedAt: $generatedAt, data: $data, visualizations: $visualizations, relatedRecommendations: $relatedRecommendations, sourceDataId: $sourceDataId, isActionable: $isActionable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIInsightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.relevanceScore, relevanceScore) ||
                other.relevanceScore == relevanceScore) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality()
                .equals(other._visualizations, _visualizations) &&
            const DeepCollectionEquality().equals(
                other._relatedRecommendations, _relatedRecommendations) &&
            (identical(other.sourceDataId, sourceDataId) ||
                other.sourceDataId == sourceDataId) &&
            (identical(other.isActionable, isActionable) ||
                other.isActionable == isActionable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      content,
      category,
      confidence,
      relevanceScore,
      generatedAt,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_visualizations),
      const DeepCollectionEquality().hash(_relatedRecommendations),
      sourceDataId,
      isActionable);

  /// Create a copy of AIInsight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIInsightImplCopyWith<_$AIInsightImpl> get copyWith =>
      __$$AIInsightImplCopyWithImpl<_$AIInsightImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIInsightImplToJson(
      this,
    );
  }
}

abstract class _AIInsight implements AIInsight {
  const factory _AIInsight(
      {required final String id,
      required final String title,
      required final String content,
      required final InsightCategory category,
      required final ConfidenceLevel confidence,
      required final double relevanceScore,
      required final DateTime generatedAt,
      required final Map<String, dynamic> data,
      final List<String> visualizations,
      final List<AIRecommendation> relatedRecommendations,
      final String? sourceDataId,
      final bool? isActionable}) = _$AIInsightImpl;

  factory _AIInsight.fromJson(Map<String, dynamic> json) =
      _$AIInsightImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  InsightCategory get category;
  @override
  ConfidenceLevel get confidence;
  @override
  double get relevanceScore;
  @override
  DateTime get generatedAt;
  @override
  Map<String, dynamic> get data;
  @override
  List<String> get visualizations;
  @override
  List<AIRecommendation> get relatedRecommendations;
  @override
  String? get sourceDataId;
  @override
  bool? get isActionable;

  /// Create a copy of AIInsight
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIInsightImplCopyWith<_$AIInsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserBehaviorAnalytics _$UserBehaviorAnalyticsFromJson(
    Map<String, dynamic> json) {
  return _UserBehaviorAnalytics.fromJson(json);
}

/// @nodoc
mixin _$UserBehaviorAnalytics {
  String get userId => throw _privateConstructorUsedError;
  Map<String, int> get actionCounts => throw _privateConstructorUsedError;
  Map<String, double> get engagementScores =>
      throw _privateConstructorUsedError;
  List<String> get preferredCategories => throw _privateConstructorUsedError;
  Map<String, DateTime> get lastActivityTimes =>
      throw _privateConstructorUsedError;
  double get overallEngagementScore => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  Map<String, dynamic> get patterns => throw _privateConstructorUsedError;
  List<String> get interests => throw _privateConstructorUsedError;

  /// Serializes this UserBehaviorAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserBehaviorAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserBehaviorAnalyticsCopyWith<UserBehaviorAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserBehaviorAnalyticsCopyWith<$Res> {
  factory $UserBehaviorAnalyticsCopyWith(UserBehaviorAnalytics value,
          $Res Function(UserBehaviorAnalytics) then) =
      _$UserBehaviorAnalyticsCopyWithImpl<$Res, UserBehaviorAnalytics>;
  @useResult
  $Res call(
      {String userId,
      Map<String, int> actionCounts,
      Map<String, double> engagementScores,
      List<String> preferredCategories,
      Map<String, DateTime> lastActivityTimes,
      double overallEngagementScore,
      DateTime lastUpdated,
      Map<String, dynamic> patterns,
      List<String> interests});
}

/// @nodoc
class _$UserBehaviorAnalyticsCopyWithImpl<$Res,
        $Val extends UserBehaviorAnalytics>
    implements $UserBehaviorAnalyticsCopyWith<$Res> {
  _$UserBehaviorAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserBehaviorAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? actionCounts = null,
    Object? engagementScores = null,
    Object? preferredCategories = null,
    Object? lastActivityTimes = null,
    Object? overallEngagementScore = null,
    Object? lastUpdated = null,
    Object? patterns = null,
    Object? interests = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      actionCounts: null == actionCounts
          ? _value.actionCounts
          : actionCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      engagementScores: null == engagementScores
          ? _value.engagementScores
          : engagementScores // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      preferredCategories: null == preferredCategories
          ? _value.preferredCategories
          : preferredCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastActivityTimes: null == lastActivityTimes
          ? _value.lastActivityTimes
          : lastActivityTimes // ignore: cast_nullable_to_non_nullable
              as Map<String, DateTime>,
      overallEngagementScore: null == overallEngagementScore
          ? _value.overallEngagementScore
          : overallEngagementScore // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      patterns: null == patterns
          ? _value.patterns
          : patterns // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      interests: null == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserBehaviorAnalyticsImplCopyWith<$Res>
    implements $UserBehaviorAnalyticsCopyWith<$Res> {
  factory _$$UserBehaviorAnalyticsImplCopyWith(
          _$UserBehaviorAnalyticsImpl value,
          $Res Function(_$UserBehaviorAnalyticsImpl) then) =
      __$$UserBehaviorAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      Map<String, int> actionCounts,
      Map<String, double> engagementScores,
      List<String> preferredCategories,
      Map<String, DateTime> lastActivityTimes,
      double overallEngagementScore,
      DateTime lastUpdated,
      Map<String, dynamic> patterns,
      List<String> interests});
}

/// @nodoc
class __$$UserBehaviorAnalyticsImplCopyWithImpl<$Res>
    extends _$UserBehaviorAnalyticsCopyWithImpl<$Res,
        _$UserBehaviorAnalyticsImpl>
    implements _$$UserBehaviorAnalyticsImplCopyWith<$Res> {
  __$$UserBehaviorAnalyticsImplCopyWithImpl(_$UserBehaviorAnalyticsImpl _value,
      $Res Function(_$UserBehaviorAnalyticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserBehaviorAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? actionCounts = null,
    Object? engagementScores = null,
    Object? preferredCategories = null,
    Object? lastActivityTimes = null,
    Object? overallEngagementScore = null,
    Object? lastUpdated = null,
    Object? patterns = null,
    Object? interests = null,
  }) {
    return _then(_$UserBehaviorAnalyticsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      actionCounts: null == actionCounts
          ? _value._actionCounts
          : actionCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      engagementScores: null == engagementScores
          ? _value._engagementScores
          : engagementScores // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      preferredCategories: null == preferredCategories
          ? _value._preferredCategories
          : preferredCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastActivityTimes: null == lastActivityTimes
          ? _value._lastActivityTimes
          : lastActivityTimes // ignore: cast_nullable_to_non_nullable
              as Map<String, DateTime>,
      overallEngagementScore: null == overallEngagementScore
          ? _value.overallEngagementScore
          : overallEngagementScore // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      patterns: null == patterns
          ? _value._patterns
          : patterns // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      interests: null == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserBehaviorAnalyticsImpl implements _UserBehaviorAnalytics {
  const _$UserBehaviorAnalyticsImpl(
      {required this.userId,
      required final Map<String, int> actionCounts,
      required final Map<String, double> engagementScores,
      required final List<String> preferredCategories,
      required final Map<String, DateTime> lastActivityTimes,
      required this.overallEngagementScore,
      required this.lastUpdated,
      final Map<String, dynamic> patterns = const {},
      final List<String> interests = const []})
      : _actionCounts = actionCounts,
        _engagementScores = engagementScores,
        _preferredCategories = preferredCategories,
        _lastActivityTimes = lastActivityTimes,
        _patterns = patterns,
        _interests = interests;

  factory _$UserBehaviorAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserBehaviorAnalyticsImplFromJson(json);

  @override
  final String userId;
  final Map<String, int> _actionCounts;
  @override
  Map<String, int> get actionCounts {
    if (_actionCounts is EqualUnmodifiableMapView) return _actionCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_actionCounts);
  }

  final Map<String, double> _engagementScores;
  @override
  Map<String, double> get engagementScores {
    if (_engagementScores is EqualUnmodifiableMapView) return _engagementScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_engagementScores);
  }

  final List<String> _preferredCategories;
  @override
  List<String> get preferredCategories {
    if (_preferredCategories is EqualUnmodifiableListView)
      return _preferredCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredCategories);
  }

  final Map<String, DateTime> _lastActivityTimes;
  @override
  Map<String, DateTime> get lastActivityTimes {
    if (_lastActivityTimes is EqualUnmodifiableMapView)
      return _lastActivityTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lastActivityTimes);
  }

  @override
  final double overallEngagementScore;
  @override
  final DateTime lastUpdated;
  final Map<String, dynamic> _patterns;
  @override
  @JsonKey()
  Map<String, dynamic> get patterns {
    if (_patterns is EqualUnmodifiableMapView) return _patterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_patterns);
  }

  final List<String> _interests;
  @override
  @JsonKey()
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  @override
  String toString() {
    return 'UserBehaviorAnalytics(userId: $userId, actionCounts: $actionCounts, engagementScores: $engagementScores, preferredCategories: $preferredCategories, lastActivityTimes: $lastActivityTimes, overallEngagementScore: $overallEngagementScore, lastUpdated: $lastUpdated, patterns: $patterns, interests: $interests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserBehaviorAnalyticsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._actionCounts, _actionCounts) &&
            const DeepCollectionEquality()
                .equals(other._engagementScores, _engagementScores) &&
            const DeepCollectionEquality()
                .equals(other._preferredCategories, _preferredCategories) &&
            const DeepCollectionEquality()
                .equals(other._lastActivityTimes, _lastActivityTimes) &&
            (identical(other.overallEngagementScore, overallEngagementScore) ||
                other.overallEngagementScore == overallEngagementScore) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality().equals(other._patterns, _patterns) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      const DeepCollectionEquality().hash(_actionCounts),
      const DeepCollectionEquality().hash(_engagementScores),
      const DeepCollectionEquality().hash(_preferredCategories),
      const DeepCollectionEquality().hash(_lastActivityTimes),
      overallEngagementScore,
      lastUpdated,
      const DeepCollectionEquality().hash(_patterns),
      const DeepCollectionEquality().hash(_interests));

  /// Create a copy of UserBehaviorAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserBehaviorAnalyticsImplCopyWith<_$UserBehaviorAnalyticsImpl>
      get copyWith => __$$UserBehaviorAnalyticsImplCopyWithImpl<
          _$UserBehaviorAnalyticsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserBehaviorAnalyticsImplToJson(
      this,
    );
  }
}

abstract class _UserBehaviorAnalytics implements UserBehaviorAnalytics {
  const factory _UserBehaviorAnalytics(
      {required final String userId,
      required final Map<String, int> actionCounts,
      required final Map<String, double> engagementScores,
      required final List<String> preferredCategories,
      required final Map<String, DateTime> lastActivityTimes,
      required final double overallEngagementScore,
      required final DateTime lastUpdated,
      final Map<String, dynamic> patterns,
      final List<String> interests}) = _$UserBehaviorAnalyticsImpl;

  factory _UserBehaviorAnalytics.fromJson(Map<String, dynamic> json) =
      _$UserBehaviorAnalyticsImpl.fromJson;

  @override
  String get userId;
  @override
  Map<String, int> get actionCounts;
  @override
  Map<String, double> get engagementScores;
  @override
  List<String> get preferredCategories;
  @override
  Map<String, DateTime> get lastActivityTimes;
  @override
  double get overallEngagementScore;
  @override
  DateTime get lastUpdated;
  @override
  Map<String, dynamic> get patterns;
  @override
  List<String> get interests;

  /// Create a copy of UserBehaviorAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserBehaviorAnalyticsImplCopyWith<_$UserBehaviorAnalyticsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AIPrediction _$AIPredictionFromJson(Map<String, dynamic> json) {
  return _AIPrediction.fromJson(json);
}

/// @nodoc
mixin _$AIPrediction {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get probability => throw _privateConstructorUsedError;
  DateTime get predictedDate => throw _privateConstructorUsedError;
  Map<String, dynamic> get factors => throw _privateConstructorUsedError;
  ConfidenceLevel get confidence => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  Map<String, double> get alternativeOutcomes =>
      throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  bool? get isPositive => throw _privateConstructorUsedError;

  /// Serializes this AIPrediction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIPredictionCopyWith<AIPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIPredictionCopyWith<$Res> {
  factory $AIPredictionCopyWith(
          AIPrediction value, $Res Function(AIPrediction) then) =
      _$AIPredictionCopyWithImpl<$Res, AIPrediction>;
  @useResult
  $Res call(
      {String id,
      String type,
      String description,
      double probability,
      DateTime predictedDate,
      Map<String, dynamic> factors,
      ConfidenceLevel confidence,
      DateTime createdAt,
      Map<String, double> alternativeOutcomes,
      String? category,
      bool? isPositive});
}

/// @nodoc
class _$AIPredictionCopyWithImpl<$Res, $Val extends AIPrediction>
    implements $AIPredictionCopyWith<$Res> {
  _$AIPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? description = null,
    Object? probability = null,
    Object? predictedDate = null,
    Object? factors = null,
    Object? confidence = null,
    Object? createdAt = null,
    Object? alternativeOutcomes = null,
    Object? category = freezed,
    Object? isPositive = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      predictedDate: null == predictedDate
          ? _value.predictedDate
          : predictedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as ConfidenceLevel,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      alternativeOutcomes: null == alternativeOutcomes
          ? _value.alternativeOutcomes
          : alternativeOutcomes // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isPositive: freezed == isPositive
          ? _value.isPositive
          : isPositive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIPredictionImplCopyWith<$Res>
    implements $AIPredictionCopyWith<$Res> {
  factory _$$AIPredictionImplCopyWith(
          _$AIPredictionImpl value, $Res Function(_$AIPredictionImpl) then) =
      __$$AIPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String description,
      double probability,
      DateTime predictedDate,
      Map<String, dynamic> factors,
      ConfidenceLevel confidence,
      DateTime createdAt,
      Map<String, double> alternativeOutcomes,
      String? category,
      bool? isPositive});
}

/// @nodoc
class __$$AIPredictionImplCopyWithImpl<$Res>
    extends _$AIPredictionCopyWithImpl<$Res, _$AIPredictionImpl>
    implements _$$AIPredictionImplCopyWith<$Res> {
  __$$AIPredictionImplCopyWithImpl(
      _$AIPredictionImpl _value, $Res Function(_$AIPredictionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? description = null,
    Object? probability = null,
    Object? predictedDate = null,
    Object? factors = null,
    Object? confidence = null,
    Object? createdAt = null,
    Object? alternativeOutcomes = null,
    Object? category = freezed,
    Object? isPositive = freezed,
  }) {
    return _then(_$AIPredictionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      predictedDate: null == predictedDate
          ? _value.predictedDate
          : predictedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      factors: null == factors
          ? _value._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as ConfidenceLevel,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      alternativeOutcomes: null == alternativeOutcomes
          ? _value._alternativeOutcomes
          : alternativeOutcomes // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isPositive: freezed == isPositive
          ? _value.isPositive
          : isPositive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIPredictionImpl implements _AIPrediction {
  const _$AIPredictionImpl(
      {required this.id,
      required this.type,
      required this.description,
      required this.probability,
      required this.predictedDate,
      required final Map<String, dynamic> factors,
      required this.confidence,
      required this.createdAt,
      final Map<String, double> alternativeOutcomes = const {},
      this.category,
      this.isPositive})
      : _factors = factors,
        _alternativeOutcomes = alternativeOutcomes;

  factory _$AIPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIPredictionImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String description;
  @override
  final double probability;
  @override
  final DateTime predictedDate;
  final Map<String, dynamic> _factors;
  @override
  Map<String, dynamic> get factors {
    if (_factors is EqualUnmodifiableMapView) return _factors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_factors);
  }

  @override
  final ConfidenceLevel confidence;
  @override
  final DateTime createdAt;
  final Map<String, double> _alternativeOutcomes;
  @override
  @JsonKey()
  Map<String, double> get alternativeOutcomes {
    if (_alternativeOutcomes is EqualUnmodifiableMapView)
      return _alternativeOutcomes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_alternativeOutcomes);
  }

  @override
  final String? category;
  @override
  final bool? isPositive;

  @override
  String toString() {
    return 'AIPrediction(id: $id, type: $type, description: $description, probability: $probability, predictedDate: $predictedDate, factors: $factors, confidence: $confidence, createdAt: $createdAt, alternativeOutcomes: $alternativeOutcomes, category: $category, isPositive: $isPositive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIPredictionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.predictedDate, predictedDate) ||
                other.predictedDate == predictedDate) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._alternativeOutcomes, _alternativeOutcomes) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isPositive, isPositive) ||
                other.isPositive == isPositive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      description,
      probability,
      predictedDate,
      const DeepCollectionEquality().hash(_factors),
      confidence,
      createdAt,
      const DeepCollectionEquality().hash(_alternativeOutcomes),
      category,
      isPositive);

  /// Create a copy of AIPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIPredictionImplCopyWith<_$AIPredictionImpl> get copyWith =>
      __$$AIPredictionImplCopyWithImpl<_$AIPredictionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIPredictionImplToJson(
      this,
    );
  }
}

abstract class _AIPrediction implements AIPrediction {
  const factory _AIPrediction(
      {required final String id,
      required final String type,
      required final String description,
      required final double probability,
      required final DateTime predictedDate,
      required final Map<String, dynamic> factors,
      required final ConfidenceLevel confidence,
      required final DateTime createdAt,
      final Map<String, double> alternativeOutcomes,
      final String? category,
      final bool? isPositive}) = _$AIPredictionImpl;

  factory _AIPrediction.fromJson(Map<String, dynamic> json) =
      _$AIPredictionImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get description;
  @override
  double get probability;
  @override
  DateTime get predictedDate;
  @override
  Map<String, dynamic> get factors;
  @override
  ConfidenceLevel get confidence;
  @override
  DateTime get createdAt;
  @override
  Map<String, double> get alternativeOutcomes;
  @override
  String? get category;
  @override
  bool? get isPositive;

  /// Create a copy of AIPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIPredictionImplCopyWith<_$AIPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AIChatMessage _$AIChatMessageFromJson(Map<String, dynamic> json) {
  return _AIChatMessage.fromJson(json);
}

/// @nodoc
mixin _$AIChatMessage {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get isUser => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<AIRecommendation> get recommendations =>
      throw _privateConstructorUsedError;
  List<AIInsight> get insights => throw _privateConstructorUsedError;
  String? get context => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this AIChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIChatMessageCopyWith<AIChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIChatMessageCopyWith<$Res> {
  factory $AIChatMessageCopyWith(
          AIChatMessage value, $Res Function(AIChatMessage) then) =
      _$AIChatMessageCopyWithImpl<$Res, AIChatMessage>;
  @useResult
  $Res call(
      {String id,
      String content,
      bool isUser,
      DateTime timestamp,
      List<AIRecommendation> recommendations,
      List<AIInsight> insights,
      String? context,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$AIChatMessageCopyWithImpl<$Res, $Val extends AIChatMessage>
    implements $AIChatMessageCopyWith<$Res> {
  _$AIChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? recommendations = null,
    Object? insights = null,
    Object? context = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isUser: null == isUser
          ? _value.isUser
          : isUser // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<AIRecommendation>,
      insights: null == insights
          ? _value.insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<AIInsight>,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIChatMessageImplCopyWith<$Res>
    implements $AIChatMessageCopyWith<$Res> {
  factory _$$AIChatMessageImplCopyWith(
          _$AIChatMessageImpl value, $Res Function(_$AIChatMessageImpl) then) =
      __$$AIChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String content,
      bool isUser,
      DateTime timestamp,
      List<AIRecommendation> recommendations,
      List<AIInsight> insights,
      String? context,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$AIChatMessageImplCopyWithImpl<$Res>
    extends _$AIChatMessageCopyWithImpl<$Res, _$AIChatMessageImpl>
    implements _$$AIChatMessageImplCopyWith<$Res> {
  __$$AIChatMessageImplCopyWithImpl(
      _$AIChatMessageImpl _value, $Res Function(_$AIChatMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? recommendations = null,
    Object? insights = null,
    Object? context = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$AIChatMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isUser: null == isUser
          ? _value.isUser
          : isUser // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<AIRecommendation>,
      insights: null == insights
          ? _value._insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<AIInsight>,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIChatMessageImpl implements _AIChatMessage {
  const _$AIChatMessageImpl(
      {required this.id,
      required this.content,
      required this.isUser,
      required this.timestamp,
      final List<AIRecommendation> recommendations = const [],
      final List<AIInsight> insights = const [],
      this.context,
      final Map<String, dynamic>? metadata})
      : _recommendations = recommendations,
        _insights = insights,
        _metadata = metadata;

  factory _$AIChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  final bool isUser;
  @override
  final DateTime timestamp;
  final List<AIRecommendation> _recommendations;
  @override
  @JsonKey()
  List<AIRecommendation> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  final List<AIInsight> _insights;
  @override
  @JsonKey()
  List<AIInsight> get insights {
    if (_insights is EqualUnmodifiableListView) return _insights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_insights);
  }

  @override
  final String? context;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AIChatMessage(id: $id, content: $content, isUser: $isUser, timestamp: $timestamp, recommendations: $recommendations, insights: $insights, context: $context, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isUser, isUser) || other.isUser == isUser) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            const DeepCollectionEquality().equals(other._insights, _insights) &&
            (identical(other.context, context) || other.context == context) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      content,
      isUser,
      timestamp,
      const DeepCollectionEquality().hash(_recommendations),
      const DeepCollectionEquality().hash(_insights),
      context,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of AIChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIChatMessageImplCopyWith<_$AIChatMessageImpl> get copyWith =>
      __$$AIChatMessageImplCopyWithImpl<_$AIChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIChatMessageImplToJson(
      this,
    );
  }
}

abstract class _AIChatMessage implements AIChatMessage {
  const factory _AIChatMessage(
      {required final String id,
      required final String content,
      required final bool isUser,
      required final DateTime timestamp,
      final List<AIRecommendation> recommendations,
      final List<AIInsight> insights,
      final String? context,
      final Map<String, dynamic>? metadata}) = _$AIChatMessageImpl;

  factory _AIChatMessage.fromJson(Map<String, dynamic> json) =
      _$AIChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  bool get isUser;
  @override
  DateTime get timestamp;
  @override
  List<AIRecommendation> get recommendations;
  @override
  List<AIInsight> get insights;
  @override
  String? get context;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of AIChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIChatMessageImplCopyWith<_$AIChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AIModelMetrics _$AIModelMetricsFromJson(Map<String, dynamic> json) {
  return _AIModelMetrics.fromJson(json);
}

/// @nodoc
mixin _$AIModelMetrics {
  String get modelId => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  double get precision => throw _privateConstructorUsedError;
  double get recall => throw _privateConstructorUsedError;
  double get f1Score => throw _privateConstructorUsedError;
  int get totalPredictions => throw _privateConstructorUsedError;
  int get correctPredictions => throw _privateConstructorUsedError;
  DateTime get lastEvaluated => throw _privateConstructorUsedError;
  Map<String, double> get categoryPerformance =>
      throw _privateConstructorUsedError;

  /// Serializes this AIModelMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIModelMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIModelMetricsCopyWith<AIModelMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIModelMetricsCopyWith<$Res> {
  factory $AIModelMetricsCopyWith(
          AIModelMetrics value, $Res Function(AIModelMetrics) then) =
      _$AIModelMetricsCopyWithImpl<$Res, AIModelMetrics>;
  @useResult
  $Res call(
      {String modelId,
      double accuracy,
      double precision,
      double recall,
      double f1Score,
      int totalPredictions,
      int correctPredictions,
      DateTime lastEvaluated,
      Map<String, double> categoryPerformance});
}

/// @nodoc
class _$AIModelMetricsCopyWithImpl<$Res, $Val extends AIModelMetrics>
    implements $AIModelMetricsCopyWith<$Res> {
  _$AIModelMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIModelMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelId = null,
    Object? accuracy = null,
    Object? precision = null,
    Object? recall = null,
    Object? f1Score = null,
    Object? totalPredictions = null,
    Object? correctPredictions = null,
    Object? lastEvaluated = null,
    Object? categoryPerformance = null,
  }) {
    return _then(_value.copyWith(
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      precision: null == precision
          ? _value.precision
          : precision // ignore: cast_nullable_to_non_nullable
              as double,
      recall: null == recall
          ? _value.recall
          : recall // ignore: cast_nullable_to_non_nullable
              as double,
      f1Score: null == f1Score
          ? _value.f1Score
          : f1Score // ignore: cast_nullable_to_non_nullable
              as double,
      totalPredictions: null == totalPredictions
          ? _value.totalPredictions
          : totalPredictions // ignore: cast_nullable_to_non_nullable
              as int,
      correctPredictions: null == correctPredictions
          ? _value.correctPredictions
          : correctPredictions // ignore: cast_nullable_to_non_nullable
              as int,
      lastEvaluated: null == lastEvaluated
          ? _value.lastEvaluated
          : lastEvaluated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryPerformance: null == categoryPerformance
          ? _value.categoryPerformance
          : categoryPerformance // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIModelMetricsImplCopyWith<$Res>
    implements $AIModelMetricsCopyWith<$Res> {
  factory _$$AIModelMetricsImplCopyWith(_$AIModelMetricsImpl value,
          $Res Function(_$AIModelMetricsImpl) then) =
      __$$AIModelMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String modelId,
      double accuracy,
      double precision,
      double recall,
      double f1Score,
      int totalPredictions,
      int correctPredictions,
      DateTime lastEvaluated,
      Map<String, double> categoryPerformance});
}

/// @nodoc
class __$$AIModelMetricsImplCopyWithImpl<$Res>
    extends _$AIModelMetricsCopyWithImpl<$Res, _$AIModelMetricsImpl>
    implements _$$AIModelMetricsImplCopyWith<$Res> {
  __$$AIModelMetricsImplCopyWithImpl(
      _$AIModelMetricsImpl _value, $Res Function(_$AIModelMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIModelMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelId = null,
    Object? accuracy = null,
    Object? precision = null,
    Object? recall = null,
    Object? f1Score = null,
    Object? totalPredictions = null,
    Object? correctPredictions = null,
    Object? lastEvaluated = null,
    Object? categoryPerformance = null,
  }) {
    return _then(_$AIModelMetricsImpl(
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      precision: null == precision
          ? _value.precision
          : precision // ignore: cast_nullable_to_non_nullable
              as double,
      recall: null == recall
          ? _value.recall
          : recall // ignore: cast_nullable_to_non_nullable
              as double,
      f1Score: null == f1Score
          ? _value.f1Score
          : f1Score // ignore: cast_nullable_to_non_nullable
              as double,
      totalPredictions: null == totalPredictions
          ? _value.totalPredictions
          : totalPredictions // ignore: cast_nullable_to_non_nullable
              as int,
      correctPredictions: null == correctPredictions
          ? _value.correctPredictions
          : correctPredictions // ignore: cast_nullable_to_non_nullable
              as int,
      lastEvaluated: null == lastEvaluated
          ? _value.lastEvaluated
          : lastEvaluated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryPerformance: null == categoryPerformance
          ? _value._categoryPerformance
          : categoryPerformance // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIModelMetricsImpl implements _AIModelMetrics {
  const _$AIModelMetricsImpl(
      {required this.modelId,
      required this.accuracy,
      required this.precision,
      required this.recall,
      required this.f1Score,
      required this.totalPredictions,
      required this.correctPredictions,
      required this.lastEvaluated,
      final Map<String, double> categoryPerformance = const {}})
      : _categoryPerformance = categoryPerformance;

  factory _$AIModelMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIModelMetricsImplFromJson(json);

  @override
  final String modelId;
  @override
  final double accuracy;
  @override
  final double precision;
  @override
  final double recall;
  @override
  final double f1Score;
  @override
  final int totalPredictions;
  @override
  final int correctPredictions;
  @override
  final DateTime lastEvaluated;
  final Map<String, double> _categoryPerformance;
  @override
  @JsonKey()
  Map<String, double> get categoryPerformance {
    if (_categoryPerformance is EqualUnmodifiableMapView)
      return _categoryPerformance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryPerformance);
  }

  @override
  String toString() {
    return 'AIModelMetrics(modelId: $modelId, accuracy: $accuracy, precision: $precision, recall: $recall, f1Score: $f1Score, totalPredictions: $totalPredictions, correctPredictions: $correctPredictions, lastEvaluated: $lastEvaluated, categoryPerformance: $categoryPerformance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIModelMetricsImpl &&
            (identical(other.modelId, modelId) || other.modelId == modelId) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.precision, precision) ||
                other.precision == precision) &&
            (identical(other.recall, recall) || other.recall == recall) &&
            (identical(other.f1Score, f1Score) || other.f1Score == f1Score) &&
            (identical(other.totalPredictions, totalPredictions) ||
                other.totalPredictions == totalPredictions) &&
            (identical(other.correctPredictions, correctPredictions) ||
                other.correctPredictions == correctPredictions) &&
            (identical(other.lastEvaluated, lastEvaluated) ||
                other.lastEvaluated == lastEvaluated) &&
            const DeepCollectionEquality()
                .equals(other._categoryPerformance, _categoryPerformance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      modelId,
      accuracy,
      precision,
      recall,
      f1Score,
      totalPredictions,
      correctPredictions,
      lastEvaluated,
      const DeepCollectionEquality().hash(_categoryPerformance));

  /// Create a copy of AIModelMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIModelMetricsImplCopyWith<_$AIModelMetricsImpl> get copyWith =>
      __$$AIModelMetricsImplCopyWithImpl<_$AIModelMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIModelMetricsImplToJson(
      this,
    );
  }
}

abstract class _AIModelMetrics implements AIModelMetrics {
  const factory _AIModelMetrics(
      {required final String modelId,
      required final double accuracy,
      required final double precision,
      required final double recall,
      required final double f1Score,
      required final int totalPredictions,
      required final int correctPredictions,
      required final DateTime lastEvaluated,
      final Map<String, double> categoryPerformance}) = _$AIModelMetricsImpl;

  factory _AIModelMetrics.fromJson(Map<String, dynamic> json) =
      _$AIModelMetricsImpl.fromJson;

  @override
  String get modelId;
  @override
  double get accuracy;
  @override
  double get precision;
  @override
  double get recall;
  @override
  double get f1Score;
  @override
  int get totalPredictions;
  @override
  int get correctPredictions;
  @override
  DateTime get lastEvaluated;
  @override
  Map<String, double> get categoryPerformance;

  /// Create a copy of AIModelMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIModelMetricsImplCopyWith<_$AIModelMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AIConfiguration _$AIConfigurationFromJson(Map<String, dynamic> json) {
  return _AIConfiguration.fromJson(json);
}

/// @nodoc
mixin _$AIConfiguration {
  String get userId => throw _privateConstructorUsedError;
  bool get enablePersonalization => throw _privateConstructorUsedError;
  bool get enablePredictions => throw _privateConstructorUsedError;
  bool get enableRecommendations => throw _privateConstructorUsedError;
  double get confidenceThreshold => throw _privateConstructorUsedError;
  List<String> get enabledCategories => throw _privateConstructorUsedError;
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  bool get enableLearning => throw _privateConstructorUsedError;
  double get relevanceThreshold => throw _privateConstructorUsedError;

  /// Serializes this AIConfiguration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIConfigurationCopyWith<AIConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIConfigurationCopyWith<$Res> {
  factory $AIConfigurationCopyWith(
          AIConfiguration value, $Res Function(AIConfiguration) then) =
      _$AIConfigurationCopyWithImpl<$Res, AIConfiguration>;
  @useResult
  $Res call(
      {String userId,
      bool enablePersonalization,
      bool enablePredictions,
      bool enableRecommendations,
      double confidenceThreshold,
      List<String> enabledCategories,
      Map<String, dynamic> preferences,
      DateTime lastUpdated,
      bool enableLearning,
      double relevanceThreshold});
}

/// @nodoc
class _$AIConfigurationCopyWithImpl<$Res, $Val extends AIConfiguration>
    implements $AIConfigurationCopyWith<$Res> {
  _$AIConfigurationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? enablePersonalization = null,
    Object? enablePredictions = null,
    Object? enableRecommendations = null,
    Object? confidenceThreshold = null,
    Object? enabledCategories = null,
    Object? preferences = null,
    Object? lastUpdated = null,
    Object? enableLearning = null,
    Object? relevanceThreshold = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      enablePersonalization: null == enablePersonalization
          ? _value.enablePersonalization
          : enablePersonalization // ignore: cast_nullable_to_non_nullable
              as bool,
      enablePredictions: null == enablePredictions
          ? _value.enablePredictions
          : enablePredictions // ignore: cast_nullable_to_non_nullable
              as bool,
      enableRecommendations: null == enableRecommendations
          ? _value.enableRecommendations
          : enableRecommendations // ignore: cast_nullable_to_non_nullable
              as bool,
      confidenceThreshold: null == confidenceThreshold
          ? _value.confidenceThreshold
          : confidenceThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      enabledCategories: null == enabledCategories
          ? _value.enabledCategories
          : enabledCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      enableLearning: null == enableLearning
          ? _value.enableLearning
          : enableLearning // ignore: cast_nullable_to_non_nullable
              as bool,
      relevanceThreshold: null == relevanceThreshold
          ? _value.relevanceThreshold
          : relevanceThreshold // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIConfigurationImplCopyWith<$Res>
    implements $AIConfigurationCopyWith<$Res> {
  factory _$$AIConfigurationImplCopyWith(_$AIConfigurationImpl value,
          $Res Function(_$AIConfigurationImpl) then) =
      __$$AIConfigurationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      bool enablePersonalization,
      bool enablePredictions,
      bool enableRecommendations,
      double confidenceThreshold,
      List<String> enabledCategories,
      Map<String, dynamic> preferences,
      DateTime lastUpdated,
      bool enableLearning,
      double relevanceThreshold});
}

/// @nodoc
class __$$AIConfigurationImplCopyWithImpl<$Res>
    extends _$AIConfigurationCopyWithImpl<$Res, _$AIConfigurationImpl>
    implements _$$AIConfigurationImplCopyWith<$Res> {
  __$$AIConfigurationImplCopyWithImpl(
      _$AIConfigurationImpl _value, $Res Function(_$AIConfigurationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? enablePersonalization = null,
    Object? enablePredictions = null,
    Object? enableRecommendations = null,
    Object? confidenceThreshold = null,
    Object? enabledCategories = null,
    Object? preferences = null,
    Object? lastUpdated = null,
    Object? enableLearning = null,
    Object? relevanceThreshold = null,
  }) {
    return _then(_$AIConfigurationImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      enablePersonalization: null == enablePersonalization
          ? _value.enablePersonalization
          : enablePersonalization // ignore: cast_nullable_to_non_nullable
              as bool,
      enablePredictions: null == enablePredictions
          ? _value.enablePredictions
          : enablePredictions // ignore: cast_nullable_to_non_nullable
              as bool,
      enableRecommendations: null == enableRecommendations
          ? _value.enableRecommendations
          : enableRecommendations // ignore: cast_nullable_to_non_nullable
              as bool,
      confidenceThreshold: null == confidenceThreshold
          ? _value.confidenceThreshold
          : confidenceThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      enabledCategories: null == enabledCategories
          ? _value._enabledCategories
          : enabledCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferences: null == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      enableLearning: null == enableLearning
          ? _value.enableLearning
          : enableLearning // ignore: cast_nullable_to_non_nullable
              as bool,
      relevanceThreshold: null == relevanceThreshold
          ? _value.relevanceThreshold
          : relevanceThreshold // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIConfigurationImpl implements _AIConfiguration {
  const _$AIConfigurationImpl(
      {required this.userId,
      required this.enablePersonalization,
      required this.enablePredictions,
      required this.enableRecommendations,
      required this.confidenceThreshold,
      required final List<String> enabledCategories,
      required final Map<String, dynamic> preferences,
      required this.lastUpdated,
      this.enableLearning = true,
      this.relevanceThreshold = 0.7})
      : _enabledCategories = enabledCategories,
        _preferences = preferences;

  factory _$AIConfigurationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIConfigurationImplFromJson(json);

  @override
  final String userId;
  @override
  final bool enablePersonalization;
  @override
  final bool enablePredictions;
  @override
  final bool enableRecommendations;
  @override
  final double confidenceThreshold;
  final List<String> _enabledCategories;
  @override
  List<String> get enabledCategories {
    if (_enabledCategories is EqualUnmodifiableListView)
      return _enabledCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_enabledCategories);
  }

  final Map<String, dynamic> _preferences;
  @override
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  @override
  final DateTime lastUpdated;
  @override
  @JsonKey()
  final bool enableLearning;
  @override
  @JsonKey()
  final double relevanceThreshold;

  @override
  String toString() {
    return 'AIConfiguration(userId: $userId, enablePersonalization: $enablePersonalization, enablePredictions: $enablePredictions, enableRecommendations: $enableRecommendations, confidenceThreshold: $confidenceThreshold, enabledCategories: $enabledCategories, preferences: $preferences, lastUpdated: $lastUpdated, enableLearning: $enableLearning, relevanceThreshold: $relevanceThreshold)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIConfigurationImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.enablePersonalization, enablePersonalization) ||
                other.enablePersonalization == enablePersonalization) &&
            (identical(other.enablePredictions, enablePredictions) ||
                other.enablePredictions == enablePredictions) &&
            (identical(other.enableRecommendations, enableRecommendations) ||
                other.enableRecommendations == enableRecommendations) &&
            (identical(other.confidenceThreshold, confidenceThreshold) ||
                other.confidenceThreshold == confidenceThreshold) &&
            const DeepCollectionEquality()
                .equals(other._enabledCategories, _enabledCategories) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.enableLearning, enableLearning) ||
                other.enableLearning == enableLearning) &&
            (identical(other.relevanceThreshold, relevanceThreshold) ||
                other.relevanceThreshold == relevanceThreshold));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      enablePersonalization,
      enablePredictions,
      enableRecommendations,
      confidenceThreshold,
      const DeepCollectionEquality().hash(_enabledCategories),
      const DeepCollectionEquality().hash(_preferences),
      lastUpdated,
      enableLearning,
      relevanceThreshold);

  /// Create a copy of AIConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIConfigurationImplCopyWith<_$AIConfigurationImpl> get copyWith =>
      __$$AIConfigurationImplCopyWithImpl<_$AIConfigurationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIConfigurationImplToJson(
      this,
    );
  }
}

abstract class _AIConfiguration implements AIConfiguration {
  const factory _AIConfiguration(
      {required final String userId,
      required final bool enablePersonalization,
      required final bool enablePredictions,
      required final bool enableRecommendations,
      required final double confidenceThreshold,
      required final List<String> enabledCategories,
      required final Map<String, dynamic> preferences,
      required final DateTime lastUpdated,
      final bool enableLearning,
      final double relevanceThreshold}) = _$AIConfigurationImpl;

  factory _AIConfiguration.fromJson(Map<String, dynamic> json) =
      _$AIConfigurationImpl.fromJson;

  @override
  String get userId;
  @override
  bool get enablePersonalization;
  @override
  bool get enablePredictions;
  @override
  bool get enableRecommendations;
  @override
  double get confidenceThreshold;
  @override
  List<String> get enabledCategories;
  @override
  Map<String, dynamic> get preferences;
  @override
  DateTime get lastUpdated;
  @override
  bool get enableLearning;
  @override
  double get relevanceThreshold;

  /// Create a copy of AIConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIConfigurationImplCopyWith<_$AIConfigurationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
