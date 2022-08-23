import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../providers/flutter_providers.dart';
import 'b2c_expanded.dart';
import 'b2c_screen.dart';

/// The overlay for the [B2CExpanded] on [B2CScreen].
class B2CExpandedOverlay extends HookConsumerWidget {
  /// The overlay for the [B2CExpanded] on [B2CScreen].
  const B2CExpandedOverlay({final super.key});

  /// The height of the [B2CExpanded].
  static const double expandedHeight = 370;

  /// The controller of the [SnappingSheet] on this screen.
  static final SnappingSheetController snapController =
      SnappingSheetController();

  /// The main [SnappingPosition] of the [SnappingSheet] on this screen.
  static const SnappingPosition mainSnappingPosition = SnappingPosition.factor(
    positionFactor: 1,
    grabbingContentOffset: GrabbingContentOffset.bottom,
    snappingCurve: Curves.easeOut,
    snappingDuration: Duration(milliseconds: 400),
  );

  /// Sheet height from 0 to 1.
  static final StateProvider<double> _sheetHeight =
      StateProvider<double>((final StateProviderRef<double> ref) => 0);

  static final Provider<double> _expandedSnappingPositionHeightProvider =
      Provider<double>(
    (final ProviderRef<double> ref) => ref.watch(
      mediaQueryProvider.select(
        (final MediaQueryData? mediaQuery) {
          double height = mediaQuery!.size.height;
          height = (height - expandedHeight).clamp(0, height);
          return height < 100 ? 0 : height;
        },
      ),
    ),
    dependencies: <ProviderOrFamily>[mediaQueryProvider],
  );

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final double expandedSnappingPositionHeight =
        ref.watch(_expandedSnappingPositionHeightProvider);
    final SnappingPosition expandedSnappingPosition = SnappingPosition.pixels(
      positionPixels: expandedSnappingPositionHeight,
      grabbingContentOffset: GrabbingContentOffset.top,
      snappingCurve: Curves.easeOut,
      snappingDuration: const Duration(milliseconds: 500),
    );

    return SnappingSheet(
      key: ValueKey<SnappingPosition>(expandedSnappingPosition),
      controller: snapController,
      lockOverflowDrag: true,
      onSheetMoved: (final _) => ref.read(_sheetHeight.notifier).state =
          (1 - _.relativeToSheetHeight).clamp(0, 1),
      snappingPositions: <SnappingPosition>[
        if (snapController.isAttached &&
            snapController.currentSnappingPosition == mainSnappingPosition)
          mainSnappingPosition
        else
          expandedSnappingPosition,
        if (snapController.isAttached &&
            snapController.currentSnappingPosition == mainSnappingPosition)
          expandedSnappingPosition
        else
          mainSnappingPosition
      ],
      sheetAbove: SnappingSheetContent(
        draggable: true,
        sizeBehavior: SheetSizeStatic(
          size: expandedSnappingPositionHeight == 0
              ? mediaQuery.size.height
              : expandedHeight,
          expandOnOverflow: false,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.light
                          ? Colors.white.withOpacity(1 / 5)
                          : Colors.black.withOpacity(1 / 5),
                    ),
                    child: const Align(),
                  ),
                ),
              ),
            ),
            const SafeArea(child: B2CExpanded()),
          ],
        ),
      ),
      sheetBelow: SnappingSheetContent(
        draggable: true,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            /// Shadow background with animated opacity.
            Consumer(
              builder: (final _, final WidgetRef ref, final Widget? child) {
                final double opacity = ref.watch(
                  _sheetHeight.select(
                    (final double height) => Curves.easeOut
                        .transform((height - 1 / 6).clamp(0.001, 1))
                        .clamp(0.001, 1 / 3),
                  ),
                );
                return IgnorePointer(
                  ignoring: opacity < 0.01,
                  child: Opacity(opacity: opacity, child: child),
                );
              },
              child: GestureDetector(
                onTap: () =>
                    snapController.snapToPosition(mainSnappingPosition),
                child: const ColoredBox(
                  color: Colors.black,
                  child: SizedBox.expand(),
                ),
              ),
            ),

            /// Chevron with animated opacity.
            Consumer(
              builder: (final _, final WidgetRef ref, final Widget? child) =>
                  Opacity(
                opacity: ref.watch(
                  _sheetHeight.select(
                    (final double height) => Curves.easeOutQuad.transform(
                      1 - (height * 2 + 1 / 4).clamp(.001, 1),
                    ),
                  ),
                ),
                child: child,
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 64 + 8,
                  child: ExpandTapWidget(
                    onTap: () => snapController.snapToPosition(
                      ref.read(_sheetHeight) < 0.01
                          ? expandedSnappingPosition
                          : mainSnappingPosition,
                    ),
                    tapPadding: EdgeInsets.zero,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 26, top: 8),
                      child: _B2CAnimatedChevon(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _B2CAnimatedChevon extends StatefulWidget {
  // ignore: unused_element
  const _B2CAnimatedChevon({final this.count = 3, final super.key});

  /// The total count of chevrons.
  final int count;

  static const double from = 2.5;
  static const Duration duration = Duration(seconds: 2);

  @override
  State<StatefulWidget> createState() => _B2CAnimatedChevonState();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties..add(IntProperty('count', count)));
  }
}

class _B2CAnimatedChevonState extends State<_B2CAnimatedChevon>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(final BuildContext context) {
    super.build(context);
    final ThemeData theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          child: FadeIn(
            key: const ValueKey<String>('b2c_chevron_background'),
            animate: false,
            manualTrigger: true,
            duration: _B2CAnimatedChevon.duration * 2,
            controller: (final AnimationController controller) async {
              while (mounted) {
                await controller.repeat(min: 1 / 3, max: 1 / 2, reverse: true);
              }
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: theme.colorScheme.onPrimary,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const SizedBox.square(dimension: 36),
            ),
          ),
        ),
        for (int index = 0; index < widget.count; index++)
          Positioned(
            top: _B2CAnimatedChevon.from * index * 2,
            child: FadeOutDown(
              key: ValueKey<String>('b2c_chevron_$index'),
              from: _B2CAnimatedChevon.from,
              duration: _B2CAnimatedChevon.duration,
              manualTrigger: true,
              controller: (final AnimationController controller) async {
                final int millis = _B2CAnimatedChevon.duration.inMilliseconds;
                await Future<void>.delayed(
                  Duration(milliseconds: (millis * (1 + index * 0.1)).toInt()),
                );
                while (mounted) {
                  await controller.repeat(
                    min: .25,
                    max: (.7 - index * 0.05).clamp(.25, 1),
                  );
                }
              },
              child: Icon(
                CupertinoIcons.chevron_compact_down,
                size: 28,
                color: theme.brightness == Brightness.dark
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.surface,
              ),
            ),
          ),
      ],
    );
  }
}
