import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generated/i18n.g.dart';
import '../../providers/flutter_providers.dart';

/// The screen that provides access to the app's [ThemeMode] settings.
class ThemeScreen extends HookConsumerWidget {
  /// The screen that provides access to the app's [ThemeMode] settings.
  const ThemeScreen({final super.key});

  /// The height of the buttons on this screen.
  static const double buttonHeight = 56;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final I18N $ = ref.watch(i18nProvider)();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        brightness: theme.brightness,
        border: const Border(),
        previousPageTitle: $.settings.settings,
      ),
      child: Align(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (final Widget widget
                  in ThemeMode.values.map((final ThemeMode $theme) {
                final String title;
                final IconData icon;
                switch ($theme) {
                  case ThemeMode.system:
                    title = $.settings.theme.system;
                    icon = mediaQuery.platformBrightness == Brightness.dark
                        ? CupertinoIcons.moon_fill
                        : CupertinoIcons.sun_max_fill;
                    break;
                  case ThemeMode.light:
                    title = $.settings.theme.light;
                    icon = CupertinoIcons.sun_max;
                    break;
                  case ThemeMode.dark:
                    title = $.settings.theme.dark;
                    icon = CupertinoIcons.moon;
                    break;
                }
                return _button(
                  title: title,
                  icon: icon,
                  onPressed: themeMode == $theme
                      ? null
                      : () =>
                          ref.read(themeModeProvider.notifier).state = $theme,
                  theme,
                );
              })) ...<Widget>[widget, const SizedBox(height: 36)]
            ]..removeLast(),
          ),
        ),
      ),
    );
  }

  static Widget _button(
    final ThemeData theme, {
    required final VoidCallback? onPressed,
    required final String title,
    required final IconData icon,
  }) =>
      SizedBox(
        height: buttonHeight,
        child: Opacity(
          opacity: onPressed == null ? 1 / 2 : 1,
          child: IgnorePointer(
            ignoring: onPressed == null,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.infinite,
                padding: EdgeInsets.zero,
              ),
              onPressed: onPressed ?? () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(width: 24),
                    Text(
                      title,
                      style: theme.textTheme.headlineSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Icon(icon, size: 32),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
