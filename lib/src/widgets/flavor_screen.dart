import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config.dart';
import '../flavors.dart';
import '../generated/i18n.g.dart';
import '../providers/flutter_providers.dart';
import '../providers/misc_providers.dart';
import '../styles.dart';
import 'b2c/b2c_screen.dart';

/// The root application widget with flavors support.
class FlavorScreen extends HookConsumerWidget {
  /// The root application widget with flavors support.
  const FlavorScreen({final super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final SortFlavor flavor = ref.watch(flavorProvider);
    final bool Function() isMounted = useIsMounted();
    final ObjectRef<bool> catcherInitialised = useRef(false);
    return MaterialApp(
      title: flavor.title,
      restorationScopeId: 'root',
      localizationsDelegates: const <LocalizationsDelegate<Object?>>[
        I18NLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeModeProvider),
      locale: ref.read(localeProvider),
      initialRoute: flavor.path,
      navigatorKey: Catcher.navigatorKey,
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
        WidgetsBinding.instance.addPostFrameCallback((final _) {
          if (!isMounted()) {
            return;
          }
          if (!catcherInitialised.value) {
            Catcher.getInstance().updateConfig(
              debugConfig: debugConfig(initialised: true),
              releaseConfig: releaseConfig(initialised: true),
            );
            catcherInitialised.value = true;
          }
          final StateController<ThemeData?> themeNotifier =
              ref.read(themeProvider.notifier);
          if (themeNotifier.state != theme) {
            themeNotifier.state = theme;
          }
          final StateController<MediaQueryData?> mediaQueryNotifier =
              ref.read(mediaQueryProvider.notifier);
          if (mediaQueryNotifier.state != mediaQuery) {
            mediaQueryNotifier.state = mediaQuery;
          }
        });
        return MediaQuery(
          data: mediaQuery,
          child: Localizations.override(
            context: context,
            locale: ref.watch(localeProvider),
            delegates: const <LocalizationsDelegate<Object?>>[],
            child: DefaultTextStyle(
              style: theme.textTheme.headlineMedium ?? const TextStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              child: child!,
            ),
          ),
        );
      },
      routes: <String, Widget Function(BuildContext)>{
        SortFlavor.b2c.path: (final _) => const B2CScreen(),
      },
    );
  }
}
