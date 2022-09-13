import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generated/assets.g.dart';
import '../../generated/i18n.g.dart';
import '../../notifiers/hive_notifier.dart';
import '../../providers/flutter_providers.dart';
import '../shared/shared_widgets.dart';

/// The screen that provides access to the app's language settings.
class LanguageScreen extends HookConsumerWidget {
  /// The screen that provides access to the app's language settings.
  const LanguageScreen({final super.key});

  /// The height of the buttons on this screen.
  static const double buttonHeight = 56;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final bool localeChanged = ref.watch(i18nChangedProvider);
    final I18NLocale currentLocale = ref.watch(i18nProvider);

    final I18NLocale? systemLocale = ref.watch(
      systemLocalesProvider.select(
        (final List<Locale> locales) =>
            (I18NLocale.values.cast<I18NLocale?>()).firstWhere(
          (final I18NLocale? locale) =>
              locale!.locale.languageCode == locales.first.languageCode &&
              (locale.locale.countryCode == null ||
                  locales.first.countryCode == null ||
                  locale.locale.countryCode == locales.first.countryCode),
          orElse: () => null,
        ),
      ),
    );
    final I18N $ = currentLocale();

    String translatedTitle(final I18NLocale locale) {
      switch (locale) {
        case I18NLocale.uk:
          return $.settings.language.ukUa;
        case I18NLocale.en:
          return $.settings.language.enUs;
      }
    }

    String imagePath(final I18NLocale locale) {
      switch (locale) {
        case I18NLocale.uk:
          return assets.countries.ukraine;
        case I18NLocale.en:
          return assets.countries.england;
      }
    }

    return CupertinoPageScaffold(
      navigationBar: navigationBar(
        theme,
        previousPageTitle: $.settings.settings,
        onPressed: navigator.maybePop,
      ),
      child: listView(
        mediaQuery,
        children: <Widget>[
          _button(
            title: $.settings.language.system,
            secondTitle: systemLocale != null
                ? translatedTitle(systemLocale)
                : $.settings.language.unsupported(
                    translatedTitle(
                      ref.read(i18nProvider.notifier).initialValue,
                    ),
                  ),
            imagePath: imagePath(
              systemLocale ?? ref.read(i18nProvider.notifier).initialValue,
            ),
            onPressed: !localeChanged
                ? null
                : () async {
                    final HiveNotifier<I18NLocale, String> i18nNotifier =
                        ref.read(i18nProvider.notifier);
                    await i18nNotifier.setStateAsync(
                      systemLocale ?? i18nNotifier.initialValue,
                    );
                    await (ref.read(i18nChangedProvider.notifier))
                        .setStateAsync(false);
                  },
            theme,
          ),
          const SizedBox(height: 36),
          for (final Widget widget in I18NLocale.values.reversed.map(
            (final I18NLocale locale) => _button(
              title: () {
                switch (locale) {
                  case I18NLocale.uk:
                    return locale().settings.language.ukUa;
                  case I18NLocale.en:
                    return locale().settings.language.enUs;
                }
              }(),
              secondTitle: translatedTitle(locale),
              imagePath: imagePath(locale),
              onPressed: !localeChanged || currentLocale != locale
                  ? () async {
                      await (ref.read(i18nChangedProvider.notifier))
                          .setStateAsync(true);
                      await (ref.read(i18nProvider.notifier))
                          .setStateAsync(locale);
                    }
                  : null,
              theme,
            ),
          )) ...<Widget>[widget, const SizedBox(height: 36)],
          if (mediaQuery.orientation == Orientation.portrait)
            const SizedBox(height: 72),
        ],
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
                          marqueeText(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          marqueeText(
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
