// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LessonProgress _$LessonProgressFromJson(Map<String, dynamic> json) {
  return _LessonProgress.fromJson(json);
}

/// @nodoc
mixin _$LessonProgress {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get moduleId => throw _privateConstructorUsedError;
  String get category =>
      throw _privateConstructorUsedError; // 'health' or 'wealth'
  bool get completed => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int get totalLessons => throw _privateConstructorUsedError;
  int get completedLessons => throw _privateConstructorUsedError;
  double get progressPercentage => throw _privateConstructorUsedError;

  /// Serializes this LessonProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonProgressCopyWith<LessonProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonProgressCopyWith<$Res> {
  factory $LessonProgressCopyWith(
          LessonProgress value, $Res Function(LessonProgress) then) =
      _$LessonProgressCopyWithImpl<$Res, LessonProgress>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String moduleId,
      String category,
      bool completed,
      DateTime startedAt,
      DateTime? completedAt,
      int totalLessons,
      int completedLessons,
      double progressPercentage});
}

/// @nodoc
class _$LessonProgressCopyWithImpl<$Res, $Val extends LessonProgress>
    implements $LessonProgressCopyWith<$Res> {
  _$LessonProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? moduleId = null,
    Object? category = null,
    Object? completed = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? totalLessons = null,
    Object? completedLessons = null,
    Object? progressPercentage = null,
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
      moduleId: null == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalLessons: null == totalLessons
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LessonProgressImplCopyWith<$Res>
    implements $LessonProgressCopyWith<$Res> {
  factory _$$LessonProgressImplCopyWith(_$LessonProgressImpl value,
          $Res Function(_$LessonProgressImpl) then) =
      __$$LessonProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String moduleId,
      String category,
      bool completed,
      DateTime startedAt,
      DateTime? completedAt,
      int totalLessons,
      int completedLessons,
      double progressPercentage});
}

/// @nodoc
class __$$LessonProgressImplCopyWithImpl<$Res>
    extends _$LessonProgressCopyWithImpl<$Res, _$LessonProgressImpl>
    implements _$$LessonProgressImplCopyWith<$Res> {
  __$$LessonProgressImplCopyWithImpl(
      _$LessonProgressImpl _value, $Res Function(_$LessonProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? moduleId = null,
    Object? category = null,
    Object? completed = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? totalLessons = null,
    Object? completedLessons = null,
    Object? progressPercentage = null,
  }) {
    return _then(_$LessonProgressImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      moduleId: null == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalLessons: null == totalLessons
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonProgressImpl implements _LessonProgress {
  const _$LessonProgressImpl(
      {required this.id,
      required this.userId,
      required this.moduleId,
      required this.category,
      required this.completed,
      required this.startedAt,
      this.completedAt,
      required this.totalLessons,
      required this.completedLessons,
      required this.progressPercentage});

  factory _$LessonProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonProgressImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String moduleId;
  @override
  final String category;
// 'health' or 'wealth'
  @override
  final bool completed;
  @override
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  final int totalLessons;
  @override
  final int completedLessons;
  @override
  final double progressPercentage;

  @override
  String toString() {
    return 'LessonProgress(id: $id, userId: $userId, moduleId: $moduleId, category: $category, completed: $completed, startedAt: $startedAt, completedAt: $completedAt, totalLessons: $totalLessons, completedLessons: $completedLessons, progressPercentage: $progressPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonProgressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.moduleId, moduleId) ||
                other.moduleId == moduleId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.totalLessons, totalLessons) ||
                other.totalLessons == totalLessons) &&
            (identical(other.completedLessons, completedLessons) ||
                other.completedLessons == completedLessons) &&
            (identical(other.progressPercentage, progressPercentage) ||
                other.progressPercentage == progressPercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      moduleId,
      category,
      completed,
      startedAt,
      completedAt,
      totalLessons,
      completedLessons,
      progressPercentage);

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonProgressImplCopyWith<_$LessonProgressImpl> get copyWith =>
      __$$LessonProgressImplCopyWithImpl<_$LessonProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonProgressImplToJson(
      this,
    );
  }
}

abstract class _LessonProgress implements LessonProgress {
  const factory _LessonProgress(
      {required final String id,
      required final String userId,
      required final String moduleId,
      required final String category,
      required final bool completed,
      required final DateTime startedAt,
      final DateTime? completedAt,
      required final int totalLessons,
      required final int completedLessons,
      required final double progressPercentage}) = _$LessonProgressImpl;

  factory _LessonProgress.fromJson(Map<String, dynamic> json) =
      _$LessonProgressImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get moduleId;
  @override
  String get category; // 'health' or 'wealth'
  @override
  bool get completed;
  @override
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  int get totalLessons;
  @override
  int get completedLessons;
  @override
  double get progressPercentage;

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonProgressImplCopyWith<_$LessonProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizResult _$QuizResultFromJson(Map<String, dynamic> json) {
  return _QuizResult.fromJson(json);
}

/// @nodoc
mixin _$QuizResult {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get moduleId => throw _privateConstructorUsedError;
  String get category =>
      throw _privateConstructorUsedError; // 'health' or 'wealth'
  int get score => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  DateTime get completedAt => throw _privateConstructorUsedError;
  List<QuizAnswer> get answers => throw _privateConstructorUsedError;
  bool get passed => throw _privateConstructorUsedError;

  /// Serializes this QuizResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizResultCopyWith<QuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizResultCopyWith<$Res> {
  factory $QuizResultCopyWith(
          QuizResult value, $Res Function(QuizResult) then) =
      _$QuizResultCopyWithImpl<$Res, QuizResult>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String moduleId,
      String category,
      int score,
      int totalQuestions,
      double percentage,
      DateTime completedAt,
      List<QuizAnswer> answers,
      bool passed});
}

