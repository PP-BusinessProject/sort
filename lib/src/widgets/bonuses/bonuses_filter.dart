import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../providers/database/model_providers.dart';
import '../shared/shared_widgets.dart';

/// The filter used on [ContainerModel].
class BonusesFilter extends HookConsumerWidget {
  /// The filter used on [ContainerModel].
  const BonusesFilter({super.key});

  /// The current set fullness filter.
  static final StateProvider<double> priceFilterProvider =
      StateProvider<double>((final _) => 1);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final bool tankTypesLoaded = ref.watch(
      containerTankTypesProvider.select((final _) => _.valueOrNull != null),
    );
    return Shimmer(
      enabled: !tankTypesLoaded,
      color: theme.brightness == Brightness.light
          ? theme.colorScheme.surface
          : theme.colorScheme.onSurface,
      colorOpacity: 1 / 3,
      duration: const Duration(seconds: 4),
      child: DecoratedBox(
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
        // child: tankTypesLoaded ? const _BonusesFilterBody() : null,
      ),
    );
  }
}

class _BonusesFilterBody extends ConsumerWidget {
  const _BonusesFilterBody();

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final I18N $ = I18NLocalizations.of(context);
    return SafeArea(
      child: listView(
        mediaQuery,
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
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 18, 0),
                    child: _BonusesPriceFilter(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BonusesPriceFilter extends StatelessWidget {
  const _BonusesPriceFilter();

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
      child: const _BonusesPriceFilterState(),
    );
  }
}

class _BonusesPriceFilterState extends HookConsumerWidget {
  const _BonusesPriceFilterState();

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final bool Function() isMounted = useIsMounted();
    final StateProvider<double> priceFilter = BonusesFilter.priceFilterProvider;
    final ValueNotifier<double> state = useState<double>(ref.read(priceFilter));
    ref.listen(priceFilter, (final _, final double fullness) {
      if (state.value != fullness) {
        state.value = fullness;
      }
    });
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
        if (format.format(state.value) != format.format($value)) {
          state.value = $value;
        }
      },
      onChangeEnd: (final Object? value) {
        if (isMounted()) {
          final StateController<double> fullnessNotifier =
              ref.read(priceFilter.notifier);
          if (format.format(fullnessNotifier.state) != format.format(value)) {
            fullnessNotifier.state = value! as double;
          }
        }
      },
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
