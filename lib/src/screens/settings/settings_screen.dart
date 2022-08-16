import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../generated/i18n.g.dart';
import '../../providers/flutter_providers.dart';
import 'about_screen.dart';
import 'language_screen.dart';
import 'theme_screen.dart';

/// The screen that provides access to the app's settings.
class SettingsScreen extends HookConsumerWidget {
  /// The screen that provides access to the app's settings.
  const SettingsScreen({final super.key});

  /// The height of the buttons on this screen.
  static const double buttonHeight = 48;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = ref.watch(i18nProvider)();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        brightness: theme.brightness,
        border: const Border(),
        previousPageTitle: $.menu.menu,
      ),
      child: SafeArea(
        child: Align(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _button(
                  title: $.settings.language.language,
                  onPressed: () => navigator.push<void>(
                    PageTransition<void>(
                      type: PageTransitionType.fade,
                      child: const LanguageScreen(),
                    ),
                  ),
                  theme,
                ),
                const SizedBox(height: buttonHeight * 3 / 4),
                _button(
                  title: $.settings.theme.theme,
                  onPressed: () => navigator.push<void>(
                    PageTransition<void>(
                      type: PageTransitionType.fade,
                      child: const ThemeScreen(),
                    ),
                  ),
                  theme,
                ),
                const SizedBox(height: buttonHeight * 3 / 4),
                _button(
                  title: $.settings.notification.notification,
                  onPressed: () {},
                  theme,
                ),
                const SizedBox(height: buttonHeight * 3 / 4),
                _button(
                  title: $.settings.about.about,
                  onPressed: () => navigator.push<void>(
                    PageTransition<void>(
                      type: PageTransitionType.fade,
                      child: const AboutScreen(),
                    ),
                  ),
                  theme,
                ),
                const SizedBox(height: buttonHeight * 3 / 4),
                _button(
                  logOut: true,
                  title: $.settings.logout,
                  onPressed: () {},
                  theme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _button(
    final ThemeData theme, {
    required final String title,
    required final VoidCallback onPressed,
    final bool logOut = false,
  }) =>
      SizedBox(
        height: buttonHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.infinite,
            textStyle: theme.textTheme.headlineMedium,
            primary: logOut ? theme.colorScheme.error.withOpacity(4 / 5) : null,
            onPrimary:
                logOut ? theme.colorScheme.onSurface.withOpacity(2 / 3) : null,
          ),
          onPressed: onPressed,
          child: Text(title),
        ),
      );
}