/// @nodoc
class _$QuizResultCopyWithImpl<$Res, $Val extends QuizResult>
    implements $QuizResultCopyWith<$Res> {
  _$QuizResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? moduleId = null,
    Object? category = null,
    Object? score = null,
    Object? totalQuestions = null,
    Object? percentage = null,
    Object? completedAt = null,
    Object? answers = null,
    Object? passed = null,
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
      moduleId: null == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<QuizAnswer>,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizResultImplCopyWith<$Res>
    implements $QuizResultCopyWith<$Res> {
  factory _$$QuizResultImplCopyWith(
          _$QuizResultImpl value, $Res Function(_$QuizResultImpl) then) =
      __$$QuizResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String moduleId,
      String category,
      int score,
      int totalQuestions,
      double percentage,
      DateTime completedAt,
      List<QuizAnswer> answers,
      bool passed});
}

/// @nodoc
class __$$QuizResultImplCopyWithImpl<$Res>
    extends _$QuizResultCopyWithImpl<$Res, _$QuizResultImpl>
    implements _$$QuizResultImplCopyWith<$Res> {
  __$$QuizResultImplCopyWithImpl(
      _$QuizResultImpl _value, $Res Function(_$QuizResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? moduleId = null,
    Object? category = null,
    Object? score = null,
    Object? totalQuestions = null,
    Object? percentage = null,
    Object? completedAt = null,
    Object? answers = null,
    Object? passed = null,
  }) {
    return _then(_$QuizResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      moduleId: null == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<QuizAnswer>,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizResultImpl implements _QuizResult {
  const _$QuizResultImpl(
      {required this.id,
      required this.userId,
      required this.moduleId,
      required this.category,
      required this.score,
      required this.totalQuestions,
      required this.percentage,
      required this.completedAt,
      required final List<QuizAnswer> answers,
      required this.passed})
      : _answers = answers;

  factory _$QuizResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizResultImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String moduleId;
  @override
  final String category;
// 'health' or 'wealth'
  @override
  final int score;
  @override
  final int totalQuestions;
  @override
  final double percentage;
  @override
  final DateTime completedAt;
  final List<QuizAnswer> _answers;
  @override
  List<QuizAnswer> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  final bool passed;

  @override
  String toString() {
    return 'QuizResult(id: $id, userId: $userId, moduleId: $moduleId, category: $category, score: $score, totalQuestions: $totalQuestions, percentage: $percentage, completedAt: $completedAt, answers: $answers, passed: $passed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.moduleId, moduleId) ||
                other.moduleId == moduleId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.passed, passed) || other.passed == passed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      moduleId,
      category,
      score,
      totalQuestions,
      percentage,
      completedAt,
      const DeepCollectionEquality().hash(_answers),
      passed);

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizResultImplCopyWith<_$QuizResultImpl> get copyWith =>
      __$$QuizResultImplCopyWithImpl<_$QuizResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizResultImplToJson(
      this,
    );
  }
}

abstract class _QuizResult implements QuizResult {
  const factory _QuizResult(
      {required final String id,
      required final String userId,
      required final String moduleId,
      required final String category,
      required final int score,
      required final int totalQuestions,
      required final double percentage,
      required final DateTime completedAt,
      required final List<QuizAnswer> answers,
      required final bool passed}) = _$QuizResultImpl;

  factory _QuizResult.fromJson(Map<String, dynamic> json) =
      _$QuizResultImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get moduleId;
  @override
  String get category; // 'health' or 'wealth'
  @override
  int get score;
  @override
  int get totalQuestions;
  @override
  double get percentage;
  @override
  DateTime get completedAt;
  @override
  List<QuizAnswer> get answers;
  @override
  bool get passed;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizResultImplCopyWith<_$QuizResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizAnswer _$QuizAnswerFromJson(Map<String, dynamic> json) {
  return _QuizAnswer.fromJson(json);
}

/// @nodoc
mixin _$QuizAnswer {
  int get questionIndex => throw _privateConstructorUsedError;
  int get selectedAnswer => throw _privateConstructorUsedError;
  int get correctAnswer => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;

  /// Serializes this QuizAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizAnswerCopyWith<QuizAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizAnswerCopyWith<$Res> {
  factory $QuizAnswerCopyWith(
          QuizAnswer value, $Res Function(QuizAnswer) then) =
      _$QuizAnswerCopyWithImpl<$Res, QuizAnswer>;
  @useResult
  $Res call(
      {int questionIndex,
      int selectedAnswer,
      int correctAnswer,
      bool isCorrect,
      String question,
      List<String> options,
      String explanation});
}

/// @nodoc
class _$QuizAnswerCopyWithImpl<$Res, $Val extends QuizAnswer>
    implements $QuizAnswerCopyWith<$Res> {
  _$QuizAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionIndex = null,
    Object? selectedAnswer = null,
    Object? correctAnswer = null,
    Object? isCorrect = null,
    Object? question = null,
    Object? options = null,
    Object? explanation = null,
  }) {
    return _then(_value.copyWith(
      questionIndex: null == questionIndex
          ? _value.questionIndex
          : questionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedAnswer: null == selectedAnswer
          ? _value.selectedAnswer
          : selectedAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizAnswerImplCopyWith<$Res>
    implements $QuizAnswerCopyWith<$Res> {
  factory _$$QuizAnswerImplCopyWith(
          _$QuizAnswerImpl value, $Res Function(_$QuizAnswerImpl) then) =
      __$$QuizAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int questionIndex,
      int selectedAnswer,
      int correctAnswer,
      bool isCorrect,
      String question,
      List<String> options,
      String explanation});
}

/// @nodoc
class __$$QuizAnswerImplCopyWithImpl<$Res>
    extends _$QuizAnswerCopyWithImpl<$Res, _$QuizAnswerImpl>
    implements _$$QuizAnswerImplCopyWith<$Res> {
  __$$QuizAnswerImplCopyWithImpl(
      _$QuizAnswerImpl _value, $Res Function(_$QuizAnswerImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionIndex = null,
    Object? selectedAnswer = null,
    Object? correctAnswer = null,
    Object? isCorrect = null,
    Object? question = null,
    Object? options = null,
    Object? explanation = null,
  }) {
    return _then(_$QuizAnswerImpl(
      questionIndex: null == questionIndex
          ? _value.questionIndex
          : questionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedAnswer: null == selectedAnswer
          ? _value.selectedAnswer
          : selectedAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizAnswerImpl implements _QuizAnswer {
  const _$QuizAnswerImpl(
      {required this.questionIndex,
      required this.selectedAnswer,
      required this.correctAnswer,
      required this.isCorrect,
      required this.question,
      required final List<String> options,
      required this.explanation})
      : _options = options;

  factory _$QuizAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizAnswerImplFromJson(json);

  @override
  final int questionIndex;
  @override
  final int selectedAnswer;
  @override
  final int correctAnswer;
  @override
  final bool isCorrect;
  @override
  final String question;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final String explanation;

  @override
  String toString() {
    return 'QuizAnswer(questionIndex: $questionIndex, selectedAnswer: $selectedAnswer, correctAnswer: $correctAnswer, isCorrect: $isCorrect, question: $question, options: $options, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizAnswerImpl &&
            (identical(other.questionIndex, questionIndex) ||
                other.questionIndex == questionIndex) &&
            (identical(other.selectedAnswer, selectedAnswer) ||
                other.selectedAnswer == selectedAnswer) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionIndex,
      selectedAnswer,
      correctAnswer,
      isCorrect,
      question,
      const DeepCollectionEquality().hash(_options),
      explanation);

  /// Create a copy of QuizAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizAnswerImplCopyWith<_$QuizAnswerImpl> get copyWith =>
      __$$QuizAnswerImplCopyWithImpl<_$QuizAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizAnswerImplToJson(
      this,
    );
  }
}

abstract class _QuizAnswer implements QuizAnswer {
  const factory _QuizAnswer(
      {required final int questionIndex,
      required final int selectedAnswer,
      required final int correctAnswer,
      required final bool isCorrect,
      required final String question,
      required final List<String> options,
      required final String explanation}) = _$QuizAnswerImpl;

  factory _QuizAnswer.fromJson(Map<String, dynamic> json) =
      _$QuizAnswerImpl.fromJson;

  @override
  int get questionIndex;
  @override
  int get selectedAnswer;
  @override
  int get correctAnswer;
  @override
  bool get isCorrect;
  @override
  String get question;
  @override
  List<String> get options;
  @override
  String get explanation;

  /// Create a copy of QuizAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizAnswerImplCopyWith<_$QuizAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ModuleProgress _$ModuleProgressFromJson(Map<String, dynamic> json) {
  return _ModuleProgress.fromJson(json);
}

/// @nodoc
mixin _$ModuleProgress {
  String get moduleId => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get lessonCompleted => throw _privateConstructorUsedError;
  bool get quizCompleted => throw _privateConstructorUsedError;
  bool get quizPassed => throw _privateConstructorUsedError;
  double get overallProgress =>
      throw _privateConstructorUsedError; // 0.0 to 1.0
  DateTime? get lessonCompletedAt => throw _privateConstructorUsedError;
  DateTime? get quizCompletedAt => throw _privateConstructorUsedError;
  QuizResult? get bestQuizResult => throw _privateConstructorUsedError;

  /// Serializes this ModuleProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModuleProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModuleProgressCopyWith<ModuleProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModuleProgressCopyWith<$Res> {
  factory $ModuleProgressCopyWith(
          ModuleProgress value, $Res Function(ModuleProgress) then) =
      _$ModuleProgressCopyWithImpl<$Res, ModuleProgress>;
  @useResult
  $Res call(
      {String moduleId,
      String category,
      String title,
      bool lessonCompleted,
      bool quizCompleted,
      bool quizPassed,
      double overallProgress,
      DateTime? lessonCompletedAt,
      DateTime? quizCompletedAt,
      QuizResult? bestQuizResult});

  $QuizResultCopyWith<$Res>? get bestQuizResult;
}

/// @nodoc
class _$ModuleProgressCopyWithImpl<$Res, $Val extends ModuleProgress>
    implements $ModuleProgressCopyWith<$Res> {
  _$ModuleProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModuleProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? moduleId = null,
    Object? category = null,
    Object? title = null,
    Object? lessonCompleted = null,
    Object? quizCompleted = null,
    Object? quizPassed = null,
    Object? overallProgress = null,
    Object? lessonCompletedAt = freezed,
    Object? quizCompletedAt = freezed,
    Object? bestQuizResult = freezed,
  }) {
    return _then(_value.copyWith(
      moduleId: null == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lessonCompleted: null == lessonCompleted
          ? _value.lessonCompleted
          : lessonCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      quizCompleted: null == quizCompleted
          ? _value.quizCompleted
          : quizCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      quizPassed: null == quizPassed
          ? _value.quizPassed
          : quizPassed // ignore: cast_nullable_to_non_nullable
              as bool,
      overallProgress: null == overallProgress
          ? _value.overallProgress
          : overallProgress // ignore: cast_nullable_to_non_nullable
              as double,
      lessonCompletedAt: freezed == lessonCompletedAt
          ? _value.lessonCompletedAt
          : lessonCompletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      quizCompletedAt: freezed == quizCompletedAt
          ? _value.quizCompletedAt
          : quizCompletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bestQuizResult: freezed == bestQuizResult
          ? _value.bestQuizResult
          : bestQuizResult // ignore: cast_nullable_to_non_nullable
              as QuizResult?,
    ) as $Val);
  }

  /// Create a copy of ModuleProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuizResultCopyWith<$Res>? get bestQuizResult {
    if (_value.bestQuizResult == null) {
      return null;
    }

    return $QuizResultCopyWith<$Res>(_value.bestQuizResult!, (value) {
      return _then(_value.copyWith(bestQuizResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ModuleProgressImplCopyWith<$Res>
    implements $ModuleProgressCopyWith<$Res> {
  factory _$$ModuleProgressImplCopyWith(_$ModuleProgressImpl value,
          $Res Function(_$ModuleProgressImpl) then) =
      __$$ModuleProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String moduleId,
      String category,
      String title,
      bool lessonCompleted,
      bool quizCompleted,
      bool quizPassed,
      double overallProgress,
      DateTime? lessonCompletedAt,
      DateTime? quizCompletedAt,
      QuizResult? bestQuizResult});

  @override
  $QuizResultCopyWith<$Res>? get bestQuizResult;
}

/// @nodoc
class __$$ModuleProgressImplCopyWithImpl<$Res>
    extends _$ModuleProgressCopyWithImpl<$Res, _$ModuleProgressImpl>
    implements _$$ModuleProgressImplCopyWith<$Res> {
  __$$ModuleProgressImplCopyWithImpl(
      _$ModuleProgressImpl _value, $Res Function(_$ModuleProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of ModuleProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? moduleId = null,
    Object? category = null,
    Object? title = null,
    Object? lessonCompleted = null,
    Object? quizCompleted = null,
    Object? quizPassed = null,
    Object? overallProgress = null,
    Object? lessonCompletedAt = freezed,
    Object? quizCompletedAt = freezed,
    Object? bestQuizResult = freezed,
  }) {
    return _then(_$ModuleProgressImpl(
      moduleId: null == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lessonCompleted: null == lessonCompleted
          ? _value.lessonCompleted
          : lessonCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      quizCompleted: null == quizCompleted
          ? _value.quizCompleted
          : quizCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      quizPassed: null == quizPassed
          ? _value.quizPassed
          : quizPassed // ignore: cast_nullable_to_non_nullable
              as bool,
      overallProgress: null == overallProgress
          ? _value.overallProgress
          : overallProgress // ignore: cast_nullable_to_non_nullable
              as double,
      lessonCompletedAt: freezed == lessonCompletedAt
          ? _value.lessonCompletedAt
          : lessonCompletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      quizCompletedAt: freezed == quizCompletedAt
          ? _value.quizCompletedAt
          : quizCompletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bestQuizResult: freezed == bestQuizResult
          ? _value.bestQuizResult
          : bestQuizResult // ignore: cast_nullable_to_non_nullable
              as QuizResult?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModuleProgressImpl implements _ModuleProgress {
  const _$ModuleProgressImpl(
      {required this.moduleId,
      required this.category,
      required this.title,
      required this.lessonCompleted,
      required this.quizCompleted,
      required this.quizPassed,
      required this.overallProgress,
      this.lessonCompletedAt,
      this.quizCompletedAt,
      this.bestQuizResult});

  factory _$ModuleProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModuleProgressImplFromJson(json);

  @override
  final String moduleId;
  @override
  final String category;
  @override
  final String title;
  @override
  final bool lessonCompleted;
  @override
  final bool quizCompleted;
  @override
  final bool quizPassed;
  @override
  final double overallProgress;
// 0.0 to 1.0
  @override
  final DateTime? lessonCompletedAt;
  @override
  final DateTime? quizCompletedAt;
  @override
  final QuizResult? bestQuizResult;

  @override
  String toString() {
    return 'ModuleProgress(moduleId: $moduleId, category: $category, title: $title, lessonCompleted: $lessonCompleted, quizCompleted: $quizCompleted, quizPassed: $quizPassed, overallProgress: $overallProgress, lessonCompletedAt: $lessonCompletedAt, quizCompletedAt: $quizCompletedAt, bestQuizResult: $bestQuizResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModuleProgressImpl &&
            (identical(other.moduleId, moduleId) ||
                other.moduleId == moduleId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.lessonCompleted, lessonCompleted) ||
                other.lessonCompleted == lessonCompleted) &&
            (identical(other.quizCompleted, quizCompleted) ||
                other.quizCompleted == quizCompleted) &&
            (identical(other.quizPassed, quizPassed) ||
                other.quizPassed == quizPassed) &&
            (identical(other.overallProgress, overallProgress) ||
                other.overallProgress == overallProgress) &&
            (identical(other.lessonCompletedAt, lessonCompletedAt) ||
                other.lessonCompletedAt == lessonCompletedAt) &&
            (identical(other.quizCompletedAt, quizCompletedAt) ||
                other.quizCompletedAt == quizCompletedAt) &&
            (identical(other.bestQuizResult, bestQuizResult) ||
                other.bestQuizResult == bestQuizResult));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      moduleId,
      category,
      title,
      lessonCompleted,
      quizCompleted,
      quizPassed,
      overallProgress,
      lessonCompletedAt,
      quizCompletedAt,
      bestQuizResult);

  /// Create a copy of ModuleProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModuleProgressImplCopyWith<_$ModuleProgressImpl> get copyWith =>
      __$$ModuleProgressImplCopyWithImpl<_$ModuleProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModuleProgressImplToJson(
      this,
    );
  }
}

abstract class _ModuleProgress implements ModuleProgress {
  const factory _ModuleProgress(
      {required final String moduleId,
      required final String category,
      required final String title,
      required final bool lessonCompleted,
      required final bool quizCompleted,
      required final bool quizPassed,
      required final double overallProgress,
      final DateTime? lessonCompletedAt,
      final DateTime? quizCompletedAt,
      final QuizResult? bestQuizResult}) = _$ModuleProgressImpl;

  factory _ModuleProgress.fromJson(Map<String, dynamic> json) =
      _$ModuleProgressImpl.fromJson;

  @override
  String get moduleId;
  @override
  String get category;
  @override
  String get title;
  @override
  bool get lessonCompleted;
  @override
  bool get quizCompleted;
  @override
  bool get quizPassed;
  @override
  double get overallProgress; // 0.0 to 1.0
  @override
  DateTime? get lessonCompletedAt;
  @override
  DateTime? get quizCompletedAt;
  @override
  QuizResult? get bestQuizResult;

  /// Create a copy of ModuleProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModuleProgressImplCopyWith<_$ModuleProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
