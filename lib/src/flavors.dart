import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'screens/b2c_screen.dart';

/// The flavors of the `SORT` application.
enum SortFlavor {
  /// Business to Client application.
  b2c,

  /// Business to Bustiness application.
  b2b,

  /// Couriers application.
  delivery,

  /// Back Office application.
  support;

  /// Create a [SortFlavor] from it's name as [flavor].
  factory SortFlavor.fromString(final String flavor) {
    final String $flavor = flavor.trim().toLowerCase();
    return values.firstWhere(
      (final SortFlavor flavor) => flavor.name == $flavor,
      orElse: () => support,
    );
  }

  /// Create a [SortFlavor] from application package.
  static SortFlavor fromPackage(final PackageInfo package) {
    final Iterable<String> $flavor = package.packageName.split('.').skip(3);
    return SortFlavor.fromString($flavor.isEmpty ? '' : $flavor.last);
  }

  /// The title of the application for each flavor.
  String get title {
    switch (this) {
      case b2c:
        return 'SORT';
      case b2b:
        return 'SORT Business';
      case delivery:
        return 'SORT Delivery';
      case support:
        return 'SORT Support';
    }
  }

  /// The path to this flavor.
  String get path => '/$name';

  /// The [ModalRoute.withName] that leads to this flavor.
  bool Function(Route<Object?>) get withName => ModalRoute.withName(path);

  /// The builder of this route.
  Widget Function(BuildContext context)? get builder {
    switch (this) {
      case SortFlavor.b2c:
        return (final BuildContext context) => const SortB2C();
      case SortFlavor.b2b:
      // return (final BuildContext context) => const SortB2B();
      case SortFlavor.delivery:
      // return (final BuildContext context) => const SortDelivery();
      case SortFlavor.support:
        // return (final BuildContext context) => const SortSupport();
        return (final BuildContext context) => const Placeholder();
    }
  }
}
