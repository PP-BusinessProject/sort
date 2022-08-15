import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_converters_lite/json_converters_lite.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../generated/i18n.g.dart';
import '../notifiers/hive_notifier.dart';
import '../utils/custom_json_converters.dart';
import '../utils/logger.dart';
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

/// The provider that contais current [I18NLocale].
final Provider<Locale> localeProvider = Provider<Locale>(
  (final ProviderRef<Locale> ref) => ref.watch(i18nProvider).toLocale(),
);

/// The provider of the current app's root [Theme].
final StateProvider<ThemeData?> rootThemeProvider =
    StateProvider<ThemeData?>((final StateProviderRef<ThemeData?> ref) => null);

/// The provider of the current app's root [MediaQuery].
final StateProvider<MediaQueryData?> rootMediaQueryProvider =
    StateProvider<MediaQueryData?>(
  (final StateProviderRef<MediaQueryData?> ref) => null,
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
final HiveProvider<I18NLocale> i18nProvider = HiveProvider<I18NLocale>(
  (final HiveProviderRef<I18NLocale> ref) => HiveNotifier<I18NLocale, String>(
    ref.watch(hiveProvider),
    key: 'locale',
    toJson: const EnumConverter<I18NLocale>(I18NLocale.values).toJson,
    fromJson: const EnumConverter<I18NLocale>(I18NLocale.values).fromJson,
    initialValue: I18NLocale.current,
  ),
  dependencies: <ProviderOrFamily>[hiveProvider],
);

// /// The provider of the current user's phone number.
// final HiveOptionalProvider<PhoneNumber> phoneNumberProvider =
//     HiveOptionalProvider<PhoneNumber>(
//   (final HiveOptionalProviderRef<PhoneNumber> ref) =>
//       HiveOptionalNotifier<PhoneNumber, String>(
//     ref.watch(hiveProvider),
//     key: 'phone_number',
//     converter: const StringConverter(phoneNumberConverter),
//   ),
// );

/// The provider of the current user signed in from [FirebaseAuth].
final StreamProvider<User?> signedInProvider =
    StreamProvider<User?>((final _) => FirebaseAuth.instance.userChanges());

/// The provider of the [PhoneNumber] of the current user signed in from
/// [FirebaseAuth].
final Provider<PhoneNumber?> phoneNumberProvider = Provider<PhoneNumber?>(
  (final ProviderRef<PhoneNumber?> ref) {
    try {
      final String phoneNumber = ref.watch(
        signedInProvider.select(
          (final AsyncValue<User?> user) => user.valueOrNull?.phoneNumber ?? '',
        ),
      );
      return phoneNumber.isEmpty ? null : PhoneNumber.fromRaw(phoneNumber);
    } on Exception catch (exception) {
      logger.e('Exception occured while parsing phoneNumber.', exception);
      return null;
    }
  },
  dependencies: <ProviderOrFamily>[signedInProvider],
);

/// The provider of the current user signed in from [FirebaseAuth] as [int].
final Provider<int?> $phoneNumberProvider = Provider<int?>(
  (final ProviderRef<int?> ref) => ref.watch(
    phoneNumberProvider.select(
      (final PhoneNumber? phoneNumber) => int.tryParse(
        phoneNumber?.international.replaceAll(RegExp(r'\D'), '') ?? '',
      ),
    ),
  ),
  dependencies: <ProviderOrFamily>[phoneNumberProvider],
);

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
