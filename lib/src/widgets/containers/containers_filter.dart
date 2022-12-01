import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../extensions.dart';
import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../providers/database/model_providers.dart';
import '../shared/shared_widgets.dart';

/// The filter used on [ContainerModel].
class ContainersFilter extends HookConsumerWidget {
  /// The filter used on [ContainerModel].
  const ContainersFilter({super.key});

  /// The filter of the [ContainerTankTypeModel.id].
  ///
  /// The ids contained here will be disabled.
  static final StateProvider<Iterable<int>> typeFilterProvider =
      StateProvider<Iterable<int>>(
    (final StateProviderRef<Iterable<int>> ref) => <int>[],
  );

  /// The current set fullness filter.
  static final StateProvider<double> fullnessFilterProvider =
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
        child: tankTypesLoaded ? const _ContainerFilterBody() : null,
      ),
    );
  }
}

class _ContainerFilterBody extends ConsumerWidget {
  const _ContainerFilterBody();

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

          /// Type
          if (ref.watch(
            containerTankTypesProvider
                .select((final _) => _.valueOrNull!.isNotEmpty),
          )) ...<Widget>[
            const SizedBox(height: 32),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 80,
                  child: Consumer(
                    builder: (
                      final _,
                      final WidgetRef ref,
                      final Widget? child,
                    ) =>
                        Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        for (final ContainerTankTypeModel type in ref.watch(
                          containerTankTypesProvider
                              .select((final _) => _.valueOrNull!),
                        )) ...<Widget>[
                          Expanded(child: _ContainersTypeFilterButton(type)),
                          const SizedBox(width: 24)
                        ],
                      ]..removeLast(),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
                  child: _ContainersFullnessFilter(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContainersTypeFilterButton extends HookConsumerWidget {
  const _ContainersTypeFilterButton(this.type);

  final ContainerTankTypeModel type;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final I18NLocale currentLocale = I18NLocalizations.of(context)!.current;
    final StateProvider<Iterable<int>> filter =
        ContainersFilter.typeFilterProvider;
    final bool filtered =
        ref.watch(filter.select((final _) => _.isEmpty || _.contains(type.id)));
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            filtered ? theme.colorScheme.surface : theme.colorScheme.shadow,
      ),
      onPressed: () {
        final StateController<Iterable<int>> filteredNotifier =
            ref.read(filter.notifier);
        final Iterable<ContainerTankTypeModel> allTypes =
            ref.read(containerTankTypesProvider).valueOrNull!;
        if (filteredNotifier.state.isEmpty) {
          filteredNotifier.state = <int>[
            for (final ContainerTankTypeModel $type in allTypes)
              if ($type.id != type.id) $type.id!
          ];
        } else if (!filtered &&
            filteredNotifier.state.length == allTypes.length - 1) {
          filteredNotifier.state = const Iterable<int>.empty();
        } else if (!(filtered && filteredNotifier.state.length == 1)) {
          filteredNotifier.state = filtered
              ? <int>[
                  for (final int $typeId in filteredNotifier.state)
                    if ($typeId != type.id) $typeId
                ]
              : <int>[...filteredNotifier.state, type.id!];
        }
      },
      child: Text(
        type.name(currentLocale.locale),
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
      properties
        ..add(DiagnosticsProperty<ContainerTankTypeModel>('type', type)),
    );
  }
}

class _ContainersFullnessFilter extends StatelessWidget {
  const _ContainersFullnessFilter();

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
      child: const _ContainersFullnessFilterState(),
    );
  }
}

class _ContainersFullnessFilterState extends HookConsumerWidget {
  const _ContainersFullnessFilterState();

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final bool Function() isMounted = useIsMounted();
    final StateProvider<double> fullnessFilter =
        ContainersFilter.fullnessFilterProvider;
    final ValueNotifier<double> state =
        useState<double>(ref.read(fullnessFilter));
    ref.listen(fullnessFilter, (final _, final double fullness) {
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
              ref.read(fullnessFilter.notifier);
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
