import 'dart:async';
import 'dart:ui' as ui;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_converters_lite/json_converters_lite.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../api.dart';
import '../flavors.dart';
import '../generated/assets.g.dart';
import '../observers/provider_observer.dart';
import '../providers/flutter_providers.dart';
import '../providers/misc_providers.dart';
import 'flavor_screen.dart';
import 'utils/animated_background.dart';

/// The loading screen that displays a splash until the load finishes.
class SplashScreen extends HookWidget {
  /// The loading screen that displays a splash until the load finishes.
  const SplashScreen({
    final this.transitionDuration = const Duration(seconds: 2),
    final this.child,
    final super.key,
  });

  /// The [AnimatedCrossFade.duration] of this screen.
  final Duration transitionDuration;

  /// The child of this splash screen.
  final Widget? child;

  // ignore: close_sinks
  static StreamController<bool>? _controller;

  /// If the splash should be shown.
  static StreamSink<bool>? get showSplash => _controller?.sink;

  static Future<List<Override>> _getProviderOverrides({
    final bool reset = true,
  }) async {
    final Iterable<Object?> $ = await Future.wait<Object?>(<Future<Object?>>[
      PackageInfo.fromPlatform(),
      Future<Box<String>>(() async {
        Hive.init((await getApplicationDocumentsDirectory()).path);
        final Box<String> box = await Hive.openBox<String>('storage');
        if (reset) {
          await box.clear();
        }
        return box;
      }),
      sortApi.get<DateTime>(
        '/settings/time',
        fromJson: (final Object? value) =>
            dateTimeConverter.fromJson(value! as String),
      ),
      Firebase.initializeApp(),
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      ),
      Future<void>.delayed(const Duration(seconds: 2)),
    ]);
    return <Override>[
      packageInfoProvider.overrideWithValue($.first! as PackageInfo),
      flavorProvider.overrideWithValue(
        SortFlavor.fromPackage($.first! as PackageInfo),
      ),
      hiveProvider.overrideWithValue($.elementAt(1)! as Box<String>),
      serverTimeProvider.overrideWithValue(
        ServerTimeNotifier($.elementAt(2)! as DateTime),
      )
    ];
  }

  Stream<T> _delayedStream<T extends Object?>(final Stream<T> stream) async* {
    await for (final T value in stream) {
      yield value;
      await Future<void>.delayed(transitionDuration);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final WidgetsBinding widgetsBinding = WidgetsBinding.instance;
    final List<Override>? overrides =
        useFuture(useMemoized(_getProviderOverrides)).data;
    final ObjectRef<WidgetsBindingObserver?> observer =
        useRef<WidgetsBindingObserver?>(null);

    final Stream<bool> showStream =
        _delayedStream((_controller = useStreamController()).stream);
    final bool showSplash = useStream(showStream).data ?? true;
    if (observer.value != null && overrides == null) {
      WidgetsBinding.instance.removeObserver(observer.value!);
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
                  observers: const <ProviderObserver>[I18NChangedObserver()],
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
