import 'package:flutter/widgets.dart';

import 'generated/models.g.dart';

/// The extension on [UserModel].
extension AddressModelExtension on AddressModel {
  AddressLocaleModel? _locale(final Locale locale) =>
      (locales.whereType<AddressLocaleModel?>()).firstWhere(
        (final AddressLocaleModel? $locale) =>
            $locale!.localeLanguageCode == locale.languageCode &&
            (($locale.localeCountryCode == null ||
                    locale.countryCode == null) ||
                $locale.localeCountryCode == locale.countryCode),
        orElse: () => null,
      );

  /// Return the country of this address depending on [locale].
  String country(final Locale locale) =>
      _locale(locale)?.country ?? fallbackCountry;

  /// Return the state of this address depending on [locale].
  String state(final Locale locale) => _locale(locale)?.state ?? fallbackState;

  /// Return the city of this address depending on [locale].
  String city(final Locale locale) => _locale(locale)?.city ?? fallbackCity;

  /// Return the street of this address depending on [locale].
  String street(final Locale locale) =>
      _locale(locale)?.street ?? fallbackStreet;
}

/// The extension on [UserModel].
extension UserModelExtension on UserModel {
  /// Return the fallback full name of this user.
  String get fallbackFullName =>
      <String>[fallbackFirstName, fallbackLastName].join(' ');

  /// Return the full name of this user depending on [locale].
  String fullName(final Locale locale) {
    final UserLocaleModel? userLocale =
        (locales.whereType<UserLocaleModel?>()).firstWhere(
      (final UserLocaleModel? $locale) =>
          $locale!.localeLanguageCode == locale.languageCode &&
          (($locale.localeCountryCode == null || locale.countryCode == null) ||
              $locale.localeCountryCode == locale.countryCode),
      orElse: () => null,
    );
    if (userLocale != null) {
      return <String>[userLocale.firstName, userLocale.lastName].join(' ');
    }
    return fallbackFullName;
  }
}

/// The extension on [BonusModel].
extension BonusModelExtension on BonusModel {
  BonusLocaleModel? _locale(final Locale locale) =>
      (locales.whereType<BonusLocaleModel?>()).firstWhere(
        (final BonusLocaleModel? $locale) =>
            $locale!.localeLanguageCode == locale.languageCode &&
            (($locale.localeCountryCode == null ||
                    locale.countryCode == null) ||
                $locale.localeCountryCode == locale.countryCode),
        orElse: () => null,
      );

  /// Return the name of this bonus depending on [locale].
  String name(final Locale locale) => _locale(locale)?.name ?? fallbackName;

  /// Return the description of this bonus depending on [locale].
  String description(final Locale locale) =>
      _locale(locale)?.description ?? fallbackDescription;
}

/// The extension on [ContainerTankTypeModel].
extension ContainerTankTypeModelExtension on ContainerTankTypeModel {
  ContainerTankTypeLocaleModel? _locale(final Locale locale) =>
      (locales.whereType<ContainerTankTypeLocaleModel?>()).firstWhere(
        (final ContainerTankTypeLocaleModel? $locale) =>
            $locale!.localeLanguageCode == locale.languageCode &&
            (($locale.localeCountryCode == null ||
                    locale.countryCode == null) ||
                $locale.localeCountryCode == locale.countryCode),
        orElse: () => null,
      );

  /// Return the name of this bonus depending on [locale].
  String name(final Locale locale) => _locale(locale)?.name ?? fallbackName;
}

/// The extension on [ContainerTankTypeModel].
extension ContainerReportTypeModelExtension on ContainerReportTypeModel {
  ContainerReportTypeLocaleModel? _locale(final Locale locale) =>
      (locales.whereType<ContainerReportTypeLocaleModel?>()).firstWhere(
        (final ContainerReportTypeLocaleModel? $locale) =>
            $locale!.localeLanguageCode == locale.languageCode &&
            (($locale.localeCountryCode == null ||
                    locale.countryCode == null) ||
                $locale.localeCountryCode == locale.countryCode),
        orElse: () => null,
      );

  /// Return the name of this bonus depending on [locale].
  String name(final Locale locale) => _locale(locale)?.name ?? fallbackName;
}
