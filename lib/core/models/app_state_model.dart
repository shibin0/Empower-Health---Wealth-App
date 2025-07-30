import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_profile.dart';

part 'app_state_model.freezed.dart';
part 'app_state_model.g.dart';

@freezed
class AppStateModel with _$AppStateModel {
  const factory AppStateModel({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @JsonKey(fromJson: _localeFromJson, toJson: _localeToJson)
    @Default(Locale('en', 'US')) Locale locale,
    @Default(false) bool isOnboardingComplete,
    @Default(0) int currentTabIndex,
    UserProfile? userProfile,
  }) = _AppStateModel;

  // Factory method for initial state
  factory AppStateModel.initial() => const AppStateModel();

  factory AppStateModel.fromJson(Map<String, dynamic> json) =>
      _$AppStateModelFromJson(json);
}

// Helper functions for Locale serialization
Locale _localeFromJson(Map<String, dynamic> json) {
  return Locale(json['languageCode'] as String, json['countryCode'] as String?);
}

Map<String, dynamic> _localeToJson(Locale locale) {
  return {
    'languageCode': locale.languageCode,
    'countryCode': locale.countryCode,
  };
}