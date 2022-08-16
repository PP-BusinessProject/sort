import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../generated/i18n.g.dart';
import '../../providers/flutter_providers.dart';
import '../../providers/misc_providers.dart';

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
    final I18N $ = ref.watch(i18nProvider)();
    final PackageInfo packageInfo = ref.watch(packageInfoProvider);
    final int year = ref.watch(
      serverTimeProvider.select((final DateTime serverTime) => serverTime.year),
    );
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        brightness: theme.brightness,
        border: const Border(),
        previousPageTitle: $.menu.menu,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
        ),
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
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (secondTitle.isNotEmpty)
                    Text(secondTitle, style: theme.textTheme.labelMedium)
                ],
              ),
            ),
          ),
        ),
      );
}
