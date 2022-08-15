import 'package:animate_do/animate_do.dart';
import 'package:blur/blur.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../flavors.dart';
import '../../generated/models.g.dart';
import '../../providers/flutter_providers.dart';
import '../../providers/misc_providers.dart';
import '../../providers/model_providers.dart';
import 'b2c_expanded.dart';

/// The main screen of the [SortFlavor.b2c].
class B2CScreen extends HookConsumerWidget {
  /// The main screen of the [SortFlavor.b2c].
  const B2CScreen({final super.key});

  /// The fallback default map location.
  static final LatLng defaultLatLng = LatLng(50.450001, 30.523333);

  static final Provider<Iterable<LatLng>> _containerLatLngProvider =
      Provider<Iterable<LatLng>>(
    (final ProviderRef<Iterable<LatLng>> ref) => ref.watch(
      containersProvider.select(
        (final Iterable<ContainerModel> containers) => containers.map(
          (final ContainerModel container) =>
              LatLng(container.latitude, container.longtitude),
        ),
      ),
    ),
  );

  /// Legal notice: This url is only used for demo and educational purposes.
  ///
  /// You need a license key for production use.
  static const String googleMapUrl =
      'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

  /// The height of the [B2CExpanded].
  static const double expandedHeight = 370;

  static const SnappingPosition _mainSnappingPosition = SnappingPosition.factor(
    positionFactor: 1,
    grabbingContentOffset: GrabbingContentOffset.bottom,
    snappingCurve: Curves.easeOut,
    snappingDuration: Duration(milliseconds: 400),
  );

  static final Provider<double> _expandedSnappingPositionHeightProvider =
      Provider<double>(
    (final ProviderRef<double> ref) => ref.watch(
      rootMediaQueryProvider.select(
        (final MediaQueryData? mediaQuery) {
          double height = mediaQuery!.size.height;
          height = (height - expandedHeight).clamp(0, height);
          return height < 100 ? 0 : height;
        },
      ),
    ),
    dependencies: <ProviderOrFamily>[rootMediaQueryProvider],
  );

  /// Sheet height from 0 to 1.
  static final StateProvider<double> _sheetHeight =
      StateProvider<double>((final StateProviderRef<double> ref) => 0);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final LatLng? latLng =
        ref.watch(latLngProvider.select((final _) => _.valueOrNull));
    final SnappingSheetController snapController =
        useMemoized(SnappingSheetController.new);
    final double expandedSnappingPositionHeight =
        ref.watch(_expandedSnappingPositionHeightProvider);
    final SnappingPosition expandedSnappingPosition = SnappingPosition.pixels(
      positionPixels: ref.watch(_expandedSnappingPositionHeightProvider),
      grabbingContentOffset: GrabbingContentOffset.top,
      snappingCurve: Curves.easeOut,
      snappingDuration: const Duration(milliseconds: 500),
    );
    return CupertinoPageScaffold(
      child: Stack(
        children: <Widget>[
          /// Map Stack
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              FlutterMap(
                options: MapOptions(
                  zoom: 14,
                  center: defaultLatLng,
                  plugins: <MapPlugin>[MarkerClusterPlugin()],
                  interactiveFlags:
                      InteractiveFlag.all & ~InteractiveFlag.rotate,
                ),
                layers: <LayerOptions>[
                  TileLayerOptions(
                    urlTemplate: googleMapUrl,
                    userAgentPackageName: ref.watch(
                      packageInfoProvider
                          .select((final PackageInfo info) => info.packageName),
                    ),
                  ),
                  MarkerClusterLayerOptions(
                    rotate: false,
                    markers: <Marker>[
                      for (final LatLng latLng
                          in ref.watch(_containerLatLngProvider))
                        Marker(
                          point: latLng,
                          rotate: false,
                          builder: (final BuildContext context) => Container(
                            height: 200,
                            width: 200,
                            color: Colors.red,
                          ),
                        )
                    ],
                    builder: (final _, final List<Marker> markers) =>
                        FloatingActionButton(
                      onPressed: null,
                      child: Text(markers.length.toString()),
                    ),
                  ),
                  MarkerLayerOptions(
                    markers: <Marker>[
                      if (latLng != null)
                        Marker(
                          point: latLng,
                          rotate: false,
                          builder: (final BuildContext context) => Container(
                            height: 250,
                            width: 250,
                            color: Colors.blue,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          /// Expanded Overlay
          SnappingSheet(
            key: ValueKey<SnappingPosition>(expandedSnappingPosition),
            controller: snapController,
            lockOverflowDrag: true,
            onSheetMoved: (final _) => ref.read(_sheetHeight.notifier).state =
                (1 - _.relativeToSheetHeight).clamp(0, 1),
            snappingPositions: <SnappingPosition>[
              if (snapController.isAttached &&
                  snapController.currentSnappingPosition ==
                      _mainSnappingPosition)
                _mainSnappingPosition
              else
                expandedSnappingPosition,
              if (snapController.isAttached &&
                  snapController.currentSnappingPosition ==
                      _mainSnappingPosition)
                expandedSnappingPosition
              else
                _mainSnappingPosition
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
                children: const <Widget>[
                  Blur(blur: 8, colorOpacity: 0, child: SizedBox.expand()),
                  SafeArea(child: B2CExpanded()),
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
                    builder:
                        (final _, final WidgetRef ref, final Widget? child) {
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
                          snapController.snapToPosition(_mainSnappingPosition),
                      child: const ColoredBox(
                        color: Colors.black,
                        child: SizedBox.expand(),
                      ),
                    ),
                  ),

                  /// Chevron with animated opacity.
                  Consumer(
                    builder:
                        (final _, final WidgetRef ref, final Widget? child) =>
                            Opacity(
                      opacity: ref.watch(
                        _sheetHeight.select(
                          (final double height) => Curves.easeOutQuad.transform(
                              1 - (height * 2 + 1 / 4).clamp(.001, 1)),
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
                                : _mainSnappingPosition,
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
          ),
        ],
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
