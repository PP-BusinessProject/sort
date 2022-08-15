import 'package:card_swiper/card_swiper.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generated/assets.g.dart';
import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../providers/flutter_providers.dart';
import '../../providers/model_providers.dart';
import '../../widgets/eco_coin_balance.dart';
import '../../widgets/sort_bonus_card.dart';
import '../../widgets/sort_icon_button.dart';
import 'b2c_menu.dart';
import 'b2c_screen.dart';

/// The expanded variant of the [B2CScreen].
class B2CExpanded extends HookConsumerWidget {
  /// The expanded variant of the [B2CScreen].
  const B2CExpanded({final super.key});

  /// The height of the appbar in the expanded widget.
  static const double appBarHeight = 50;

  /// The horizontal padding in the expanded widget.
  static const double horizontalPadding = 16;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = ref.watch(i18nProvider)();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        /// AppBar
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: SizedBox(
              height: appBarHeight,
              child: Stack(
                alignment: Alignment.topCenter,
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
                      child: Image.asset(assets.logo, height: 40),
                    ),
                  ),

                  /// Actions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      /// EcoCoin button
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                            style: theme.elevatedButtonTheme.style?.copyWith(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 8,
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: const EcoCoinBalance(1500),
                          ),
                        ),
                      ),

                      /// Actions
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Consumer(
                              builder: (
                                final _,
                                final WidgetRef ref,
                                final Widget? child,
                              ) =>
                                  Stack(
                                alignment: Alignment.topRight,
                                children: <Widget>[
                                  SortIconButton(
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
                                        color: theme.colorScheme.error,
                                        child:
                                            const SizedBox(height: 8, width: 8),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            SortIconButton(
                              CupertinoIcons.person_fill,
                              radius: 15,
                              iconSize: 18.75,
                              onTap: () => navigator.push(
                                TransparentRoute<void>(
                                  backgroundColor: Colors.transparent,
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                  builder: (final _) => DismissiblePage(
                                    isFullScreen: mediaQuery.orientation ==
                                        Orientation.landscape,
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
        if (ref.watch(
          bonusesProvider.select(
            (final Iterable<BonusModel> bonuses) => bonuses.isNotEmpty,
          ),
        ))
          SizedBox(
            height: 140 + SortBonusCard.padding.vertical,
            child: Consumer(
              builder: (final _, final WidgetRef ref, final Widget? child) {
                final List<BonusModel> bonuses = ref.watch(
                  bonusesProvider.select(
                    (final Iterable<BonusModel> bonuses) =>
                        bonuses.toList().sublist(0, bonuses.length.clamp(0, 5)),
                  ),
                );
                return Swiper(
                  loop: bonuses.length > 1,
                  pagination: bonuses.length > 1
                      ? SwiperPagination(
                          margin: EdgeInsets.only(
                            bottom: 5 + SortBonusCard.padding.bottom,
                          ),
                          builder: DotSwiperPaginationBuilder(
                            size: 6,
                            activeSize: 6,
                            color: theme.colorScheme.surfaceTint,
                            activeColor: theme.colorScheme.primary,
                          ),
                        )
                      : null,
                  itemCount: bonuses.length,
                  itemBuilder: (final BuildContext context, final int index) =>
                      SortBonusCard(bonuses.elementAt(index)),
                );
              },
            ),
          ),

        /// Action Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                    onPressed: () {},
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
                            $.container.containers,
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
          padding: const EdgeInsets.all(horizontalPadding)
              .copyWith(top: 12, bottom: 4),
          child: const Material(
            color: Color(0xFFC4C4C4),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: SizedBox(height: 4, width: 130),
          ),
        ),
      ],
    );
  }
}
