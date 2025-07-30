// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$connectivityStreamHash() =>
    r'0be207f65611c78b374d4cfdbb9a493e52c44e53';

/// See also [connectivityStream].
@ProviderFor(connectivityStream)
final connectivityStreamProvider =
    AutoDisposeStreamProvider<ConnectivityResult>.internal(
  connectivityStream,
  name: r'connectivityStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectivityStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivityStreamRef
    = AutoDisposeStreamProviderRef<ConnectivityResult>;
String _$isDeviceOnlineHash() => r'cd954454b0bb307cb163e176007e88246e873ccd';

/// See also [isDeviceOnline].
@ProviderFor(isDeviceOnline)
final isDeviceOnlineProvider = AutoDisposeFutureProvider<bool>.internal(
  isDeviceOnline,
  name: r'isDeviceOnlineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isDeviceOnlineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsDeviceOnlineRef = AutoDisposeFutureProviderRef<bool>;
String _$offlineSyncServiceHash() =>
    r'a7c32a23673c9ef180679b059392bfbc45b7c587';

/// See also [OfflineSyncService].
@ProviderFor(OfflineSyncService)
final offlineSyncServiceProvider =
    AutoDisposeAsyncNotifierProvider<OfflineSyncService, SyncStatus>.internal(
  OfflineSyncService.new,
  name: r'offlineSyncServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$offlineSyncServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OfflineSyncService = AutoDisposeAsyncNotifier<SyncStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
