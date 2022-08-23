import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../generated/i18n.g.dart';
import '../../providers/misc_providers.dart';
import '../shared/shared_widgets.dart';

/// The screen that provides shows app's info and privacy rules.
class AboutScreen extends HookConsumerWidget {
  /// The screen that provides shows app's info and privacy rules.
  const AboutScreen({final super.key});

  /// The height of the buttons on this screen.
  static const double buttonHeight = 60;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
    final PackageInfo packageInfo = ref.watch(packageInfoProvider);
    final int year = ref.watch(
      serverTimeProvider.select((final DateTime serverTime) => serverTime.year),
    );
    return CupertinoPageScaffold(
      navigationBar: navigationBar(
        theme,
        previousPageTitle: $.menu.menu,
        onPressed: navigator.maybePop,
      ),
      child: listView(
        alignment: Alignment.topCenter,
        children: <Widget>[
          _button(
            title: packageInfo.appName,
            secondTitle: '@${packageInfo.appName}, $year',
            theme,
          ),
          const SizedBox(height: 16),
          _button(
            title: $.settings.about.version,
            secondTitle: packageInfo.version,
            theme,
          ),
          const SizedBox(height: 16),
          _button(
            title: $.settings.about.privacyPolicy,
            onPressed: () {},
            theme,
          ),
          const SizedBox(height: 16),
          _button(
            title: $.settings.about.termsOfUse,
            onPressed: () {},
            theme,
          )
        ],
      ),
    );
  }

  static Widget _button(
    final ThemeData theme, {
    required final String title,
    final String secondTitle = '',
    final VoidCallback? onPressed,
  }) =>
      SizedBox(
        height: buttonHeight,
        child: IgnorePointer(
          ignoring: onPressed == null,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.infinite,
              primary: theme.colorScheme.surface,
              padding: EdgeInsets.zero,
            ),
            onPressed: onPressed ?? () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                mainAxisAlignment: secondTitle.isNotEmpty
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  marqueeText(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (secondTitle.isNotEmpty)
                    marqueeText(secondTitle, style: theme.textTheme.labelMedium)
                ],
              ),
            ),
          ),
        ),
      );
}
