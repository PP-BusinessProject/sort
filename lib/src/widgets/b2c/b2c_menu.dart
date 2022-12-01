import 'dart:ui';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../generated/i18n.g.dart';
import '../../providers/database/model_providers.dart';
import '../../styles.dart';
import '../../widgets/shared/shared_widgets.dart';
import '../settings/settings_screen.dart';
import '../users/user_card.dart';
import 'b2c_expanded.dart';
import 'b2c_screen.dart';

/// The menu of the [B2CScreen] that is accessed from the [B2CExpanded].
class B2CMenu extends HookConsumerWidget {
  /// The menu of the [B2CScreen] that is accessed from the [B2CExpanded].
  const B2CMenu({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context);
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
            child: Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.topCenter,
              children: <Widget>[
                /// Blur Background
                Positioned.fill(
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.light
                              ? Colors.white.withOpacity(1 / 5)
                              : Colors.black.withOpacity(1 / 5),
                        ),
                        child: const Align(),
                      ),
                    ),
                  ),
                ),

                /// Main Content
                SafeArea(
                  left: mediaQuery.orientation == Orientation.landscape,
                  top: mediaQuery.orientation == Orientation.landscape,
                  right: mediaQuery.orientation == Orientation.landscape,
                  bottom: mediaQuery.orientation == Orientation.landscape,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ).copyWith(bottom: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        /// Title
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            marqueeText(
                              $.menu.menu,
                              style: theme.textTheme.displaySmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Tooltip(
                                message: $.menu.closeHint,
                                child: iconButton(
                                  theme,
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
                        SizedBox(
                          height: 48,
                          child: Consumer(
                            builder: (
                              final _,
                              final WidgetRef ref,
                              final Widget? child,
                            ) =>
                                PersonCard(
                              ref.watch(
                                personProvider
                                    .select((final _) => _.valueOrNull!),
                              ),
                              canEdit: true,
                            ),
                          ),
                        ),

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
                                  child: marqueeText(
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
                                  child: marqueeText(
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
                                  backgroundColor: theme.colorScheme.surface,
                                ),
                                onPressed: () {},
                                child: marqueeText(
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
                                  backgroundColor: theme.colorScheme.surface,
                                ),
                                onPressed: () {},
                                child: marqueeText(
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
                                  backgroundColor: theme.colorScheme.surface,
                                ),
                                onPressed: () => navigator.push<void>(
                                  PageTransition<void>(
                                    type: PageTransitionType.fade,
                                    child: const SettingsScreen(),
                                  ),
                                ),
                                child: marqueeText(
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
                                  backgroundColor: theme.colorScheme.surface,
                                ),
                                onPressed: () {},
                                child: marqueeText(
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
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: theme.colorScheme.surface,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                child: marqueeText(
                                  $.settings.about.privacyPolicy,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: theme.colorScheme.surface,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                child: marqueeText(
                                  $.settings.about.termsOfUse,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
