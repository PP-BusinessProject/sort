import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_converters_lite/json_converters_lite.dart';

/// The interface to [save] the data.
abstract class HiveNotifierInterface<T extends Object?, S extends Object?>
    extends StateNotifier<T> {
  /// The interface to [save] the data.
  HiveNotifierInterface(
    super._, {
    required final this.key,
    required final this.converter,
  });

  /// The key of this iterable to save in the database.
  final String key;

  /// The converter to serialize the item.
  final JsonConverter<T?, S?> converter;

  /// Save the data to the database.
  FutureOr<void> save();

  /// Delete the data from the database.
  FutureOr<void> delete();

  /// Set the current state and update value asynchronously.
  Future<void> setStateAsync(final T state);
}

/// The notifier that automatically saves its [state] to the [_hive] database.
class HiveNotifier<T extends Object?, S extends Object?>
    extends StateNotifier<T> implements HiveNotifierInterface<T, S> {
  /// The notifier that returns a default value from the [_hive] database.
  HiveNotifier(
    this._hive, {
    required final this.key,
    required final this.converter,
    required final this.initialValue,
    final T? Function(T)? onValue,
  }) : super(
          () {
            T value = initialValue;
            if (_hive.containsKey(key)) {
              final S? $value = _hive.get(key);
              if ($value != null) {
                value = converter.fromJson($value);
              }
            }
            return onValue?.call(value) ?? value;
          }(),
        );

  /// The reference to the [Hive] database.
  final Box<S> _hive;

  @override
  final String key;

  @override
  final JsonConverter<T, S> converter;

  /// The default value of this notifier.
  final T initialValue;

  @override
  Future<void> save() => _hive.put(key, converter.toJson(state));

  @override
  Future<void> delete() async {
    try {
      super.state = initialValue;
    } finally {
      await _hive.delete(key);
    }
  }

  @override
  set state(final T state) {
    try {
      super.state = state;
    } finally {
      save();
    }
  }

  @override
  T get state => super.state;

  @override
  Future<void> setStateAsync(final T state) async {
    try {
      super.state = state;
    } finally {
      await save();
    }
  }
}

/// The notifier that automatically saves its [state] to the [_hive] database.
///
/// Can also have a nullable [state].
class HiveOptionalNotifier<T extends Object?, S extends Object?>
    extends HiveNotifier<T?, S> {
  /// The notifier that automatically saves its [state] to the [_hive] database.
  ///
  /// Can also have a nullable [state].
  HiveOptionalNotifier(
    super._, {
    required final super.key,
    required final super.converter,
    final super.initialValue,
    final super.onValue,
  });
}

/// The notifier that automatically saves its [state] to the [_hive] database.
class HiveIterableNotifier<T extends Object?, S extends Object?>
    extends HiveNotifier<Iterable<T>, S> {
  /// The notifier that automatically saves its [state] to the [_hive] database.
  ///
  /// If value does not exist, returns the default value.
  HiveIterableNotifier(
    super._, {
    required final super.key,
    required final super.converter,
    required final super.initialValue,
    final super.onValue,
  });

  /// Add an [item] to this notifier.
  Future<void> add(final T item) => setStateAsync(<T>[...state, item]);

  /// Add [items] to this notifier.
  Future<void> addAll(final Iterable<T> items) =>
      setStateAsync(<T>[...state, ...items]);

  /// Remove an [item] from this notifier.
  Future<void> remove(final T item) => setStateAsync(<T>[
        for (final T $item in state)
          if ($item != item) $item
      ]);

  /// Remove everything from this notifier.
  Future<void> clear() => setStateAsync(Iterable<T>.empty());
}
