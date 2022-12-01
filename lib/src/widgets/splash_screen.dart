import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../generated/assets.g.dart';
import '../observers/provider_observer.dart';
import '../providers/flutter_providers.dart';
import '../providers/provider_overrides.dart';
import 'flavor_screen.dart';
import 'utils/animated_background.dart';

/// The loading screen that displays a splash until the load finishes.
class SplashScreen extends HookWidget {
  /// The loading screen that displays a splash until the load finishes.
  const SplashScreen({
    this.transitionDuration = const Duration(seconds: 2),
    this.child,
    super.key,
  });

  /// The [AnimatedCrossFade.duration] of this screen.
  final Duration transitionDuration;

  /// The child of this splash screen.
  final Widget? child;

  // ignore: close_sinks
  static StreamController<bool>? _controller;

  /// If the splash should be shown.
  static StreamSink<bool>? get showSplash => _controller?.sink;

  @override
  Widget build(final BuildContext context) {
    final WidgetsBinding widgetsBinding = WidgetsBinding.instance;
    final List<Override>? overrides = useFuture(
      // ignore: discarded_futures
      useMemoized(
        () async => Future.wait<List<Override>?>(
          <Future<List<Override>?>>[
            providerOverrides,
            Future<List<Override>?>.delayed(transitionDuration)
          ],
        ),
      ),
    ).data?.first;
    final ObjectRef<WidgetsBindingObserver?> observer =
        useRef<WidgetsBindingObserver?>(null);

    final Stream<bool> showStream =
        (_controller = useStreamController()).stream;
    final bool showSplash =
        useStream(showStream, initialData: true, preserveState: false)
            .requireData;
    if (observer.value != null && overrides == null) {
      widgetsBinding.removeObserver(observer.value!);
      observer.value = null;
    }
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: AnimatedCrossFade(
        duration: transitionDuration,
        reverseDuration: Duration.zero,
        sizeCurve: const Interval(0, 1 / 2, curve: Curves.ease),
        firstCurve: const Interval(0, 1 / 2, curve: Curves.easeOutQuad),
        secondCurve: const Interval(0, 1 / 2, curve: Curves.easeInQuad),
        crossFadeState: overrides == null || showSplash
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: LimitedBox(
          maxHeight: widgetsBinding.window.physicalSize.height,
          maxWidth: widgetsBinding.window.physicalSize.width,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedBackground(
                curve: Curves.ease,
                duration: transitionDuration,
                colors: const <Color>[Color(0xffC9EACC), Color(0xffF9E8BC)],
                animateAlignments: false,
                alignments: const <AlignmentGeometry>[
                  Alignment.bottomLeft,
                  Alignment.topRight
                ],
              ),
              Image.asset(
                assets.logo,
                width: widgetsBinding.window.physicalSize.width / 3,
              )
            ],
          ),
        ),
        secondChild: LimitedBox(
          maxHeight: widgetsBinding.window.physicalSize.height,
          maxWidth: widgetsBinding.window.physicalSize.width,
          child: overrides == null
              ? null
              : ProviderScope(
                  overrides: overrides,
                  observers: const <ProviderObserver>[I18NObserver()],
                  child: Builder(
                    builder: (final BuildContext context) {
                      WidgetsBinding.instance.addObserver(
                        observer.value = WidgetsBindingObserverProvider(
                          ProviderScope.containerOf(context),
                        ),
                      );
                      return const FlavorScreen();
                    },
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(
          DiagnosticsProperty<Duration>(
            'transitionDuration',
            transitionDuration,
          ),
        ),
    );
  }
}
