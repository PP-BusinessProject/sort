import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../extensions.dart';
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

  /// The recommended height of this widget.
  static const double recommendedHeight = 140;

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final I18NLocale currentLocale = I18NLocalizations.of(context)!.current;
    final I18N $ = currentLocale();
    return Card(
      shape: outlinedBorder(theme, radius: 10),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
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
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: marqueeText(
                          bonus.name(currentLocale.locale),
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Flexible(
                        child: marqueeText(
                          bonus.owner?.fullName(currentLocale.locale) ?? '',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size.fromHeight(0),
                            ),
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: Text(
                                $.bonus.purchase,
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
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
