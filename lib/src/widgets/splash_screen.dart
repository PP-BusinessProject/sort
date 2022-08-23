import 'dart:ui' as ui;

import 'package:firebase_core/firebase_core.dart';
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
import '../providers/flutter_providers.dart';
import '../providers/misc_providers.dart';
import 'flavor_screen.dart';
import 'utils/animated_background.dart';

/// The loading screen that displays a splash until the load finishes.
class SplashScreen extends HookWidget {
  /// The loading screen that displays a splash until the load finishes.
  const SplashScreen({final super.key});

  /// The [AnimatedCrossFade.duration] of this screen.
  static const Duration transitionDuration = Duration(seconds: 2);

  @override
  Widget build(final BuildContext context) {
    final WidgetsBinding widgetsBinding = WidgetsBinding.instance;
    final Iterable<Object?>? $ = useFuture(
      useMemoized(
        () => Future.wait<Object?>(<Future<Object?>>[
          PackageInfo.fromPlatform(),
          Future<Box<String>>(() async {
            Hive.init((await getApplicationDocumentsDirectory()).path);
            return Hive.openBox<String>('storage');
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
        ]),
      ),
    ).data;
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: AnimatedCrossFade(
        duration: transitionDuration,
        reverseDuration: Duration.zero,
        sizeCurve: const Interval(0, 1 / 2, curve: Curves.ease),
        firstCurve: const Interval(0, 1 / 2, curve: Curves.easeOutQuad),
        secondCurve: const Interval(0, 1 / 2, curve: Curves.easeInQuad),
        crossFadeState:
            $ == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
              Image.asset(assets.logo)
            ],
          ),
        ),
        secondChild: $ == null
            ? const SizedBox.shrink()
            : ProviderScope(
                overrides: <Override>[
                  widgetsBindingProvider.overrideWithValue(widgetsBinding),
                  packageInfoProvider
                      .overrideWithValue($.first! as PackageInfo),
                  flavorProvider.overrideWithValue(
                    SortFlavor.fromPackage($.first! as PackageInfo),
                  ),
                  hiveProvider
                      .overrideWithValue($.elementAt(1)! as Box<String>),
                  serverTimeProvider.overrideWithValue(
                    ServerTimeNotifier($.elementAt(2)! as DateTime),
                  )
                ],
                observers: const <ProviderObserver>[I18NChangedObserver()],
                child: LimitedBox(
                  maxHeight: widgetsBinding.window.physicalSize.height,
                  maxWidth: widgetsBinding.window.physicalSize.width,
                  child: const FlavorScreen(),
                ),
              ),
      ),
    );
  }
}
