import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../generated/assets.g.dart';
import '../generated/i18n.g.dart';
import '../generated/models.g.dart';
import '../providers/flutter_providers.dart';
import '../styles.dart';
import 'eco_coin_balance.dart';

class SortBonusCard extends HookConsumerWidget {
  const SortBonusCard(final this.bonus, {final super.key});

  /// The bonus to display in this card.
  final BonusModel bonus;

  /// The outer paddinng of this widget
  static const EdgeInsets padding = EdgeInsets.all(16);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final I18N $ = ref.watch(i18nProvider)();
    return Card(
      margin: padding,
      shape: outlinedBorder(theme, radius: 10),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: bonus.images.isEmpty ||
                          bonus.images.first.image?.url == null
                      ? ColoredBox(
                          color: const Color(0xFFC4C4C4),
                          child: Center(
                            child: Image.asset(assets.logo, height: 40),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: bonus.images.first.image!.url,
                          fit: BoxFit.cover,
                        ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Text(
                        bonus.name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        bonus.owner?.firstName ?? '',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 48),
                          ),
                          onPressed: () {},
                          child: Text(
                            $.bonus.purchase,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (bonus.prices.isNotEmpty)
            Positioned(
              right: 8,
              bottom: 4,
              child: EcoCoinBalance(bonus.prices.first.value),
            ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties..add(DiagnosticsProperty<BonusModel>('bonus', bonus)),
    );
  }
}
