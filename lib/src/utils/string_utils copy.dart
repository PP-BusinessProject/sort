/// Source: https://github.com/hexrcs/quartet_dart/tree/master/lib/src/case
extension StringCase on String {
  static final RegExp _dartNamePattern =
      RegExp(r'(?!\d)[$\da-z]+|[_]+$', caseSensitive: false);

  /// The parts of the dart name.
  List<String> parts([final Pattern? pattern]) => <String>[
        for (final Match m in (pattern ?? _dartNamePattern).allMatches(this))
          m.group(0)!.toLowerCase(),
      ];

  /// Converts all characters of this string to camel case.
  ///
  /// Example:
  /// ```dart
  /// "dart lang".toCamelCase() // will return "dartLang"
  /// ```
  String toCamelCase() {
    final List<String> splitted = parts();
    if (splitted.isEmpty) {
      return '';
    }
    return splitted.first.toLowerCase() +
        splitted.sublist(1).map((final String x) => x.capitalize()).join();
  }

  /// Converts the first character of this string to upper case.
  ///
  /// If [lowerRest] is set to true, the rest of the string will be converted
  /// to lower case.
  ///
  /// Example:
  /// ```dart
  /// "dartLang".capitalize(lowerRest: true) // will return "Dartlang"
  /// "dartLang".capitalize() // will return "DartLang"
  /// ```
  String capitalize({final bool lowerRest = false}) {
    if (isEmpty) {
      return '';
    } else if (lowerRest) {
      return this[0].toUpperCase() + substring(1).toLowerCase();
    } else {
      return this[0].toUpperCase() + substring(1);
    }
  }

  /// Converts the first character of this string to lower case.
  ///
  /// Example:
  /// ```dart
  /// "DartLang".decapitalize() // will return "dartLang"
  /// ```
  String decapitalize() => isEmpty ? '' : this[0].toLowerCase() + substring(1);

  /// Converts all characters of this string to kebab case, aka *spinal case*
  /// or *lisp case*.
  ///
  /// Example:
  /// ```dart
  /// "dart Lang".toKebabCase() // will return "dart-lang"
  /// ```
  String toKebabCase() => parts().join('-').toLowerCase();

  /// Converts all characters of this string to snake case.
  ///
  /// Example:
  /// ```dart
  /// "dart Lang".toSnakeCase() // will return "dart_lang"
  /// ```
  String toSnakeCase() => parts().join('_').toLowerCase();

  /// Converts all lower case characters of this string to upper case and all
  /// upper case characters to lower case.
  ///
  /// Example:
  /// ```dart
  /// "dartLang".swapCase() // will return "DARTlANG"
  /// ```
  String toSwapCase() => split('').map((final String char) {
        /// Swap so that characters that don't have the concept of cases will
        /// not be altered.
        final String lowerCaseChar = char.toLowerCase();
        return char == lowerCaseChar ? char.toUpperCase() : lowerCaseChar;
      }).join();

  /// Converts all characters of this string to title case.
  ///
  /// Optional [separators] characters which will be used to join a word.
  ///
  /// Example:
  /// ```dart
  /// "dart lang".toTitleCase() // will return "Dart Lang"
  /// "jean-luc is good-looking".toTitleCase(["-"]) // will return "Jean-luc Is Good-looking"
  /// "jean-luc is good-looking".toTitleCase() // will return "Jean-Luc Is Good-Looking"
  /// ```
  String toTitleCase([
    final Iterable<String> separators = const Iterable<String>.empty(),
  ]) {
    int index = 0;
    return replaceAllMapped(_dartNamePattern, (final Match match) {
      final String string = match[0]!;
      index = indexOf(string, index);
      if (index >= 1 && separators.contains(this[index - 1])) {
        index += string.length;
        return string.toLowerCase();
      } else {
        index += string.length;
        return string.capitalize();
      }
    });
  }
}

/// Source: https://github.com/hexrcs/quartet_dart/tree/master/lib/src/chop
extension StringChop on String {
  /// Access a character from this string at specified [position].
  ///
  /// If [position] is negative, `-1` refers to the last index, `-2` refers to
  /// the second last index and so on. If [position] is out of bound an empty
  /// string will be returned.
  ///
  /// Example:
  /// ```dart
  /// expect('Dart'.charAt(0), 'D');
  /// expect('Dart'.charAt(-1), 't');
  /// expect('Dart'.charAt(5), '');
  /// ```
  ///
  String charAt(final int position) {
    if (length <= position || length + position < 0) {
      return '';
    }
    return this[position < 0 ? length + position : position];
  }

  /// Get the Unicode code point value of the character at [position]. For a
  /// character outside the Basic Multilingual Plane (plane 0) that is composed
  /// of a surrogate pair, its combined value, an astral code point, will be
  /// returned.
  ///
  /// If [position] is negative, `-1` refers to the last index, `-2` refers to
  /// the second last index and so on. If [position] is out of bound `null`
  /// will be returned.
  ///
  /// Example:
  /// ```dart
  /// expect('Dart'.codePointAt(0), 68);
  /// expect('Dart'.codePointAt(-1), 116);
  /// expect('Dart'.codePointAt(5), null);
  /// ```
  int? codePointAt(final int position) {
    final String char = runesAt(position);
    return char.isEmpty ? null : char.runes.first;
  }

  /// Access a character (may be composed of a surrogate pair) from this string
  /// at specified [position].
  ///
  /// If [position] is negative, `-1` refers to the last index, `-2` refers to
  /// the second last index and so on. If [position] is out of bound an empty
  /// string will be returned.
  ///
  /// Example:
  /// ```dart
  /// expect('Dart'.runesAt(0), 'D');
  /// expect('Dart'.runesAt(-1), 't');
  /// expect('Dart'.runesAt(5), '');
  /// ```
  String runesAt(final int position) {
    if (runes.length <= position || runes.length + position < 0) {
      return '';
    }
    final int runePosition = position < 0 ? runes.length + position : position;
    return String.fromCharCode(runes.elementAt(runePosition));
  }
}
