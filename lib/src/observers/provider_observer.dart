import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';

import '../providers/flutter_providers.dart';

/// The observer on any [Provider].
class WidgetsBindingObserverProvider extends WidgetsBindingObserver {
  /// The observer on any [Provider].
  WidgetsBindingObserverProvider(this._container);

  final ProviderContainer _container;

  @override
  FutureOr<void> didChangeLocales(final List<Locale>? locales) async {
    if (locales != null && locales.isNotEmpty) {
      _container.read(systemLocalesProvider.notifier).state = locales;
    }
  }
}
