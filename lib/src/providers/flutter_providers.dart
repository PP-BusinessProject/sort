import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_converters_lite/json_converters_lite.dart';

import '../generated/i18n.g.dart';
import '../generated/models.g.dart';
import '../notifiers/hive_notifier.dart';
import '../utils/custom_json_converters.dart';
import 'database/model_providers.dart';
import 'misc_providers.dart';

/// An alias to the [StateNotifierProvider] for a [HiveNotifier].
typedef HiveProvider<T extends Object>
    = StateNotifierProvider<HiveNotifier<T, String>, T>;

/// An alias to the [StateNotifierProviderRef] for a [HiveNotifier].
typedef HiveProviderRef<T extends Object>
    = StateNotifierProviderRef<HiveNotifier<T, String>, T>;

/// An alias to the [StateNotifierProvider] for a [HiveOptionalNotifier].
typedef HiveOptionalProvider<T extends Object?>
    = StateNotifierProvider<HiveOptionalNotifier<T?, String?>, T?>;

/// An alias to the [StateNotifierProviderRef] for a [HiveOptionalNotifier].
typedef HiveOptionalProviderRef<T extends Object?>
    = StateNotifierProviderRef<HiveOptionalNotifier<T?, String?>, T?>;

/// The provider of the current app's root [Theme].
final StateProvider<ThemeData> themeProvider = StateProvider<ThemeData>(
  (final StateProviderRef<ThemeData?> ref) => ThemeData(),
);

/// The provider of the current app's root [MediaQuery].
final StateProvider<MediaQueryData> mediaQueryProvider =
    StateProvider<MediaQueryData>(
  (final StateProviderRef<MediaQueryData?> ref) => const MediaQueryData(),
);

/// The provider of the current [ThemeMode].
final HiveProvider<ThemeMode> themeModeProvider = HiveProvider<ThemeMode>(
  (final HiveProviderRef<ThemeMode> ref) => HiveNotifier<ThemeMode, String>(
    ref.watch(hiveProvider),
    key: 'theme',
    toJson: const EnumConverter<ThemeMode>(ThemeMode.values).toJson,
    fromJson: const EnumConverter<ThemeMode>(ThemeMode.values).fromJson,
    initialValue: ThemeMode.system,
  ),
  dependencies: <ProviderOrFamily>[hiveProvider],
);

/// The provider of the list of the current system [Locale].
final StateProvider<List<Locale>> systemLocalesProvider =
    StateProvider<List<Locale>>(
  (final StateProviderRef<List<Locale>> ref) =>
      WidgetsBinding.instance.window.platformDispatcher.locales,
);

/// The provider of the current [I18NLocale].
final HiveProvider<bool> i18nChangedProvider = HiveProvider<bool>(
  (final HiveProviderRef<bool> ref) => HiveNotifier<bool, String>(
    ref.watch(hiveProvider),
    key: 'was_locale_changed',
    toJson: const StringConverter(boolConverter).toJson,
    fromJson: const StringConverter(boolConverter).fromJson,
    initialValue: false,
  ),
  dependencies: <ProviderOrFamily>[hiveProvider],
);

/// The provider of the current [I18NLocale].
final HiveOptionalProvider<LocaleModel?> i18nProvider =
    HiveOptionalProvider<LocaleModel?>(
  (final HiveOptionalProviderRef<LocaleModel?> ref) =>
      HiveOptionalNotifier<LocaleModel?, String>(
    ref.watch(hiveProvider),
    key: 'locale',
    toJson: const OptionalStringConverter(optionalLocaleConverter).toJson,
    fromJson: const OptionalStringConverter(optionalLocaleConverter).fromJson,
    initialValue: null,
  ),
  dependencies: <ProviderOrFamily>[hiveProvider, systemLocalesProvider],
);

/// Observe the changes on [i18nProvider].
class I18NObserver extends ProviderObserver {
  /// Observe the changes on [i18nProvider].
  const I18NObserver();

  @override
  Future<void> didUpdateProvider(
    final ProviderBase<Object?> provider,
    final Object? previousValue,
    final Object? newValue,
    final ProviderContainer container,
  ) async {
    if (provider == i18nProvider) {
      final HiveNotifier<bool, String> i18nChangedNotifier =
          container.read(i18nChangedProvider.notifier);
      if (!i18nChangedNotifier.state) {
        await i18nChangedNotifier.setStateAsync(true);
      }
    } else if (provider == systemLocalesProvider) {
      final HiveNotifier<bool, String> i18nChangedNotifier =
          container.read(i18nChangedProvider.notifier);
      if (!i18nChangedNotifier.state) {
        if (newValue is List<Locale> && newValue.isNotEmpty) {
          LocaleModel? $locale;
          for (final LocaleModel locale
              in await container.read(localesProvider.future) ??
                  const Iterable<LocaleModel>.empty()) {
            if (newValue.first ==
                Locale(locale.languageCode, locale.countryCode)) {
              $locale = locale;
              break;
            }
          }
          await container.read(i18nProvider.notifier).setStateAsync($locale);
        }
        await i18nChangedNotifier.setStateAsync(false);
      }
    }
  }
}

/// Convert [I18NLocale] to [Locale].
extension I18NToLocale on I18NLocale {
  /// Convert this [I18NLocale] to [Locale].
  Locale toLocale() {
    final Iterable<String> localeTags = name.split('_');
    return localeTags.length > 2
        ? Locale.fromSubtags(
            languageCode: localeTags.first,
            scriptCode: localeTags.elementAt(1),
            countryCode: localeTags.last,
          )
        : Locale(
            localeTags.first,
            localeTags.length > 1 ? localeTags.last : null,
          );
  }
}
