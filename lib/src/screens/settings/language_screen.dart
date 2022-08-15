import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generated/assets.g.dart';
import '../../generated/i18n.g.dart';
import '../../providers/flutter_providers.dart';

/// The screen that provides access to the app's language settings.
class LanguageScreen extends HookConsumerWidget {
  /// The screen that provides access to the app's language settings.
  const LanguageScreen({final super.key});

  /// The height of the buttons on this screen.
  static const double buttonHeight = 56;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final I18NLocale currentLocale = ref.watch(i18nProvider);
    final I18N $ = currentLocale();
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
                  in I18NLocale.values.reversed.map((final I18NLocale locale) {
                final String localeTitle;
                final String translatedLocaleTitle;
                final String imagePath;
                switch (locale) {
                  case I18NLocale.ukUA:
                    localeTitle = locale().settings.language.ukUa;
                    translatedLocaleTitle = $.settings.language.ukUa;
                    imagePath = assets.countries.ukraine;
                    break;
                  case I18NLocale.enUS:
                    localeTitle = locale().settings.language.enUs;
                    translatedLocaleTitle = $.settings.language.enUs;
                    imagePath = assets.countries.england;
                    break;
                }
                return _button(
                  title: localeTitle,
                  secondTitle: translatedLocaleTitle,
                  imagePath: imagePath,
                  onPressed: currentLocale == locale
                      ? null
                      : () => ref.read(i18nProvider.notifier).state = locale,
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
    required final String secondTitle,
    required final String imagePath,
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
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            secondTitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.normal,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Image.asset(
                        imagePath,
                        width: 28,
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
