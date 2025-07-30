// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_api_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$healthApiServiceHash() => r'10c08ef4b4d0995754ff8ed3b2fba2cb23326131';

/// Health API integration service for Apple HealthKit and Google Fit
///
/// Copied from [HealthApiService].
@ProviderFor(HealthApiService)
final healthApiServiceProvider = AutoDisposeAsyncNotifierProvider<
    HealthApiService, HealthApiService>.internal(
  HealthApiService.new,
  name: r'healthApiServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthApiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HealthApiService = AutoDisposeAsyncNotifier<HealthApiService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
