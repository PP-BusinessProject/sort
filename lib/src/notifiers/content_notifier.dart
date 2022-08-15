import 'dart:async';

import 'package:riverpod/riverpod.dart';

import '../api.dart';

/// The callback on refresh of the [ContentNotifier].
typedef ContentListener = FutureOr<void> Function();

/// The callback on completed refresh of the [ContentNotifier].
typedef ContentCallback = FutureOr<void> Function(bool success);

/// Refresh the state with a callback.
mixin RefreshListener<T extends Object?> {
  /// The callback to refresh a state of this provider.
  FutureOr<T> Function() get refreshState;

  Completer<bool> _isRefreshingCompleter = Completer<bool>()..complete(false);
  Iterable<ContentListener> _onRefreshListeners =
      const Iterable<ContentListener>.empty();
  Iterable<ContentCallback> _onRefreshCallbacks =
      const Iterable<ContentCallback>.empty();

  /// Add the [listener] to the [refresh] function.
  void addRefreshListener(final ContentListener listener) {
    _onRefreshListeners = <ContentListener>[..._onRefreshListeners, listener];
  }

  /// Remove the [listener] on the [refresh] function.
  void removeRefreshListener(final ContentListener listener) {
    _onRefreshListeners = <ContentListener>[
      for (final ContentListener $listener in _onRefreshListeners)
        if ($listener != listener) $listener
    ];
  }

  /// Add the [callback] to the completion of the [refresh] function.
  void addRefreshCallback(final ContentCallback callback) {
    _onRefreshCallbacks = <ContentCallback>[..._onRefreshCallbacks, callback];
  }

  /// Remove the [callback] on the completion of the [refresh] function.
  void removeRefreshCallback(final ContentCallback callback) {
    _onRefreshCallbacks = <ContentCallback>[
      for (final ContentCallback $callback in _onRefreshCallbacks)
        if ($callback != callback) $callback
    ];
  }

  /// If this RefreshContent is currently calling [refresh].
  bool get isRefreshing => !_isRefreshingCompleter.isCompleted;

  /// Wait until this RefreshContent completes a refresh.
  Future<bool> waitUntilRefreshed() => _isRefreshingCompleter.future;

  /// Refresh this state with a callback.
  Future<bool> refresh() async {
    if (!_isRefreshingCompleter.isCompleted) {
      return waitUntilRefreshed();
    }
    _isRefreshingCompleter = Completer<bool>();
    bool success = false;
    try {
      final Iterable<FutureOr<void>> futures = <FutureOr<void>>[
        for (final ContentListener listener in _onRefreshListeners) listener()
      ];
      await Future.wait<void>(futures.whereType<Future<void>>());
    } finally {
      try {
        success = await refreshState() != null;
      } finally {
        try {
          final Iterable<FutureOr<void>> futures = <FutureOr<void>>[
            for (final ContentCallback callback in _onRefreshCallbacks)
              callback(success)
          ];
          await Future.wait<void>(futures.whereType<Future<void>>());
        } finally {
          _isRefreshingCompleter.complete(success);
        }
      }
    }
    return success;
  }
}

/// The provider of content in the external API.
class ContentNotifier<T extends Object> extends StateNotifier<Iterable<T>>
    with RefreshListener<Iterable<T>> {
  /// The provider of content in the external API.
  ///
  /// - **`refreshInterval`** The interval for automatic refreshing of the state
  /// of this RefreshContent.
  ContentNotifier({
    required final FutureOr<Iterable<T>> Function() refreshState,
    final Stream<StreamEvent<Iterable<T>>>? stream,
    final Duration refreshInterval = Duration.zero,
  }) : super(<T>[]) {
    stream?.listen((final StreamEvent<Iterable<T>> event) async {
      if (event.prevValue.isNotEmpty) {
        removeAll(event.prevValue);
      }
      if (event.value.isNotEmpty) {
        addAll(event.value);
      }
    });
    this.refreshState = () async => state = await refreshState();
    if (refreshInterval != Duration.zero) {
      Timer.periodic(refreshInterval, (final _) => refresh());
    } else {
      refresh();
    }
  }

  @override
  late final FutureOr<Iterable<T>> Function() refreshState;

  /// Add an [item] to this notifier.
  void add(final T item) => state = <T>[...state, item];

  /// Add [items] to this notifier.
  void addAll(final Iterable<T> items) => <T>[...state, ...items];

  /// Remove an [item] from this notifier.
  void remove(final T item) => <T>[
        for (final T $item in state)
          if ($item != item) $item
      ];

  /// Remove all [items] from this notifier.
  void removeAll(final Iterable<T> items) => <T>[
        for (final T item in state)
          if (!items.contains(item)) item
      ];

  /// Remove everything from this notifier.
  void clear() => Iterable<T>.empty();
}

/// The provider of content in the external API.
class ContentOptionalNotifier<T extends Object?> extends StateNotifier<T?>
    with RefreshListener<T?> {
  /// The provider of content in the external API.
  ///
  /// - **`refreshInterval`** The interval for automatic refreshing of the state
  /// of this RefreshContent.
  ContentOptionalNotifier({
    required final FutureOr<T> Function() refreshState,
    final Stream<StreamEvent<Iterable<T>>>? stream,
    final Duration refreshInterval = Duration.zero,
  }) : super(null) {
    stream?.listen((final StreamEvent<Iterable<T>> event) async {
      if (event.prevValue.isNotEmpty && event.value.isEmpty) {
        state = null;
      } else if (event.value.isNotEmpty) {
        state = event.value.single;
      }
    });
    this.refreshState = () async => state = await refreshState();
    if (refreshInterval != Duration.zero) {
      Timer.periodic(refreshInterval, (final _) => refresh());
    } else {
      refresh();
    }
  }

  @override
  late final FutureOr<T> Function() refreshState;
}
