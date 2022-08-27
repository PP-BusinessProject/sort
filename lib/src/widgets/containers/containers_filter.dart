import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../shared/shared_widgets.dart';

/// The available types for [ContainerTankTypeModel] filtering.
enum ContainerTankType {
  /// The `Organic` type.
  organic,

  /// The `Dry/Mixed` type.
  dryMixed;

  /// The translation of this filter.
  String translation(final I18N $) {
    switch (this) {
      case ContainerTankType.organic:
        return $.containers.filter.organic;
      case ContainerTankType.dryMixed:
        return $.containers.filter.dryMixed;
    }
  }
}

/// The filter used on [ContainerModel].
class ContainersFilter extends HookConsumerWidget {
  /// The filter used on [ContainerModel].
  const ContainersFilter({final super.key});

  /// The current set [ContainerTankTypeModel] filter.
  static final StateProvider<Iterable<ContainerTankType>>
      containerTypeFilterProvider = StateProvider<Iterable<ContainerTankType>>(
    (final StateProviderRef<Iterable<ContainerTankType>> ref) =>
        ContainerTankType.values,
  );

  /// The current set fullness filter.
  static final StateProvider<double> containerFullnessFilterProvider =
      StateProvider<double>((final _) => 1);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
    return DecoratedBox(
      decoration: theme.brightness == Brightness.light
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
              ),
            )
          : BoxDecoration(color: theme.scaffoldBackgroundColor),
      child: SafeArea(
        child: listView(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: <Widget>[
            ///Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                $.containers.filter.filter,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 32),

            /// Type
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      for (final ContainerTankType type
                          in ContainerTankType.values) ...<Widget>[
                        Expanded(child: _B2CContainersTypeFilterButton(type)),
                        const SizedBox(width: 24)
                      ],
                    ]..removeLast(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            /// Fullness Slider
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      $.containers.filter.fullness,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),

                  /// Slider
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 18, 0),
                    child: _B2CContainersFullnessFilter(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _B2CContainersTypeFilterButton extends HookConsumerWidget {
  const _B2CContainersTypeFilterButton(final this.type);

  final ContainerTankType type;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
    final StateProvider<Iterable<ContainerTankType>> filter =
        ContainersFilter.containerTypeFilterProvider;
    final bool filtered = ref.watch(
      filter.select((final _) => _.contains(type)),
    );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary:
            filtered ? theme.colorScheme.surface : theme.colorScheme.shadow,
      ),
      onPressed: () {
        final StateController<Iterable<ContainerTankType>> filteredState =
            ref.read(filter.notifier);
        if (!filtered || filteredState.state.length > 1) {
          filteredState.state = filtered
              ? <ContainerTankType>[
                  for (final ContainerTankType $type in filteredState.state)
                    if ($type != type) $type
                ]
              : <ContainerTankType>[...filteredState.state, type];
        }
      },
      child: Text(
        type.translation($),
        textAlign: TextAlign.center,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties..add(EnumProperty<ContainerTankType>('type', type)),
    );
  }
}

class _B2CContainersFullnessFilter extends StatelessWidget {
  const _B2CContainersFullnessFilter();

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SfSliderTheme(
      data: SfSliderThemeData(
        overlayRadius: 0,
        thumbRadius: 7,
        activeTrackHeight: 8,
        inactiveTrackHeight: 8,
        thumbColor: theme.brightness == Brightness.light
            ? theme.colorScheme.surface
            : theme.colorScheme.onSurface,
        activeTrackColor: theme.brightness == Brightness.light
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.primary,
        tooltipTextStyle: theme.textTheme.titleSmall,
      ),
      child: const _B2CContainersFullnessFilterState(),
    );
  }
}

class _B2CContainersFullnessFilterState extends HookConsumerWidget {
  const _B2CContainersFullnessFilterState();

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final bool Function() isMounted = useIsMounted();
    final StateProvider<double> fullnessFilter =
        ContainersFilter.containerFullnessFilterProvider;
    final ValueNotifier<double> state =
        useState<double>(ref.read(fullnessFilter));
    final NumberFormat format = useMemoized(NumberFormat.percentPattern);
    return SfSlider(
      value: state.value,
      shouldAlwaysShowTooltip: true,
      enableTooltip: true,
      trackShape: const _BorderSfTrackShape(),
      tooltipShape: const _BottomSfRectangularTooltipShape(),
      numberFormat: format,
      onChanged: (final Object? value) {
        final double $value = value! as double;
        if (format.format($value) != format.format(state.value)) {
          state.value = $value;
        }
      },
      onChangeEnd: (final Object? value) => isMounted()
          ? ref.read(fullnessFilter.notifier).state = value! as double
          : null,
    );
  }
}

class _BorderSfTrackShape extends SfTrackShape {
  const _BorderSfTrackShape();

  @override
  void paint(
    final PaintingContext context,
    final Offset offset,
    final Offset? thumbCenter,
    final Offset? startThumbCenter,
    final Offset? endThumbCenter, {
    required final RenderBox parentBox,
    required final SfSliderThemeData themeData,
    required final Animation<double> enableAnimation,
    required final Paint? inactivePaint,
    required final Paint? activePaint,
    required final ui.TextDirection textDirection,
    final SfRangeValues? currentValues,
    final Object? currentValue,
  }) {
    super.paint(
      context,
      offset,
      thumbCenter,
      startThumbCenter,
      endThumbCenter,
      themeData: themeData,
      enableAnimation: enableAnimation,
      parentBox: parentBox,
      inactivePaint: inactivePaint,
      activePaint: activePaint,
      textDirection: textDirection,
      currentValues: currentValues,
      currentValue: currentValue,
    );
    final Radius radius = Radius.circular(themeData.trackCornerRadius!);
    final Rect trackRect = getPreferredRect(parentBox, themeData, offset);
    final RRect trackRRect = RRect.fromRectAndRadius(trackRect, radius);
    final Paint trackStrokePaint = Paint()
      ..color = themeData.thumbStrokeColor ?? Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.bevel;
    context.canvas.drawRRect(trackRRect, trackStrokePaint);
  }
}

class _BottomSfRectangularTooltipShape extends SfRectangularTooltipShape {
  const _BottomSfRectangularTooltipShape();

  @override
  void paint(
    final PaintingContext context,
    final Offset thumbCenter,
    final Offset offset,
    final TextPainter textPainter, {
    required final RenderBox parentBox,
    required final SfSliderThemeData sliderThemeData,
    required final Paint paint,
    required final Animation<double> animation,
    required final Rect trackRect,
  }) {
    context.canvas.save();
    context.canvas.translate(thumbCenter.dx, thumbCenter.dy);
    context.canvas.scale(animation.value);
    final String text = textPainter.text!.toPlainText();
    final Offset $offset =
        Offset(24 - sliderThemeData.overlayRadius + text.length * 2.5, 7.5);
    textPainter.paint(context.canvas, offset - $offset);
    context.canvas.restore();
  }
}
