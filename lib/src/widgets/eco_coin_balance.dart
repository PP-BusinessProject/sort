import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../generated/assets.g.dart';

/// The widget to display current EcoCoin [balance].
class EcoCoinBalance extends StatelessWidget {
  /// The widget to display current EcoCoin [balance].
  const EcoCoinBalance(final this.balance, {final super.key});

  /// The current eco coin balance to display.
  final double balance;

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle? ecoCoinTextStyle = theme.textTheme.titleLarge;
    final double iconSize;
    if (ecoCoinTextStyle?.fontSize != null) {
      iconSize = ecoCoinTextStyle!.fontSize! * (ecoCoinTextStyle.height ?? 1);
    } else {
      iconSize = 16;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          balance.toStringAsFixed(0).padLeft(6),
          style: ecoCoinTextStyle,
        ),
        Image.asset(
          assets.ecocoin,
          width: iconSize,
          height: iconSize,
        ),
      ],
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties..add(DoubleProperty('balance', balance)),
    );
  }
}
