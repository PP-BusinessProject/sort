import 'dart:async';

import 'hive_notifier.dart';

/// The callback to refresh the [ContentNotifier].
typedef RefreshContent<T extends Object?> = FutureOr<T?> Function(
  RefreshListener<T> notifier,
);

/// The callback on refresh of the [ContentNotifier].
typedef ContentListener = FutureOr<void> Function();

/// The callback on completed refresh of the [ContentNotifier].
typedef ContentCallback = FutureOr<void> Function({required bool success});

/// Refresh the state with a callback.
mixin RefreshListener<T extends Object?> {
  /// The callback to refresh a state of this provider.
  RefreshContent<T> get refreshState;

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
        success = await refreshState(this) != null;
      } finally {
        try {
          final Iterable<FutureOr<void>> futures = <FutureOr<void>>[
            for (final ContentCallback callback in _onRefreshCallbacks)
              callback(success: success)
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
class ContentNotifier<T extends Object?> extends HiveNotifier<T, String>
    with RefreshListener<T> {
  /// The provider of content in the external API.
  ///
  /// - **`refreshInterval`** The interval for automatic refreshing of the state
  /// of this RefreshContent.
  ContentNotifier(
    super._, {
    required final super.key,
    required final super.converter,
    required final super.initialValue,
    required final RefreshContent<T> refreshState,
    final super.onValue,
    final Duration refreshInterval = Duration.zero,
  }) {
    this.refreshState = (final RefreshListener<T> notifier) async {
      final T? state = await refreshState(notifier);
      if (state != null) {
        await setStateAsync(state);
      }
      return state;
    };
    final Timer refreshTimer =
        Timer.periodic(refreshInterval, (final _) => refresh());
    if (refreshInterval == Duration.zero) {
      refreshTimer.cancel();
    }
  }

  @override
  late final RefreshContent<T> refreshState;
}

/// The provider of content in the external API.
class ContentIterableNotifier<T extends Object?>
    extends HiveIterableNotifier<T, String> with RefreshListener<Iterable<T>> {
  /// The provider of content in the external API.
  ///
  /// - **`refreshInterval`** The interval for automatic refreshing of the state
  /// of this RefreshContent.
  ContentIterableNotifier(
    super._, {
    required final super.key,
    required final super.converter,
    required final super.initialValue,
    required final RefreshContent<Iterable<T>> refreshState,
    final super.onValue,
    final Duration refreshInterval = Duration.zero,
  }) {
    this.refreshState = (final RefreshListener<Iterable<T>> notifier) async {
      final Iterable<T>? state = await refreshState(notifier);
      if (state != null) {
        await setStateAsync(state);
      }
      return state;
    };
    final Timer refreshTimer =
        Timer.periodic(refreshInterval, (final _) => refresh());
    if (refreshInterval == Duration.zero) {
      refreshTimer.cancel();
    }
  }

  @override
  late final RefreshContent<Iterable<T>> refreshState;
}
