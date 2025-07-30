// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppStateModel _$AppStateModelFromJson(Map<String, dynamic> json) {
  return _AppStateModel.fromJson(json);
}

/// @nodoc
mixin _$AppStateModel {
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _localeFromJson, toJson: _localeToJson)
  Locale get locale => throw _privateConstructorUsedError;
  bool get isOnboardingComplete => throw _privateConstructorUsedError;
  int get currentTabIndex => throw _privateConstructorUsedError;
  UserProfile? get userProfile => throw _privateConstructorUsedError;

  /// Serializes this AppStateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppStateModelCopyWith<AppStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateModelCopyWith<$Res> {
  factory $AppStateModelCopyWith(
          AppStateModel value, $Res Function(AppStateModel) then) =
      _$AppStateModelCopyWithImpl<$Res, AppStateModel>;
  @useResult
  $Res call(
      {ThemeMode themeMode,
      @JsonKey(fromJson: _localeFromJson, toJson: _localeToJson) Locale locale,
      bool isOnboardingComplete,
      int currentTabIndex,
      UserProfile? userProfile});

  $UserProfileCopyWith<$Res>? get userProfile;
}

/// @nodoc
class _$AppStateModelCopyWithImpl<$Res, $Val extends AppStateModel>
    implements $AppStateModelCopyWith<$Res> {
  _$AppStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? locale = null,
    Object? isOnboardingComplete = null,
    Object? currentTabIndex = null,
    Object? userProfile = freezed,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      isOnboardingComplete: null == isOnboardingComplete
          ? _value.isOnboardingComplete
          : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      currentTabIndex: null == currentTabIndex
          ? _value.currentTabIndex
          : currentTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
    ) as $Val);
  }

  /// Create a copy of AppStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res>? get userProfile {
    if (_value.userProfile == null) {
      return null;
    }

    return $UserProfileCopyWith<$Res>(_value.userProfile!, (value) {
      return _then(_value.copyWith(userProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppStateModelImplCopyWith<$Res>
    implements $AppStateModelCopyWith<$Res> {
  factory _$$AppStateModelImplCopyWith(
          _$AppStateModelImpl value, $Res Function(_$AppStateModelImpl) then) =
      __$$AppStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ThemeMode themeMode,
      @JsonKey(fromJson: _localeFromJson, toJson: _localeToJson) Locale locale,
      bool isOnboardingComplete,
      int currentTabIndex,
      UserProfile? userProfile});

  @override
  $UserProfileCopyWith<$Res>? get userProfile;
}

/// @nodoc
class __$$AppStateModelImplCopyWithImpl<$Res>
    extends _$AppStateModelCopyWithImpl<$Res, _$AppStateModelImpl>
    implements _$$AppStateModelImplCopyWith<$Res> {
  __$$AppStateModelImplCopyWithImpl(
      _$AppStateModelImpl _value, $Res Function(_$AppStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? locale = null,
    Object? isOnboardingComplete = null,
    Object? currentTabIndex = null,
    Object? userProfile = freezed,
  }) {
    return _then(_$AppStateModelImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      isOnboardingComplete: null == isOnboardingComplete
          ? _value.isOnboardingComplete
          : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      currentTabIndex: null == currentTabIndex
          ? _value.currentTabIndex
          : currentTabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppStateModelImpl implements _AppStateModel {
  const _$AppStateModelImpl(
      {this.themeMode = ThemeMode.system,
      @JsonKey(fromJson: _localeFromJson, toJson: _localeToJson)
      this.locale = const Locale('en', 'US'),
      this.isOnboardingComplete = false,
      this.currentTabIndex = 0,
      this.userProfile});

  factory _$AppStateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppStateModelImplFromJson(json);

  @override
  @JsonKey()
  final ThemeMode themeMode;
  @override
  @JsonKey(fromJson: _localeFromJson, toJson: _localeToJson)
  final Locale locale;
  @override
  @JsonKey()
  final bool isOnboardingComplete;
  @override
  @JsonKey()
  final int currentTabIndex;
  @override
  final UserProfile? userProfile;

  @override
  String toString() {
    return 'AppStateModel(themeMode: $themeMode, locale: $locale, isOnboardingComplete: $isOnboardingComplete, currentTabIndex: $currentTabIndex, userProfile: $userProfile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateModelImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.isOnboardingComplete, isOnboardingComplete) ||
                other.isOnboardingComplete == isOnboardingComplete) &&
            (identical(other.currentTabIndex, currentTabIndex) ||
                other.currentTabIndex == currentTabIndex) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, themeMode, locale,
      isOnboardingComplete, currentTabIndex, userProfile);

  /// Create a copy of AppStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateModelImplCopyWith<_$AppStateModelImpl> get copyWith =>
      __$$AppStateModelImplCopyWithImpl<_$AppStateModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppStateModelImplToJson(
      this,
    );
  }
}

abstract class _AppStateModel implements AppStateModel {
  const factory _AppStateModel(
      {final ThemeMode themeMode,
      @JsonKey(fromJson: _localeFromJson, toJson: _localeToJson)
      final Locale locale,
      final bool isOnboardingComplete,
      final int currentTabIndex,
      final UserProfile? userProfile}) = _$AppStateModelImpl;

  factory _AppStateModel.fromJson(Map<String, dynamic> json) =
      _$AppStateModelImpl.fromJson;

  @override
  ThemeMode get themeMode;
  @override
  @JsonKey(fromJson: _localeFromJson, toJson: _localeToJson)
  Locale get locale;
  @override
  bool get isOnboardingComplete;
  @override
  int get currentTabIndex;
  @override
  UserProfile? get userProfile;

  /// Create a copy of AppStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppStateModelImplCopyWith<_$AppStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
