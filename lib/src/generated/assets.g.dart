// ignore_for_file: missing_whitespace_between_adjacent_strings

/// This file is used for `source/assets` folder file structure generation.
///
/// Modify this file at your own risk!
///
/// See: https://pub.dev/packages/generators#assets-generator
///
import 'package:meta/meta.dart';

/// This is a generated file structure of the `source`/`assets` folder.
///
/// See: https://pub.dev/packages/generators#icon-fonts-generator
const Assets assets = Assets._();

/// The file structure of the `source`/`assets` folder.
@sealed
@immutable
class Assets {
  const Assets._();

  /// The path to the `container.png` in `source`/`assets`.
  String get container => 'source/assets/container.png';

  /// The path to the `countries` folder in `source`/`assets`.
  AssetsCountries get countries => AssetsCountries._(this);

  /// The path to the `delivery.png` in `source`/`assets`.
  String get delivery => 'source/assets/delivery.png';

  /// The path to the `ecocoin.png` in `source`/`assets`.
  String get ecocoin => 'source/assets/ecocoin.png';

  /// The path to the `logo.png` in `source`/`assets`.
  String get logo => 'source/assets/logo.png';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is Assets && other.countries == countries;

  @override
  int get hashCode => runtimeType.hashCode ^ countries.hashCode;
}

/// The file structure of the `source`/`assets`/`countries` folder.
@sealed
@immutable
class AssetsCountries {
  const AssetsCountries._(final Assets _);

  /// The path to the `england.png` in `source`/`assets`/`countries`.
  String get england => 'source/assets/countries/england.png';

  /// The path to the `ukraine.png` in `source`/`assets`/`countries`.
  String get ukraine => 'source/assets/countries/ukraine.png';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is AssetsCountries;

  @override
  int get hashCode => runtimeType.hashCode;
}
