import 'package:card_swiper/card_swiper.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../generated/assets.g.dart';
import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../providers/model_providers.dart';
import '../../styles.dart';
import '../bonuses/bonus_card.dart';
import '../bonuses/bonuses_screen.dart';
import '../containers/containers_screen.dart';
import '../shared/shared_widgets.dart';
import 'b2c_menu.dart';

/// The expanded variant of the [B2CScreen].
class B2CExpanded extends HookConsumerWidget {
  /// The expanded variant of the [B2CScreen].
  const B2CExpanded({final super.key});

  /// The height of the appbar in the expanded widget.
  static const double appBarHeight = 50;

  /// If the [Shimmer] should be shown on [bonusesProvider] loading.
  static const bool showBonusesShimmer = true;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
    final bool? bonusesPresent = ref
        .watch(bonusesProvider.select((final _) => _.valueOrNull?.isNotEmpty));
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        /// AppBar
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(16).copyWith(top: 0),
            child: SizedBox(
              height: appBarHeight,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: theme.colorScheme.shadow.withOpacity(1 / 10),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(4).copyWith(top: 2, bottom: 6),
                      child: Image.asset(
                        assets.logo,
                        fit: BoxFit.fitHeight,
                        filterQuality: FilterQuality.none,
                      ),
                    ),
                  ),

                  /// Actions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      /// EcoCoin button
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              style: theme.elevatedButtonTheme.style?.copyWith(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                ),
                              ),
                              onPressed: () => navigator.push(
                                PageTransition<void>(
                                  type: PageTransitionType.fade,
                                  child: const BonusesScreen(),
                                ),
                              ),
                              child: ecoCoinBalance(theme, balance: 1500),
                            ),
                          ),
                        ),
                      ),

                      /// Actions
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            /// Notifications
                            Consumer(
                              builder: (
                                final _,
                                final WidgetRef ref,
                                final Widget? child,
                              ) =>
                                  Stack(
                                alignment: Alignment.topRight,
                                children: <Widget>[
                                  iconButton(
                                    theme,
                                    CupertinoIcons.bell_fill,
                                    radius: 15,
                                    iconSize: 18.75,
                                    onTap: () {},
                                  ),
                                  if (true)
                                    Positioned(
                                      right: 2,
                                      child: Material(
                                        type: MaterialType.circle,
                                        color: lightScheme.error,
                                        child: const SizedBox(
                                          height: 8,
                                          width: 8,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),

                            /// Menu
                            const SizedBox(width: 16),
                            iconButton(
                              theme,
                              CupertinoIcons.person_fill,
                              radius: 15,
                              iconSize: 18.75,
                              onTap: () => navigator.push(
                                TransparentRoute<void>(
                                  backgroundColor: Colors.transparent,
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                  builder: (final _) => DismissiblePage(
                                    direction:
                                        DismissiblePageDismissDirection.none,
                                    minScale: 3 / 4,
                                    reverseDuration:
                                        const Duration(milliseconds: 500),
                                    backgroundColor: Colors.transparent,
                                    onDismissed: navigator.maybePop,
                                    child: const Hero(
                                      tag: 'menu',
                                      child: B2CMenu(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        /// Bonus Cards
        if (bonusesPresent ?? false) ...<Widget>[
          SizedBox(
            height: BonusCard.recommendedHeight,
            child: Consumer(
              builder: (final _, final WidgetRef ref, final Widget? child) {
                final List<BonusModel> bonuses = ref.watch(
                  bonusesProvider.select(
                    (final _) => (_.valueOrNull!.toList())
                        .sublist(0, _.valueOrNull!.length.clamp(0, 5)),
                  ),
                );
                return Swiper(
                  loop: bonuses.length > 1,
                  pagination: bonuses.length > 1
                      ? SwiperPagination(
                          margin: const EdgeInsets.only(bottom: 5),
                          builder: DotSwiperPaginationBuilder(
                            size: 6,
                            activeSize: 6,
                            color: theme.colorScheme.outline,
                            activeColor: theme.colorScheme.primary,
                          ),
                        )
                      : null,
                  itemCount: bonuses.length,
                  itemBuilder: (final BuildContext context, final int index) =>
                      Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BonusCard(bonuses.elementAt(index)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ] else if (bonusesPresent == null && showBonusesShimmer) ...<Widget>[
          Shimmer(
            color: theme.brightness == Brightness.light
                ? theme.colorScheme.onSurface
                : theme.colorScheme.surface,
            colorOpacity: 1 / 10,
            duration: const Duration(seconds: 2, milliseconds: 500),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              shape: outlinedBorder(theme, radius: 10),
              child: const SizedBox(
                height: BonusCard.recommendedHeight,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        /// Action Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 110,
            child: Row(
              children: <Widget>[
                /// First Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: theme.colorScheme.surface,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => navigator.push(
                      PageTransition<void>(
                        type: PageTransitionType.fade,
                        child: const ContainersScreen(),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: Image.asset(assets.container),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            $.containers.containers,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                /// Second Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: theme.colorScheme.surface,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: Image.asset(assets.delivery),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            $.delivery.delivery,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Grabbing
        Padding(
          padding: const EdgeInsets.all(16).copyWith(top: 12, bottom: 4),
          child: divider(width: 130),
        ),
      ],
    );
  }
}
