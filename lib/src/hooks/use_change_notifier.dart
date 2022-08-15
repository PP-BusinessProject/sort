import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Subscribes to a [ChangeNotifier] and marks the widget as needing build
/// whenever the listener is called if [subscribe] is `true`.
T useChangeNotifier<T extends ChangeNotifier>(
  final T notifier, {
  final bool? subscribe,
}) {
  use(_ChangeNotifierHook(notifier, subscribe: subscribe));
  return notifier;
}

class _ChangeNotifierHook extends Hook<void> {
  const _ChangeNotifierHook(this.notifier, {final bool? subscribe})
      : subscribe = subscribe ?? false;

  final ChangeNotifier notifier;
  final bool subscribe;

  @override
  _ChangeNotifierStateHook createState() => _ChangeNotifierStateHook();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(DiagnosticsProperty<ChangeNotifier>('notifier', notifier))
        ..add(DiagnosticsProperty<bool>('subscribe', subscribe)),
    );
  }
}

class _ChangeNotifierStateHook extends HookState<void, _ChangeNotifierHook> {
  @override
  void initHook() {
    super.initHook();
    if (hook.subscribe) {
      hook.notifier.addListener(_listener);
    }
  }

  @override
  void didUpdateHook(final _ChangeNotifierHook oldHook) {
    super.didUpdateHook(oldHook);
    if (hook.subscribe && hook.notifier != oldHook.notifier) {
      oldHook.notifier.removeListener(_listener);
      hook.notifier.addListener(_listener);
    }
  }

  @override
  void build(final BuildContext context) {}

  void _listener() => setState(() {});

  @override
  void dispose() {
    super.dispose();
    if (hook.subscribe) {
      hook.notifier.removeListener(_listener);
    }
    hook.notifier.dispose();
  }

  @override
  String get debugLabel => 'useListenable';

  @override
  Object? get debugValue => hook.notifier;
}
