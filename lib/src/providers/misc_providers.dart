import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod/riverpod.dart';

import '../flavors.dart';

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
