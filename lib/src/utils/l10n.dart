import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

@immutable
abstract class L10N<T extends Enum> {
  const L10N(this._);
  final T _;

  String plural(
    final num howMany, {
    final String? other,
    final String? zero,
    final String? one,
    final String? two,
    final String? few,
    final String? many,
    final int? precision,
  }) =>
      Intl.pluralLogic<String>(
        howMany,
        other: other ?? '',
        zero: zero,
        one: one,
        two: two,
        few: few,
        many: many,
        locale: _.name,
      );
}
