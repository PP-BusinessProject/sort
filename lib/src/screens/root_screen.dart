import 'dart:ui' as ui;

import 'package:catcher/catcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_converters_lite/json_converters_lite.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../api.dart';
import '../flavors.dart';
import '../generated/assets.g.dart';
import '../generated/i18n.g.dart';
import '../observers/provider_observer.dart';
import '../providers/flutter_providers.dart';
import '../providers/misc_providers.dart';
import '../styles.dart';
import '../widgets/animated_background.dart';

class RootScreen extends HookWidget {
  const RootScreen({final super.key});

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
                child: LimitedBox(
                  maxHeight: widgetsBinding.window.physicalSize.height,
                  maxWidth: widgetsBinding.window.physicalSize.width,
                  child: const RootApp(),
                ),
              ),
      ),
    );
  }
}

class RootApp extends HookConsumerWidget {
  const RootApp({final super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final SortFlavor flavor = ref.watch(flavorProvider);
    useMemoized(
      () {
        (ref.read(widgetsBindingProvider))
            .addObserver(ref.read(providerObserverProvider));
      },
    );
    return MaterialApp(
      title: flavor.title,
      restorationScopeId: 'root',
      localizationsDelegates: const <LocalizationsDelegate<Object?>>[
        RefreshLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeModeProvider),
      initialRoute: flavor.path,
      routes: <String, Widget Function(BuildContext)>{
        for (final SortFlavor flavor in SortFlavor.values)
          flavor.path: flavor.builder
      },
      navigatorKey: Catcher.navigatorKey,
      locale: ref.watch(localeProvider),
      supportedLocales:
          I18NLocale.values.map((final I18NLocale locale) => locale.toLocale()),
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: lightScheme,
        textTheme: textTheme,
      ).apply(),
      darkTheme: ThemeData.from(
        useMaterial3: true,
        colorScheme: darkScheme,
        textTheme: textTheme,
      ).apply(),
      builder: (final BuildContext context, final Widget? child) {
        final ThemeData theme = Theme.of(context);
        MediaQueryData mediaQuery = MediaQuery.of(context);
        mediaQuery = mediaQuery.copyWith(
          textScaleFactor: mediaQuery.textScaleFactor.clamp(.5, 1.3),
        );
        ref.read(widgetsBindingProvider).addPostFrameCallback((final _) {
          final StateController<ThemeData?> themeNotifier =
              ref.read(rootThemeProvider.notifier);
          if (themeNotifier.state != theme) {
            themeNotifier.state = theme;
          }
          final StateController<MediaQueryData?> mediaQueryNotifier =
              ref.read(rootMediaQueryProvider.notifier);
          if (mediaQueryNotifier.state != mediaQuery) {
            mediaQueryNotifier.state = mediaQuery;
          }
        });
        return MediaQuery(
          data: mediaQuery,
          child: DefaultTextStyle(
            style: theme.textTheme.headlineMedium ?? const TextStyle(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: RefreshConfiguration(
              maxOverScrollExtent: 0,
              headerTriggerDistance: 50 * mediaQuery.textScaleFactor,
              topHitBoundary: 10 * mediaQuery.textScaleFactor,
              headerBuilder: () => Consumer(
                builder: (
                  final BuildContext context,
                  final WidgetRef ref,
                  final Widget? child,
                ) {
                  final ThemeData theme = Theme.of(context);
                  final MediaQueryData mediaQuery = MediaQuery.of(context);
                  final bool connectionError =
                      ref.watch(connectionErrorProvider);
                  final I18N $ = ref.watch(i18nProvider)();
                  return ClassicHeader(
                    height: 60 * mediaQuery.textScaleFactor,
                    completeDuration:
                        const Duration(seconds: 1, milliseconds: 500),
                    textStyle: theme.textTheme.bodyMedium!
                        .copyWith(color: theme.hintColor),
                    idleText: $.pullToRefresh.idle,
                    releaseText: $.pullToRefresh.release,
                    refreshingText: $.pullToRefresh.refreshing,
                    completeText: connectionError
                        ? $.pullToRefresh.completeInternetError
                        : $.pullToRefresh.complete,
                    failedText: connectionError
                        ? $.pullToRefresh.completeInternetError
                        : $.pullToRefresh.error,
                    outerBuilder: (final Widget child) => Container(
                      height: 40 * mediaQuery.textScaleFactor,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: child,
                    ),
                  );
                },
              ),
              child: child!,
            ),
          ),
        );
      },
    );
  }
}
