import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';

import '../generated/i18n.g.dart';
import '../providers/flutter_providers.dart';
import '../providers/misc_providers.dart';

/// The provider of the [ProviderObserver]
final Provider<ProviderObserver> providerObserverProvider =
    Provider<ProviderObserver>(
  ProviderObserver._,
  dependencies: <ProviderOrFamily>[
    hiveProvider,
    i18nChangedProvider,
    i18nChangedProvider.notifier,
    i18nProvider,
    i18nProvider.notifier
  ],
);

/// The observer on any [Provider].
class ProviderObserver extends WidgetsBindingObserver {
  /// The observer on any [Provider].
  ProviderObserver._(final this._ref);
  final ProviderRef<ProviderObserver> _ref;

  @override
  FutureOr<void> didChangeLocales(final Iterable<Locale>? locales) async {
    if (locales == null || locales.isEmpty) {
      return;
    }
    if (!_ref.read(i18nChangedProvider)) {
      final String currentLocale = locales.first.toString().toLowerCase();
      _ref.read(i18nProvider.notifier).state = I18NLocale.values.firstWhere(
        (final I18NLocale locale) => locale.name.toLowerCase() == currentLocale,
        orElse: () => I18NLocale.current,
      );
    }
  }
}
