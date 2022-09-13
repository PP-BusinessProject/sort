import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ndialog/ndialog.dart';
import 'package:page_transition/page_transition.dart';

import '../../flavors.dart';
import '../../generated/i18n.g.dart';
import '../../providers/misc_providers.dart';
import '../shared/shared_dialogs.dart';
import '../shared/shared_widgets.dart';
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
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
    return CupertinoPageScaffold(
      navigationBar: navigationBar(
        theme,
        previousPageTitle: $.menu.menu,
        onPressed: navigator.maybePop,
      ),
      child: listView(
        mediaQuery,
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
            onPressed: () => dialog(
              theme,
              title: $.alert.exitRegister.title,
              approve: $.alert.exitRegister.approve,
              onApprove: () async {
                final SortFlavor flavor = ref.read(flavorProvider);
                try {
                  await FirebaseAuth.instance.signOut();
                } finally {
                  navigator.popUntil(flavor.withName);
                }
              },
              deny: $.alert.exitRegister.deny,
              onDeny: navigator.maybePop,
            ).show<void>(
              context,
              transitionType: DialogTransitionType.Bubble,
            ),
            theme,
          ),
        ],
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
