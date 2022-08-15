import 'package:blur/blur.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../providers/flutter_providers.dart';
import '../../providers/model_providers.dart';
import '../../styles.dart';
import '../../widgets/sort_icon_button.dart';
import '../settings/settings_screen.dart';
import 'b2c_expanded.dart';
import 'b2c_screen.dart';

/// The menu of the [B2CScreen] that is accessed from the [B2CExpanded].
class B2CMenu extends HookConsumerWidget {
  /// The menu of the [B2CScreen] that is accessed from the [B2CExpanded].
  const B2CMenu({final super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = ref.watch(i18nProvider)();
    final GlobalKey<State<StatefulWidget>> mainKey = useMemoized(GlobalKey.new);
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerUp: (final PointerEvent event) async {
        if (mediaQuery.orientation != Orientation.landscape &&
            !(mainKey.globalPaintBounds?.contains(event.position) ?? false)) {
          await navigator.maybePop();
        }
      },
      child: Padding(
        padding: mediaQuery.orientation == Orientation.portrait
            ? const EdgeInsets.all(40)
            : EdgeInsets.zero,
        child: Align(
          child: Material(
            key: mainKey,
            color: Colors.transparent,
            shape: outlinedBorder(theme, radius: 10),
            child: SizedBox(
              height: 460,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  /// Blur Background
                  Material(
                    color: Colors.transparent,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10),
                    child: const Blur(
                      blur: 16,
                      colorOpacity: 0,
                      child: SizedBox.expand(),
                    ),
                  ),

                  /// Main Content
                  SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ).copyWith(bottom: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        /// Title
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Text(
                              $.menu.menu,
                              style: theme.textTheme.displaySmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Tooltip(
                                message: $.menu.closeHint,
                                child: SortIconButton(
                                  CupertinoIcons.clear,
                                  onTap: navigator.maybePop,
                                  iconSize: 16,
                                  radius: 24 / 2,
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// Profile Edit
                        const SizedBox(height: 24),
                        const SizedBox(height: 48, child: B2CMenuProfileCard()),

                        /// Payment
                        const SizedBox(height: 36),
                        SizedBox(
                          height: 36,
                          child: Row(
                            children: <Widget>[
                              /// Abonement
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size.infinite,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    $.menu.abonement,
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                              ),

                              /// Individual
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size.infinite,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    $.menu.individual,
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 36),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            /// History
                            SizedBox(
                              height: 36,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.infinite,
                                  primary: theme.colorScheme.surface,
                                ),
                                onPressed: () {},
                                child: Text(
                                  $.menu.history,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                            ),

                            /// Statistics
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 36,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.infinite,
                                  primary: theme.colorScheme.surface,
                                ),
                                onPressed: () {},
                                child: Text(
                                  $.menu.statistics,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                            ),

                            /// Settings
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 36,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.infinite,
                                  primary: theme.colorScheme.surface,
                                ),
                                onPressed: () => navigator.push<void>(
                                  PageTransition<void>(
                                    type: PageTransitionType.fade,
                                    child: const SettingsScreen(),
                                  ),
                                ),
                                child: Text(
                                  $.settings.settings,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                            ),

                            /// Support
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 36,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.infinite,
                                  primary: theme.colorScheme.surface,
                                ),
                                onPressed: () {},
                                child: Text(
                                  $.menu.support,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          spacing: 8,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: theme.colorScheme.surface,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                $.settings.about.privacyPolicy,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: theme.colorScheme.surface,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                $.settings.about.termsOfUse,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The current logged in user's profile card.
class B2CMenuProfileCard extends HookConsumerWidget {
  /// The current logged in user's profile card.
  const B2CMenuProfileCard({final super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final I18N $ = ref.watch(i18nProvider)();
    final UserModel user = ref.watch(userProvider)!;
    return Row(
      children: <Widget>[
        /// Avatar with Add Button
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            /// Avatar
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: GestureDetector(
                onTap: () {},
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[boxShadow(theme)],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      CupertinoIcons.person_fill,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),

            /// Add Button
            SortIconButton(
              CupertinoIcons.add,
              iconSize: 12,
              radius: 9,
              color: theme.colorScheme.onPrimary,
              iconColor: theme.colorScheme.surface,
              onTap: () {},
            )
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${user.firstName} ${user.lastName ?? ''}'.trimRight(),
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text('+${user.phoneNumber}', style: theme.textTheme.bodyLarge),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Tooltip(
            message: $.menu.editHint,
            child: SortIconButton(
              CupertinoIcons.pencil,
              onTap: () {},
              iconSize: 18,
              radius: 32 / 2,
            ),
          ),
        )
      ],
    );
  }
}
