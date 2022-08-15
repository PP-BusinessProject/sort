import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'providers/flutter_providers.dart';
import 'providers/model_providers.dart';
import 'screens/authorization_screen.dart';
import 'screens/b2c/b2c_screen.dart';
import 'screens/profile_screen.dart';
import 'utils/logger.dart';

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
  Widget builder([final BuildContext? context]) => Consumer(
        builder: (final _, final WidgetRef ref, final Widget? child) {
          AsyncValue<Object?>? value;
          if ((value = ref.watch(signedInProvider)) is AsyncData<User?> &&
              value!.valueOrNull == null) {
            return const AuthorizationScreen();
          } else if (ref.watch(userProvider.select((final _) => _ == null))) {
            return const ProfileScreen();
          } else if (value is! AsyncData<Object?> ||
              ref.watch(userLoadingProvider)) {
            if (value is AsyncError<Object?>) {
              logger.e('Exception occured.', value.error, value.stackTrace);
            }
            return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          } else {
            switch (this) {
              case SortFlavor.b2c:
                return const B2CScreen();
              case SortFlavor.b2b:
              // return (final BuildContext context) => const SortB2B();
              case SortFlavor.delivery:
              // return (final BuildContext context) => const SortDelivery();
              case SortFlavor.support:
                // return (final BuildContext context) => const SortSupport();
                return const Placeholder();
            }
          }
        },
      );
}
