/// This file is used for `Icon Font` structure generation.
///
/// Modify this file at your own risk!
///
/// See: https://pub.dev/packages/generators#icon-fonts-generator
///
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// This is a generated structure of an Icon Font.
///
/// See: https://pub.dev/packages/generators#icon-fonts-generator
const Icons icons = Icons._();

/// The file structure of the `source/icons` folder.
@sealed
@immutable
class Icons {
  const Icons._();

  /// The [IconData] of the `notification.svg` in `source/icons`.
  IconData get notification => const IconData(0xf101, fontFamily: 'Icons');

  /// The [IconData] of the `person.svg` in `source/icons`.
  IconData get person => const IconData(0xf102, fontFamily: 'Icons');

  /// The `test` folder in `source/icons`.
  IconsTest get test => IconsTest._(this);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is Icons && other.test == test;

  @override
  int get hashCode => runtimeType.hashCode ^ test.hashCode;
}

/// The file structure of the `source/icons/test` folder.
@sealed
@immutable
class IconsTest {
  const IconsTest._(final Icons _);

  /// The [IconData] of the `close.svg` in `source/icons/test`.
  IconData get close => const IconData(0xf103, fontFamily: 'Icons');

  /// The [IconData] of the `edit.svg` in `source/icons/test`.
  IconData get edit => const IconData(0xf104, fontFamily: 'Icons');

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is IconsTest;

  @override
  int get hashCode => runtimeType.hashCode;
}
