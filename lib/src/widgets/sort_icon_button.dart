import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class SortIconButton extends StatelessWidget {
  const SortIconButton(
    final this.icon, {
    final this.iconSize,
    final this.iconColor,
    final this.radius,
    final this.color,
    final this.onTap,
    final super.key,
  });

  /// The icon of this button.
  final IconData icon;

  /// The size of the icon of button.
  final double? iconSize;

  /// The color of the icon of button.
  final Color? iconColor;

  /// The radius of this button.
  final double? radius;

  /// The background color of this button.
  final Color? color;

  /// The callback of this button.
  final FutureOr<void> Function()? onTap;

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double iconSize = this.iconSize ?? theme.iconTheme.size ?? 24;
    final double radius = this.radius ?? iconSize;
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[boxShadow(theme)],
      ),
      child: Material(
        type: MaterialType.circle,
        clipBehavior: Clip.hardEdge,
        color: color ?? theme.colorScheme.primary,
        child: InkWell(
          onTap: onTap,
          splashFactory: NoSplash.splashFactory,
          child: Padding(
            padding: EdgeInsets.all((radius * 2 - iconSize) / 2),
            child: Icon(
              icon,
              color: iconColor,
              size: (theme.iconTheme.size ?? 24) * (iconSize / 24),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(DiagnosticsProperty<IconData>('icon', icon))
        ..add(DoubleProperty('iconSize', iconSize))
        ..add(ColorProperty('iconColor', iconColor))
        ..add(DoubleProperty('radius', radius))
        ..add(ColorProperty('color', color))
        ..add(
          ObjectFlagProperty<FutureOr<void> Function()?>.has('onTap', onTap),
        ),
    );
  }
}
