// ignore_for_file: file_names, unnecessary_string_interpolations, unused_field

/// This file is used for `I18N` package generation.
///
/// Modify this file at your own risk!
///
/// See: https://pub.dev/packages/generators#i18n-generator
///
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../utils/l10n.dart';

/// The generated [I18N] enumeration.
enum I18NLocale {
  /// The implementation of the [enUS] locale.
  enUS,

  /// The implementation of the [ukUA] locale.
  ukUA;

  /// Return the current active locale.
  static I18NLocale get current {
    final String currentLocale = Intl.getCurrentLocale().toLowerCase();
    return values.firstWhere(
      (final I18NLocale locale) => locale.name.toLowerCase() == currentLocale,
      orElse: () => values.first,
    );
  }

  /// Return the localization for this locale.
  I18N call() {
    switch (this) {
      case I18NLocale.enUS:
        return enUSI18N;
      case I18NLocale.ukUA:
        return ukUAI18N;
    }
  }

  /// Return the name of this locale.
  String get name {
    switch (this) {
      case I18NLocale.enUS:
        return 'en_US';
      case I18NLocale.ukUA:
        return 'uk_UA';
    }
  }
}

/// The architecture of the root group.
@immutable
abstract class I18N extends L10N<I18NLocale> {
  const I18N._(super._);

  /// The `misc` group in the root group.
  I18NMisc<I18N> get misc;

  /// The `alert` group in the root group.
  I18NAlert<I18N> get alert;

  /// The `pull_to_refresh` group in the root group.
  I18NPullToRefresh<I18N> get pullToRefresh;

  /// The `auth` group in the root group.
  I18NAuth<I18N> get auth;

  /// The `profile` group in the root group.
  I18NProfile<I18N> get profile;

  /// The `menu` group in the root group.
  I18NMenu<I18N> get menu;

  /// The `settings` group in the root group.
  I18NSettings<I18N> get settings;

  /// The `bonus` group in the root group.
  I18NBonus<I18N> get bonus;

  /// The `container` group in the root group.
  I18NContainer<I18N> get container;

  /// The `delivery` group in the root group.
  I18NDelivery<I18N> get delivery;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is I18N &&
          other.misc == misc &&
          other.alert == alert &&
          other.pullToRefresh == pullToRefresh &&
          other.auth == auth &&
          other.profile == profile &&
          other.menu == menu &&
          other.settings == settings &&
          other.bonus == bonus &&
          other.container == container &&
          other.delivery == delivery;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      misc.hashCode ^
      alert.hashCode ^
      pullToRefresh.hashCode ^
      auth.hashCode ^
      profile.hashCode ^
      menu.hashCode ^
      settings.hashCode ^
      bonus.hashCode ^
      container.hashCode ^
      delivery.hashCode;
}

/// The architecture of the `misc` group.
@immutable
abstract class I18NMisc<T extends I18N> extends L10N<I18NLocale> {
  const I18NMisc._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `prev_page` key in the `misc` group.
  String get prevPage;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NMisc<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `alert` group.
@immutable
abstract class I18NAlert<T extends I18N> extends L10N<I18NLocale> {
  const I18NAlert._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `exit` group in the `alert` group.
  I18NAlertExit<I18NAlert<I18N>> get exit;

  /// The `exit_register` group in the `alert` group.
  I18NAlertExitRegister<I18NAlert<I18N>> get exitRegister;

  /// The `error` group in the `alert` group.
  I18NAlertError<I18NAlert<I18N>> get error;

