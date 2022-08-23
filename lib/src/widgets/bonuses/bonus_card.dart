import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../styles.dart';
import '../shared/shared_widgets.dart';

/// The card used to display a [BonusModel].
class BonusCard extends StatelessWidget {
  /// The card used to display a [BonusModel].
  const BonusCard(final this.bonus, {final super.key});

  /// The bonus to display in this card.
  final BonusModel bonus;

  /// The outer paddinng of this widget
  static const EdgeInsets padding = EdgeInsets.all(16);

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
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
                  child: image(
                    bonus.images.isNotEmpty
                        ? bonus.images.first.image?.url
                        : null,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Align(
                        child: Text(
                          bonus.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Align(
                        child: Text(
                          bonus.owner?.firstName ?? '',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              $.bonus.purchase,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
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
              child: ecoCoinBalance(theme, balance: bonus.prices.first.value),
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
