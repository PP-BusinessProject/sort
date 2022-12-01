import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class I18N {
  const I18N._({required this.misc});

  /// The `misc` group in the root group.
  final I18NMisc misc;

  factory I18N.fromMap(final Map<String, Object?> map) => I18N._(
        misc: I18NMisc.fromMap(
          map['misc'] is Map<String, Object?>
              ? map['misc']! as Map<String, Object?>
              : <String, Object?>{},
        ),
      );

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) || other is I18N && other.misc == misc;

  @override
  int get hashCode => misc.hashCode;
}

/// The architecture of the `misc` group.
@immutable
class I18NMisc {
  const I18NMisc._({
    required this.flex,
    required this.prevPage,
  });

  /// The `prev_page` key in the `misc` group.
  final String prevPage;

  /// The `prev_page` key in the `misc` group.
  final String Function(int index, {required String f}) flex;

  factory I18NMisc.fromMap(final Map<String, Object?> map) => I18NMisc._(
        prevPage: map['prev_page'] is String ? map['prev_page']! as String : '',
        flex: (final int index, {required final String f}) =>
            map['flex'] is String
                ? (map['flex']! as String).splitMapJoin(
                    RegExp(r'(?<!\\)\$(?:([\w]+)|\{(.+?)\})'),
                    onMatch: (final Match match) {
                      switch (match[2] ?? match[1]) {
                        case 'index':
                          return index.toString();
                        case 'f':
                          return f;
                        default:
                          return match[0]!;
                      }
                    },
                  )
                : 'sdfjhdskjfhsdkl $index',
      );

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is I18NMisc && other.prevPage == prevPage && other.flex == flex;

  @override
  int get hashCode => prevPage.hashCode ^ flex.hashCode;
}