  /// The `success` group in the `alert` group.
  I18NAlertSuccess<I18NAlert<I18N>> get success;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is I18NAlert<T> &&
          other.exit == exit &&
          other.exitRegister == exitRegister &&
          other.error == error &&
          other.success == success;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      exit.hashCode ^
      exitRegister.hashCode ^
      error.hashCode ^
      success.hashCode;
}

/// The architecture of the `alert`/`exit` group.
@immutable
abstract class I18NAlertExit<T extends I18NAlert<I18N>>
    extends L10N<I18NLocale> {
  const I18NAlertExit._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `title` key in the `alert`/`exit` group.
  String get title;

  /// The `approve` key in the `alert`/`exit` group.
  String get approve;

  /// The `deny` key in the `alert`/`exit` group.
  String get deny;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NAlertExit<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `alert`/`exit_register` group.
@immutable
abstract class I18NAlertExitRegister<T extends I18NAlert<I18N>>
    extends L10N<I18NLocale> {
  const I18NAlertExitRegister._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `title` key in the `alert`/`exit_register` group.
  String get title;

  /// The `approve` key in the `alert`/`exit_register` group.
  String get approve;

  /// The `deny` key in the `alert`/`exit_register` group.
  String get deny;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NAlertExitRegister<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `alert`/`error` group.
@immutable
abstract class I18NAlertError<T extends I18NAlert<I18N>>
    extends L10N<I18NLocale> {
  const I18NAlertError._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `title` key in the `alert`/`error` group.
  String get title;

  /// The `body` key in the `alert`/`error` group.
  String get body;

  /// The `approve` key in the `alert`/`error` group.
  String get approve;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NAlertError<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `alert`/`success` group.
@immutable
abstract class I18NAlertSuccess<T extends I18NAlert<I18N>>
    extends L10N<I18NLocale> {
  const I18NAlertSuccess._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `title` key in the `alert`/`success` group.
  String get title;

  /// The `body` key in the `alert`/`success` group.
  String get body;

  /// The `approve` key in the `alert`/`success` group.
  String get approve;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NAlertSuccess<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `pull_to_refresh` group.
@immutable
abstract class I18NPullToRefresh<T extends I18N> extends L10N<I18NLocale> {
  const I18NPullToRefresh._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `idle` key in the `pull_to_refresh` group.
  String get idle;

  /// The `release` key in the `pull_to_refresh` group.
  String get release;

  /// The `refreshing` key in the `pull_to_refresh` group.
  String get refreshing;

  /// The `complete` key in the `pull_to_refresh` group.
  String get complete;

  /// The `complete_internet_error` key in the `pull_to_refresh` group.
  String get completeInternetError;

  /// The `error` key in the `pull_to_refresh` group.
  String get error;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NPullToRefresh<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `auth` group.
@immutable
abstract class I18NAuth<T extends I18N> extends L10N<I18NLocale> {
  const I18NAuth._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `support` key in the `auth` group.
  String get support;

  /// The `phone_number` group in the `auth` group.
  I18NAuthPhoneNumber<I18NAuth<I18N>> get phoneNumber;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is I18NAuth<T> && other.phoneNumber == phoneNumber;

  @override
  int get hashCode => runtimeType.hashCode ^ phoneNumber.hashCode;
}

/// The architecture of the `auth`/`phone_number` group.
@immutable
abstract class I18NAuthPhoneNumber<T extends I18NAuth<I18N>>
    extends L10N<I18NLocale> {
  const I18NAuthPhoneNumber._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `enter` key in the `auth`/`phone_number` group.
  String get enter;

  /// The `get_code` key in the `auth`/`phone_number` group.
  String get getCode;

  /// The `code_sent` key in the `auth`/`phone_number` group.
  String codeSent(final String phoneNumber);

  /// The `resend_code_prompt` key in the `auth`/`phone_number` group.
  String get resendCodePrompt;

  /// The `resend_code` key in the `auth`/`phone_number` group.
  String get resendCode;

  /// The `paste_alert` group in the `auth`/`phone_number` group.
  I18NAuthPhoneNumberPasteAlert<I18NAuthPhoneNumber<I18NAuth<I18N>>>
      get pasteAlert;

  /// The `error` group in the `auth`/`phone_number` group.
  I18NAuthPhoneNumberError<I18NAuthPhoneNumber<I18NAuth<I18N>>> get error;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is I18NAuthPhoneNumber<T> &&
          other.pasteAlert == pasteAlert &&
          other.error == error;

  @override
  int get hashCode =>
      runtimeType.hashCode ^ pasteAlert.hashCode ^ error.hashCode;
}

/// The architecture of the `auth`/`phone_number`/`paste_alert` group.
@immutable
abstract class I18NAuthPhoneNumberPasteAlert<
    T extends I18NAuthPhoneNumber<I18NAuth<I18N>>> extends L10N<I18NLocale> {
  const I18NAuthPhoneNumberPasteAlert._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `title` key in the `auth`/`phone_number`/`paste_alert` group.
  String get title;

  /// The `body` key in the `auth`/`phone_number`/`paste_alert` group.
  String body(final int code);

  /// The `approve` key in the `auth`/`phone_number`/`paste_alert` group.
  String get approve;

  /// The `deny` key in the `auth`/`phone_number`/`paste_alert` group.
  String get deny;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NAuthPhoneNumberPasteAlert<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `auth`/`phone_number`/`error` group.
@immutable
abstract class I18NAuthPhoneNumberError<
    T extends I18NAuthPhoneNumber<I18NAuth<I18N>>> extends L10N<I18NLocale> {
  const I18NAuthPhoneNumberError._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `unknown` key in the `auth`/`phone_number`/`error` group.
  String get unknown;

  /// The `invalid` key in the `auth`/`phone_number`/`error` group.
  String get invalid;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NAuthPhoneNumberError<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `profile` group.
@immutable
abstract class I18NProfile<T extends I18N> extends L10N<I18NLocale> {
  const I18NProfile._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `phone_number` key in the `profile` group.
  String get phoneNumber;

  /// The `first_name` key in the `profile` group.
  String get firstName;

  /// The `first_name_error` key in the `profile` group.
  String get firstNameError;

  /// The `last_name` key in the `profile` group.
  String get lastName;

  /// The `last_name_error` key in the `profile` group.
  String get lastNameError;

  /// The `email` key in the `profile` group.
  String get email;

  /// The `email_error` key in the `profile` group.
  String get emailError;

  /// The `birthday` key in the `profile` group.
  String get birthday;

  /// The `birthday_confirm` key in the `profile` group.
  String get birthdayConfirm;

  /// The `gender` key in the `profile` group.
  String get gender;

  /// The `male` key in the `profile` group.
  String get male;

  /// The `female` key in the `profile` group.
  String get female;

  /// The `number_of_family_members` key in the `profile` group.
  String get numberOfFamilyMembers;

  /// The `privacy_policy_agreement` key in the `profile` group.
  String get privacyPolicyAgreement;

  /// The `privacy_policy` key in the `profile` group.
  String get privacyPolicy;

  /// The `register` key in the `profile` group.
  String get register;

  /// The `update` key in the `profile` group.
  String get update;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NProfile<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `menu` group.
@immutable
abstract class I18NMenu<T extends I18N> extends L10N<I18NLocale> {
  const I18NMenu._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `avatar_hint` key in the `menu` group.
  String get avatarHint;

  /// The `close_hint` key in the `menu` group.
  String get closeHint;

  /// The `edit_hint` key in the `menu` group.
  String get editHint;

  /// The `menu` key in the `menu` group.
  String get menu;

  /// The `abonement` key in the `menu` group.
  String get abonement;

  /// The `individual` key in the `menu` group.
  String get individual;

  /// The `history` key in the `menu` group.
  String get history;

  /// The `statistics` key in the `menu` group.
  String get statistics;

  /// The `support` key in the `menu` group.
  String get support;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NMenu<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `settings` group.
@immutable
abstract class I18NSettings<T extends I18N> extends L10N<I18NLocale> {
  const I18NSettings._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `settings` key in the `settings` group.
  String get settings;

  /// The `language` group in the `settings` group.
  I18NSettingsLanguage<I18NSettings<I18N>> get language;

  /// The `theme` group in the `settings` group.
  I18NSettingsTheme<I18NSettings<I18N>> get theme;

  /// The `notification` group in the `settings` group.
  I18NSettingsNotification<I18NSettings<I18N>> get notification;

  /// The `about` group in the `settings` group.
  I18NSettingsAbout<I18NSettings<I18N>> get about;

  /// The `logout` key in the `settings` group.
  String get logout;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is I18NSettings<T> &&
          other.language == language &&
          other.theme == theme &&
          other.notification == notification &&
          other.about == about;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      language.hashCode ^
      theme.hashCode ^
      notification.hashCode ^
      about.hashCode;
}

/// The architecture of the `settings`/`language` group.
@immutable
abstract class I18NSettingsLanguage<T extends I18NSettings<I18N>>
    extends L10N<I18NLocale> {
  const I18NSettingsLanguage._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `language` key in the `settings`/`language` group.
  String get language;

  /// The `en_US` key in the `settings`/`language` group.
  String get enUs;

  /// The `uk_UA` key in the `settings`/`language` group.
  String get ukUa;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NSettingsLanguage<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `settings`/`theme` group.
@immutable
abstract class I18NSettingsTheme<T extends I18NSettings<I18N>>
    extends L10N<I18NLocale> {
  const I18NSettingsTheme._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `theme` key in the `settings`/`theme` group.
  String get theme;

  /// The `system` key in the `settings`/`theme` group.
  String get system;

  /// The `light` key in the `settings`/`theme` group.
  String get light;

  /// The `dark` key in the `settings`/`theme` group.
  String get dark;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NSettingsTheme<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `settings`/`notification` group.
@immutable
abstract class I18NSettingsNotification<T extends I18NSettings<I18N>>
    extends L10N<I18NLocale> {
  const I18NSettingsNotification._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `notification` key in the `settings`/`notification` group.
  String get notification;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NSettingsNotification<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `settings`/`about` group.
@immutable
abstract class I18NSettingsAbout<T extends I18NSettings<I18N>>
    extends L10N<I18NLocale> {
  const I18NSettingsAbout._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `about` key in the `settings`/`about` group.
  String get about;

  /// The `version` key in the `settings`/`about` group.
  String get version;

  /// The `privacy_policy` key in the `settings`/`about` group.
  String get privacyPolicy;

  /// The `terms_of_use` key in the `settings`/`about` group.
  String get termsOfUse;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NSettingsAbout<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `bonus` group.
@immutable
abstract class I18NBonus<T extends I18N> extends L10N<I18NLocale> {
  const I18NBonus._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `purchase` key in the `bonus` group.
  String get purchase;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NBonus<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `container` group.
@immutable
abstract class I18NContainer<T extends I18N> extends L10N<I18NLocale> {
  const I18NContainer._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `containers` key in the `container` group.
  String get containers;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NContainer<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The architecture of the `delivery` group.
@immutable
abstract class I18NDelivery<T extends I18N> extends L10N<I18NLocale> {
  const I18NDelivery._(super._, this.$);

  /// The parent of this group.
  final T $;

  /// The `delivery` key in the `delivery` group.
  String get delivery;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18NDelivery<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The instance of [EnUSI18N] locale.
const EnUSI18N enUSI18N = EnUSI18N._();

/// The [I18NLocale.enUS] root group.
@sealed
@immutable
class EnUSI18N extends I18N {
  const EnUSI18N._() : super._(I18NLocale.enUS);

  @override
  EnUSI18NMisc get misc => EnUSI18NMisc._(this);

  @override
  EnUSI18NAlert get alert => EnUSI18NAlert._(this);

  @override
  EnUSI18NPullToRefresh get pullToRefresh => EnUSI18NPullToRefresh._(this);

  @override
  EnUSI18NAuth get auth => EnUSI18NAuth._(this);

  @override
  EnUSI18NProfile get profile => EnUSI18NProfile._(this);

  @override
  EnUSI18NMenu get menu => EnUSI18NMenu._(this);

  @override
  EnUSI18NSettings get settings => EnUSI18NSettings._(this);

  @override
  EnUSI18NBonus get bonus => EnUSI18NBonus._(this);

  @override
  EnUSI18NContainer get container => EnUSI18NContainer._(this);

  @override
  EnUSI18NDelivery get delivery => EnUSI18NDelivery._(this);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is EnUSI18N &&
          other.misc == misc &&
          other.alert == alert &&
          other.pullToRefresh == pullToRefresh &&
          other.auth == auth &&
          other.profile == profile &&
          other.menu == menu &&
          other.settings == settings &&
          other.bonus == bonus &&
          other.container == container &&
          other.delivery == delivery;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      misc.hashCode ^
      alert.hashCode ^
      pullToRefresh.hashCode ^
      auth.hashCode ^
      profile.hashCode ^
      menu.hashCode ^
      settings.hashCode ^
      bonus.hashCode ^
      container.hashCode ^
      delivery.hashCode;
}

/// The [I18NLocale.enUS] `misc` group.
@sealed
@immutable
class EnUSI18NMisc extends I18NMisc<EnUSI18N> {
  const EnUSI18NMisc._(final EnUSI18N _) : super._(I18NLocale.enUS, _);

  @override
  String get prevPage => 'Back';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NMisc;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `alert` group.
@sealed
@immutable
class EnUSI18NAlert extends I18NAlert<EnUSI18N> {
  const EnUSI18NAlert._(final EnUSI18N _) : super._(I18NLocale.enUS, _);

  @override
  EnUSI18NAlertExit get exit => EnUSI18NAlertExit._(this);

  @override
  EnUSI18NAlertExitRegister get exitRegister =>
      EnUSI18NAlertExitRegister._(this);

  @override
  EnUSI18NAlertError get error => EnUSI18NAlertError._(this);

  @override
  EnUSI18NAlertSuccess get success => EnUSI18NAlertSuccess._(this);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is EnUSI18NAlert &&
          other.exit == exit &&
          other.exitRegister == exitRegister &&
          other.error == error &&
          other.success == success;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      exit.hashCode ^
      exitRegister.hashCode ^
      error.hashCode ^
      success.hashCode;
}

/// The [I18NLocale.enUS] `alert`/`exit` group.
@sealed
@immutable
class EnUSI18NAlertExit extends I18NAlertExit<EnUSI18NAlert> {
  const EnUSI18NAlertExit._(final EnUSI18NAlert _)
      : super._(I18NLocale.enUS, _);

  @override
  String get title => 'Are you sure you want to exit?';

  @override
  String get approve => 'Yes, have a good day';

  @override
  String get deny => 'No, I want to stay';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NAlertExit;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `alert`/`exit_register` group.
@sealed
@immutable
class EnUSI18NAlertExitRegister extends I18NAlertExitRegister<EnUSI18NAlert> {
  const EnUSI18NAlertExitRegister._(final EnUSI18NAlert _)
      : super._(I18NLocale.enUS, _);

  @override
  String get title => 'Are you sure you want to log out?';

  @override
  String get approve => 'Yes';

  @override
  String get deny => 'No';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NAlertExitRegister;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `alert`/`error` group.
@sealed
@immutable
class EnUSI18NAlertError extends I18NAlertError<EnUSI18NAlert> {
  const EnUSI18NAlertError._(final EnUSI18NAlert _)
      : super._(I18NLocale.enUS, _);

  @override
  String get title => 'Exception occured';

  @override
  String get body => 'Please, try again later.';

  @override
  String get approve => 'I understood';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NAlertError;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `alert`/`success` group.
@sealed
@immutable
class EnUSI18NAlertSuccess extends I18NAlertSuccess<EnUSI18NAlert> {
  const EnUSI18NAlertSuccess._(final EnUSI18NAlert _)
      : super._(I18NLocale.enUS, _);

  @override
  String get title => 'Success';

  @override
  String get body => 'Operation successfull.';

  @override
  String get approve => 'Okay, thanks';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NAlertSuccess;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `pull_to_refresh` group.
@sealed
@immutable
class EnUSI18NPullToRefresh extends I18NPullToRefresh<EnUSI18N> {
  const EnUSI18NPullToRefresh._(final EnUSI18N _) : super._(I18NLocale.enUS, _);

  @override
  String get idle => 'Тяни вниз чтобы обновить';

  @override
  String get release => 'Отпусти чтобы обновить';

  @override
  String get refreshing => 'Получаем свежие данные...';

  @override
  String get complete => 'Данные обновлены';

  @override
  String get completeInternetError => 'Проверьте интернет соединение!';

  @override
  String get error => 'Произошла ошибка';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NPullToRefresh;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `auth` group.
@sealed
@immutable
class EnUSI18NAuth extends I18NAuth<EnUSI18N> {
  const EnUSI18NAuth._(final EnUSI18N _) : super._(I18NLocale.enUS, _);

  @override
  String get support => 'Contact support';

  @override
  EnUSI18NAuthPhoneNumber get phoneNumber => EnUSI18NAuthPhoneNumber._(this);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is EnUSI18NAuth && other.phoneNumber == phoneNumber;

  @override
  int get hashCode => runtimeType.hashCode ^ phoneNumber.hashCode;
}

/// The [I18NLocale.enUS] `auth`/`phone_number` group.
@sealed
@immutable
class EnUSI18NAuthPhoneNumber extends I18NAuthPhoneNumber<EnUSI18NAuth> {
  const EnUSI18NAuthPhoneNumber._(final EnUSI18NAuth _)
      : super._(I18NLocale.enUS, _);

  @override
  String get enter => 'Enter your phone number';

  @override
  String get getCode => 'Get Code';

  @override
  String codeSent(final String phoneNumber) =>
      'Please enter the code which was send to the number $phoneNumber.';

  @override
  String get resendCodePrompt => "Didn't get the code?";

  @override
  String get resendCode => 'Resend Code';

  @override
  EnUSI18NAuthPhoneNumberPasteAlert get pasteAlert =>
      EnUSI18NAuthPhoneNumberPasteAlert._(this);

  @override
  EnUSI18NAuthPhoneNumberError get error =>
      EnUSI18NAuthPhoneNumberError._(this);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is EnUSI18NAuthPhoneNumber &&
          other.pasteAlert == pasteAlert &&
          other.error == error;

  @override
  int get hashCode =>
      runtimeType.hashCode ^ pasteAlert.hashCode ^ error.hashCode;
}

/// The [I18NLocale.enUS] `auth`/`phone_number`/`paste_alert` group.
@sealed
@immutable
class EnUSI18NAuthPhoneNumberPasteAlert
    extends I18NAuthPhoneNumberPasteAlert<EnUSI18NAuthPhoneNumber> {
  const EnUSI18NAuthPhoneNumberPasteAlert._(final EnUSI18NAuthPhoneNumber _)
      : super._(I18NLocale.enUS, _);

  @override
  String get title => 'Insert Code';

  @override
  String body(final int code) =>
      'Are you sure you want to paste this code $code?';

  @override
  String get approve => 'Yes';

  @override
  String get deny => 'No';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NAuthPhoneNumberPasteAlert;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `auth`/`phone_number`/`error` group.
@sealed
@immutable
class EnUSI18NAuthPhoneNumberError
    extends I18NAuthPhoneNumberError<EnUSI18NAuthPhoneNumber> {
  const EnUSI18NAuthPhoneNumberError._(final EnUSI18NAuthPhoneNumber _)
      : super._(I18NLocale.enUS, _);

  @override
  String get unknown => 'Exception occured.';

  @override
  String get invalid => 'Phone number is invalid.';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NAuthPhoneNumberError;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `profile` group.
@sealed
@immutable
class EnUSI18NProfile extends I18NProfile<EnUSI18N> {
  const EnUSI18NProfile._(final EnUSI18N _) : super._(I18NLocale.enUS, _);

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get firstName => 'First Name (required)';

  @override
  String get firstNameError => 'First Name is invalid.';

  @override
  String get lastName => 'Last Name';

  @override
  String get lastNameError => 'Last Name is invalid.';

  @override
  String get email => 'Email';

  @override
  String get emailError => 'Email is invalid.';

  @override
  String get birthday => 'Birthday (required)';

  @override
  String get birthdayConfirm => 'Confirm';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get numberOfFamilyMembers => 'Number of family members';

  @override
  String get privacyPolicyAgreement => 'I agree with';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get register => 'Register';

  @override
  String get update => 'Update';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NProfile;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `menu` group.
@sealed
@immutable
class EnUSI18NMenu extends I18NMenu<EnUSI18N> {
  const EnUSI18NMenu._(final EnUSI18N _) : super._(I18NLocale.enUS, _);

  @override
  String get avatarHint => 'Add avatar';

  @override
  String get closeHint => 'Close';

  @override
  String get editHint => 'Edit';

  @override
  String get menu => 'Menu';

  @override
  String get abonement => 'Abonement';

  @override
  String get individual => 'Individual';

  @override
  String get history => 'History';

  @override
  String get statistics => 'Statistics';

  @override
  String get support => 'Support';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NMenu;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `settings` group.
@sealed
@immutable
class EnUSI18NSettings extends I18NSettings<EnUSI18N> {
  const EnUSI18NSettings._(final EnUSI18N _) : super._(I18NLocale.enUS, _);

  @override
  String get settings => 'Settings';

  @override
  EnUSI18NSettingsLanguage get language => EnUSI18NSettingsLanguage._(this);

  @override
  EnUSI18NSettingsTheme get theme => EnUSI18NSettingsTheme._(this);

  @override
  EnUSI18NSettingsNotification get notification =>
      EnUSI18NSettingsNotification._(this);

  @override
  EnUSI18NSettingsAbout get about => EnUSI18NSettingsAbout._(this);

  @override
  String get logout => 'Log Out';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is EnUSI18NSettings &&
          other.language == language &&
          other.theme == theme &&
          other.notification == notification &&
          other.about == about;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      language.hashCode ^
      theme.hashCode ^
      notification.hashCode ^
      about.hashCode;
}

/// The [I18NLocale.enUS] `settings`/`language` group.
@sealed
@immutable
class EnUSI18NSettingsLanguage extends I18NSettingsLanguage<EnUSI18NSettings> {
  const EnUSI18NSettingsLanguage._(final EnUSI18NSettings _)
      : super._(I18NLocale.enUS, _);

  @override
  String get language => 'Language';

  @override
  String get enUs => 'English';

  @override
  String get ukUa => 'Ukrainian';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NSettingsLanguage;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `settings`/`theme` group.
@sealed
@immutable
class EnUSI18NSettingsTheme extends I18NSettingsTheme<EnUSI18NSettings> {
  const EnUSI18NSettingsTheme._(final EnUSI18NSettings _)
      : super._(I18NLocale.enUS, _);

  @override
  String get theme => 'Theme';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NSettingsTheme;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `settings`/`notification` group.
@sealed
@immutable
class EnUSI18NSettingsNotification
    extends I18NSettingsNotification<EnUSI18NSettings> {
  const EnUSI18NSettingsNotification._(final EnUSI18NSettings _)
      : super._(I18NLocale.enUS, _);

  @override
  String get notification => 'Notifications';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NSettingsNotification;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `settings`/`about` group.
@sealed
@immutable
class EnUSI18NSettingsAbout extends I18NSettingsAbout<EnUSI18NSettings> {
  const EnUSI18NSettingsAbout._(final EnUSI18NSettings _)
      : super._(I18NLocale.enUS, _);

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NSettingsAbout;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `bonus` group.
@sealed
@immutable
class EnUSI18NBonus extends I18NBonus<EnUSI18N> {
  const EnUSI18NBonus._(final EnUSI18N _) : super._(I18NLocale.enUS, _);

  @override
  String get purchase => 'Swap';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NBonus;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `container` group.
@sealed
@immutable
class EnUSI18NContainer extends I18NContainer<EnUSI18N> {
  const EnUSI18NContainer._(final EnUSI18N _) : super._(I18NLocale.enUS, _);

  @override
  String get containers => 'Containers';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NContainer;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.enUS] `delivery` group.
@sealed
@immutable
class EnUSI18NDelivery extends I18NDelivery<EnUSI18N> {
  const EnUSI18NDelivery._(final EnUSI18N _) : super._(I18NLocale.enUS, _);

  @override
  String get delivery => 'Delivery';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is EnUSI18NDelivery;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The instance of [UkUAI18N] locale.
const UkUAI18N ukUAI18N = UkUAI18N._();

/// The [I18NLocale.ukUA] root group.
@sealed
@immutable
class UkUAI18N extends I18N {
  const UkUAI18N._() : super._(I18NLocale.ukUA);

  @override
  UkUAI18NMisc get misc => UkUAI18NMisc._(this);

  @override
  UkUAI18NAlert get alert => UkUAI18NAlert._(this);

  @override
  UkUAI18NPullToRefresh get pullToRefresh => UkUAI18NPullToRefresh._(this);

  @override
  UkUAI18NAuth get auth => UkUAI18NAuth._(this);

  @override
  UkUAI18NProfile get profile => UkUAI18NProfile._(this);

  @override
  UkUAI18NMenu get menu => UkUAI18NMenu._(this);

  @override
  UkUAI18NSettings get settings => UkUAI18NSettings._(this);

  @override
  UkUAI18NBonus get bonus => UkUAI18NBonus._(this);

  @override
  UkUAI18NContainer get container => UkUAI18NContainer._(this);

  @override
  UkUAI18NDelivery get delivery => UkUAI18NDelivery._(this);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is UkUAI18N &&
          other.misc == misc &&
          other.alert == alert &&
          other.pullToRefresh == pullToRefresh &&
          other.auth == auth &&
          other.profile == profile &&
          other.menu == menu &&
          other.settings == settings &&
          other.bonus == bonus &&
          other.container == container &&
          other.delivery == delivery;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      misc.hashCode ^
      alert.hashCode ^
      pullToRefresh.hashCode ^
      auth.hashCode ^
      profile.hashCode ^
      menu.hashCode ^
      settings.hashCode ^
      bonus.hashCode ^
      container.hashCode ^
      delivery.hashCode;
}

/// The [I18NLocale.ukUA] `misc` group.
@sealed
@immutable
class UkUAI18NMisc extends I18NMisc<UkUAI18N> {
  const UkUAI18NMisc._(final UkUAI18N _) : super._(I18NLocale.ukUA, _);

  @override
  String get prevPage => 'Назад';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NMisc;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `alert` group.
@sealed
@immutable
class UkUAI18NAlert extends I18NAlert<UkUAI18N> {
  const UkUAI18NAlert._(final UkUAI18N _) : super._(I18NLocale.ukUA, _);

  @override
  UkUAI18NAlertExit get exit => UkUAI18NAlertExit._(this);

  @override
  UkUAI18NAlertExitRegister get exitRegister =>
      UkUAI18NAlertExitRegister._(this);

  @override
  UkUAI18NAlertError get error => UkUAI18NAlertError._(this);

  @override
  UkUAI18NAlertSuccess get success => UkUAI18NAlertSuccess._(this);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is UkUAI18NAlert &&
          other.exit == exit &&
          other.exitRegister == exitRegister &&
          other.error == error &&
          other.success == success;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      exit.hashCode ^
      exitRegister.hashCode ^
      error.hashCode ^
      success.hashCode;
}

/// The [I18NLocale.ukUA] `alert`/`exit` group.
@sealed
@immutable
class UkUAI18NAlertExit extends I18NAlertExit<UkUAI18NAlert> {
  const UkUAI18NAlertExit._(final UkUAI18NAlert _)
      : super._(I18NLocale.ukUA, _);

  @override
  String get title => 'Ви впевнені що хочете вийти?';

  @override
  String get approve => 'Так, гарного дня';

  @override
  String get deny => 'Ні, я хочу залишитися';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NAlertExit;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `alert`/`exit_register` group.
@sealed
@immutable
class UkUAI18NAlertExitRegister extends I18NAlertExitRegister<UkUAI18NAlert> {
  const UkUAI18NAlertExitRegister._(final UkUAI18NAlert _)
      : super._(I18NLocale.ukUA, _);

  @override
  String get title => 'Ви впевнені що хочете вийти з аккаунту?';

  @override
  String get approve => 'Так';

  @override
  String get deny => 'Ні';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NAlertExitRegister;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `alert`/`error` group.
@sealed
@immutable
class UkUAI18NAlertError extends I18NAlertError<UkUAI18NAlert> {
  const UkUAI18NAlertError._(final UkUAI18NAlert _)
      : super._(I18NLocale.ukUA, _);

  @override
  String get title => 'Сталася помилка';

  @override
  String get body => 'Будь ласка, спробуйте ще раз пізніше.';

  @override
  String get approve => 'Я зрозумів';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NAlertError;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `alert`/`success` group.
@sealed
@immutable
class UkUAI18NAlertSuccess extends I18NAlertSuccess<UkUAI18NAlert> {
  const UkUAI18NAlertSuccess._(final UkUAI18NAlert _)
      : super._(I18NLocale.ukUA, _);

  @override
  String get title => 'Успіх';

  @override
  String get body => 'Операція пройшла успішно.';

  @override
  String get approve => 'Дякую';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NAlertSuccess;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `pull_to_refresh` group.
@sealed
@immutable
class UkUAI18NPullToRefresh extends I18NPullToRefresh<UkUAI18N> {
  const UkUAI18NPullToRefresh._(final UkUAI18N _) : super._(I18NLocale.ukUA, _);

  @override
  String get idle => 'Тяни вниз чтобы обновить';

  @override
  String get release => 'Отпусти чтобы обновить';

  @override
  String get refreshing => 'Получаем свежие данные...';

  @override
  String get complete => 'Данные обновлены';

  @override
  String get completeInternetError => 'Проверьте интернет соединение!';

  @override
  String get error => 'Произошла ошибка';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NPullToRefresh;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `auth` group.
@sealed
@immutable
class UkUAI18NAuth extends I18NAuth<UkUAI18N> {
  const UkUAI18NAuth._(final UkUAI18N _) : super._(I18NLocale.ukUA, _);

  @override
  String get support => "Зв'язатися з підтримкою";

  @override
  UkUAI18NAuthPhoneNumber get phoneNumber => UkUAI18NAuthPhoneNumber._(this);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is UkUAI18NAuth && other.phoneNumber == phoneNumber;

  @override
  int get hashCode => runtimeType.hashCode ^ phoneNumber.hashCode;
}

/// The [I18NLocale.ukUA] `auth`/`phone_number` group.
@sealed
@immutable
class UkUAI18NAuthPhoneNumber extends I18NAuthPhoneNumber<UkUAI18NAuth> {
  const UkUAI18NAuthPhoneNumber._(final UkUAI18NAuth _)
      : super._(I18NLocale.ukUA, _);

  @override
  String get enter => 'Введіть ваш номер телефону';

  @override
  String get getCode => 'Отримати код';

  @override
  String codeSent(final String phoneNumber) =>
      'Введіть код, який був відправлений на номер $phoneNumber.';

  @override
  String get resendCodePrompt => 'Код не прийшов?';

  @override
  String get resendCode => 'Спробуйте ще';

  @override
  UkUAI18NAuthPhoneNumberPasteAlert get pasteAlert =>
      UkUAI18NAuthPhoneNumberPasteAlert._(this);

  @override
  UkUAI18NAuthPhoneNumberError get error =>
      UkUAI18NAuthPhoneNumberError._(this);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is UkUAI18NAuthPhoneNumber &&
          other.pasteAlert == pasteAlert &&
          other.error == error;

  @override
  int get hashCode =>
      runtimeType.hashCode ^ pasteAlert.hashCode ^ error.hashCode;
}

/// The [I18NLocale.ukUA] `auth`/`phone_number`/`paste_alert` group.
@sealed
@immutable
class UkUAI18NAuthPhoneNumberPasteAlert
    extends I18NAuthPhoneNumberPasteAlert<UkUAI18NAuthPhoneNumber> {
  const UkUAI18NAuthPhoneNumberPasteAlert._(final UkUAI18NAuthPhoneNumber _)
      : super._(I18NLocale.ukUA, _);

  @override
  String get title => 'Вставити код';

  @override
  String body(final int code) =>
      'Ви впевнені що хочете вставити цей код $code?';

  @override
  String get approve => 'Так';

  @override
  String get deny => 'Ні';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NAuthPhoneNumberPasteAlert;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `auth`/`phone_number`/`error` group.
@sealed
@immutable
class UkUAI18NAuthPhoneNumberError
    extends I18NAuthPhoneNumberError<UkUAI18NAuthPhoneNumber> {
  const UkUAI18NAuthPhoneNumberError._(final UkUAI18NAuthPhoneNumber _)
      : super._(I18NLocale.ukUA, _);

  @override
  String get unknown => 'Сталася помилка.';

  @override
  String get invalid => 'Номер телефону не дійсний.';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NAuthPhoneNumberError;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `profile` group.
@sealed
@immutable
class UkUAI18NProfile extends I18NProfile<UkUAI18N> {
  const UkUAI18NProfile._(final UkUAI18N _) : super._(I18NLocale.ukUA, _);

  @override
  String get phoneNumber => 'Номер телефону';

  @override
  String get firstName => "Ім'я (обов'язково)";

  @override
  String get firstNameError => "Ім'я некорректне.";

  @override
  String get lastName => 'Прізвище';

  @override
  String get lastNameError => 'Прізвище некорректне.';

  @override
  String get email => 'Email';

  @override
  String get emailError => 'Це некорректний email.';

  @override
  String get birthday => "День народження (обов'язково)";

  @override
  String get birthdayConfirm => 'Підтвердити';

  @override
  String get gender => 'Стать';

  @override
  String get male => 'Чоловіча';

  @override
  String get female => 'Жіноча';

  @override
  String get numberOfFamilyMembers => 'Кількість членів родини';

  @override
  String get privacyPolicyAgreement => 'Я згоден (на) з Умовами надання послуг';

  @override
  String get privacyPolicy => 'Типової оферти';

  @override
  String get register => 'Зареєструватися';

  @override
  String get update => 'Поновити дані';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NProfile;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `menu` group.
@sealed
@immutable
class UkUAI18NMenu extends I18NMenu<UkUAI18N> {
  const UkUAI18NMenu._(final UkUAI18N _) : super._(I18NLocale.ukUA, _);

  @override
  String get avatarHint => 'Додати аватар';

  @override
  String get closeHint => 'Закрити';

  @override
  String get editHint => 'Відредагувати';

  @override
  String get menu => 'Меню';

  @override
  String get abonement => 'Абонемент';

  @override
  String get individual => 'Індивідуальні';

  @override
  String get history => 'Історія';

  @override
  String get statistics => 'Статистика';

  @override
  String get support => 'Підтримка';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NMenu;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `settings` group.
@sealed
@immutable
class UkUAI18NSettings extends I18NSettings<UkUAI18N> {
  const UkUAI18NSettings._(final UkUAI18N _) : super._(I18NLocale.ukUA, _);

  @override
  String get settings => 'Налаштування';

  @override
  UkUAI18NSettingsLanguage get language => UkUAI18NSettingsLanguage._(this);

  @override
  UkUAI18NSettingsTheme get theme => UkUAI18NSettingsTheme._(this);

  @override
  UkUAI18NSettingsNotification get notification =>
      UkUAI18NSettingsNotification._(this);

  @override
  UkUAI18NSettingsAbout get about => UkUAI18NSettingsAbout._(this);

  @override
  String get logout => 'Вийти';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is UkUAI18NSettings &&
          other.language == language &&
          other.theme == theme &&
          other.notification == notification &&
          other.about == about;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      language.hashCode ^
      theme.hashCode ^
      notification.hashCode ^
      about.hashCode;
}

/// The [I18NLocale.ukUA] `settings`/`language` group.
@sealed
@immutable
class UkUAI18NSettingsLanguage extends I18NSettingsLanguage<UkUAI18NSettings> {
  const UkUAI18NSettingsLanguage._(final UkUAI18NSettings _)
      : super._(I18NLocale.ukUA, _);

  @override
  String get language => 'Мова';

  @override
  String get enUs => 'Англійська';

  @override
  String get ukUa => 'Українська';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NSettingsLanguage;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `settings`/`theme` group.
@sealed
@immutable
class UkUAI18NSettingsTheme extends I18NSettingsTheme<UkUAI18NSettings> {
  const UkUAI18NSettingsTheme._(final UkUAI18NSettings _)
      : super._(I18NLocale.ukUA, _);

  @override
  String get theme => 'Тема';

  @override
  String get system => 'Системна';

  @override
  String get light => 'Світла';

  @override
  String get dark => 'Темна';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NSettingsTheme;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `settings`/`notification` group.
@sealed
@immutable
class UkUAI18NSettingsNotification
    extends I18NSettingsNotification<UkUAI18NSettings> {
  const UkUAI18NSettingsNotification._(final UkUAI18NSettings _)
      : super._(I18NLocale.ukUA, _);

  @override
  String get notification => 'Повідомлення';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NSettingsNotification;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `settings`/`about` group.
@sealed
@immutable
class UkUAI18NSettingsAbout extends I18NSettingsAbout<UkUAI18NSettings> {
  const UkUAI18NSettingsAbout._(final UkUAI18NSettings _)
      : super._(I18NLocale.ukUA, _);

  @override
  String get about => 'Про додаток';

  @override
  String get version => 'Версія';

  @override
  String get privacyPolicy => 'Політика конфіденційності';

  @override
  String get termsOfUse => 'Правила користування';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NSettingsAbout;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `bonus` group.
@sealed
@immutable
class UkUAI18NBonus extends I18NBonus<UkUAI18N> {
  const UkUAI18NBonus._(final UkUAI18N _) : super._(I18NLocale.ukUA, _);

  @override
  String get purchase => 'Купити';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NBonus;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `container` group.
@sealed
@immutable
class UkUAI18NContainer extends I18NContainer<UkUAI18N> {
  const UkUAI18NContainer._(final UkUAI18N _) : super._(I18NLocale.ukUA, _);

  @override
  String get containers => 'Сортомати';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NContainer;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The [I18NLocale.ukUA] `delivery` group.
@sealed
@immutable
class UkUAI18NDelivery extends I18NDelivery<UkUAI18N> {
  const UkUAI18NDelivery._(final UkUAI18N _) : super._(I18NLocale.ukUA, _);

  @override
  String get delivery => 'Курʼєр';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is UkUAI18NDelivery;

  @override
  int get hashCode => runtimeType.hashCode;
}
