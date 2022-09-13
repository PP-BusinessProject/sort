import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../shared/shared_widgets.dart';
import 'bonuses_filter.dart';

/// The screen used to display multiple [BonusModel].
class BonusesScreen extends HookConsumerWidget {
  /// The screen used to display multiple [BonusModel].
  const BonusesScreen({final super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
    final ScrollController scrollController =
        PrimaryScrollController.of(context)!;

    final GlobalKey<InnerDrawerState> drawerKey = useMemoized(GlobalKey.new);
    return InnerDrawer(
      key: drawerKey,
      onTapClose: true,
      swipe: false,
      offset: const IDOffset.horizontal(1 / 3),
      rightChild: const BonusesFilter(),
      scaffold: CupertinoPageScaffold(
        navigationBar: navigationBar(
          theme,
          previousPageTitle: $.menu.menu,
          onPressed: navigator.maybePop,
          // trailing: Padding(
          //   padding: const EdgeInsetsDirectional.only(end: 16),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       Flexible(
          //         child: iconButton(
          //           theme,
          //           CupertinoIcons.cart,
          //           iconSize: 20,
          //           radius: 16,
          //           onTap: () => drawerKey.currentState?.open(),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
        child: listView(
          mediaQuery,
          alignment: Alignment.topCenter,
          children: <Widget>[
            // for (final BonusModel bonus in ref.watch(
            //   bonusesProvider.select(
            //     (final _) =>
            //         _.valueOrNull ?? const Iterable<BonusModel>.empty(),
            //   ),
            // ))
            //   Flexible(
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 24),
            //       child: BonusCard(bonus),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
