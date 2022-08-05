import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:json_converters_lite/json_converters_lite.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:riverpod/riverpod.dart';

import '../api.dart';
import '../flavors.dart';

/// The [Provider] on the application initialisation.
final FutureProvider<Iterable<Object?>> initialisationProvider =
    FutureProvider<Iterable<Object?>>(
  (final FutureProviderRef<Iterable<Object?>> ref) async =>
      Future.wait<Object?>(<Future<Object?>>[
    PackageInfo.fromPlatform(),
    Future<Box<String>>(() async {
      Hive.init((await getApplicationDocumentsDirectory()).path);
      return Hive.openBox<String>('storage');
    }),
    (ref.watch(sortApiProvider))
        .get('/settings/time', converter: dateTimeConverter),
    Firebase.initializeApp(),
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    ),
  ]),
  dependencies: <ProviderOrFamily>[widgetsBindingProvider, sortApiProvider],
);

/// The [Provider] of the initialised Flutter [WidgetsBinding] instance.
final Provider<WidgetsBinding> widgetsBindingProvider =
    Provider<WidgetsBinding>(
  (final ProviderRef<WidgetsBinding> ref) =>
      throw UnimplementedError('WidgetsBinding has not been provided yet.'),
);

/// The [Provider] of the current application flavor.
final Provider<SortFlavor> flavorProvider = Provider<SortFlavor>(
  (final ProviderRef<SortFlavor> ref) =>
      throw UnimplementedError('Application flavor has not been provided yet.'),
);

/// The [Provider] of the application [PackageInfo].
final Provider<PackageInfo> packageInfoProvider = Provider<PackageInfo>(
  (final ProviderRef<PackageInfo> ref) =>
      throw UnimplementedError('PackageInfo has not been provided yet.'),
);

/// The provider of the [Hive] database.
final Provider<Box<String>> hiveProvider =
    Provider<Box<String>>((final ProviderRef<Box<String>> ref) {
  throw Exception('Hive was not initialised.');
});

/// If the [RefreshConfiguration] header should display a connection error.
final StateProvider<bool> connectionErrorProvider =
    StateProvider<bool>((final StateProviderRef<bool> ref) => false);

/// The [Provider] of the application [PackageInfo].
final StreamProvider<Position> positionProvider = StreamProvider<Position>(
  (final StreamProviderRef<Position> ref) => GeolocatorPlatform.instance
      .getPositionStream(locationSettings: const LocationSettings())
      .handleError(
        (final Object error) {},
        test: (final Object? error) =>
            error is PermissionDeniedException ||
            error is LocationServiceDisabledException ||
            error is TimeoutException,
      ),
);

/// The provider of the current server time.
final StateNotifierProvider<ServerTimeNotifier, DateTime> serverTimeProvider =
    StateNotifierProvider<ServerTimeNotifier, DateTime>((final _) {
  throw UnimplementedError('Server time has not been provided yet.');
});

/// The notifier of the current server time.
class ServerTimeNotifier extends StateNotifier<DateTime> {
  /// The notifier of the current server time.
  ServerTimeNotifier([final DateTime? initialServerTime])
      : super(initialServerTime ?? DateTime.now()) {
    _timer.start();
  }
  final Stopwatch _timer = Stopwatch();

  /// Returns the current server time.
  @override
  DateTime get state => super.state.add(_timer.elapsed);

  /// Sets the current server time.
  @override
  set state(final DateTime initialServerTime) {
    super.state = initialServerTime;
    _timer
      ..reset()
      ..start();
  }
}
