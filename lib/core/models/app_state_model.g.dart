// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppStateModelImpl _$$AppStateModelImplFromJson(Map<String, dynamic> json) =>
    _$AppStateModelImpl(
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      locale: json['locale'] == null
          ? const Locale('en', 'US')
          : _localeFromJson(json['locale'] as Map<String, dynamic>),
      isOnboardingComplete: json['isOnboardingComplete'] as bool? ?? false,
      currentTabIndex: (json['currentTabIndex'] as num?)?.toInt() ?? 0,
      userProfile: json['userProfile'] == null
          ? null
          : UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppStateModelImplToJson(_$AppStateModelImpl instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'locale': _localeToJson(instance.locale),
      'isOnboardingComplete': instance.isOnboardingComplete,
      'currentTabIndex': instance.currentTabIndex,
      'userProfile': instance.userProfile,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
