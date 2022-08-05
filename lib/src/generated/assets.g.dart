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

  /// The path to the `logo.png` in `source`/`assets`.
  String get logo => 'source/assets/logo.png';

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is Assets;

  @override
  int get hashCode => runtimeType.hashCode;
}
