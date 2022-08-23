import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart'
    show StaticMapController, Location, MapScale;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../flavors.dart';
import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../hooks/widget_state_hook.dart';
import '../../providers/location_providers.dart';
import '../../providers/misc_providers.dart';
import '../../providers/model_providers.dart';
import '../containers/container_card.dart';
import '../shared/shared_dialogs.dart';
import '../shared/shared_widgets.dart';
import 'b2c_containers_filter.dart';
import 'b2c_expanded_overlay.dart';

/// The main screen of the [SortFlavor.b2c].
class B2CScreen extends HookConsumerWidget {
  /// The main screen of the [SortFlavor.b2c].
  const B2CScreen({final super.key});

  /// The fallback default map location.
  static final LatLng defaultLatLng = LatLng(50.450001, 30.523333);

  /// The key with the current state of the [InnerDrawer].
  static final GlobalKey<InnerDrawerState> drawerKey = GlobalKey();

  // ignore: close_sinks
  static final StreamController<LatLng> _mapNavigationController =
      StreamController<LatLng>.broadcast();

  /// The sink used to add map navigation events.
  static StreamSink<LatLng> get mapNavigation => _mapNavigationController.sink;

  /// The key with the current state of the [InnerDrawer].
  static final StateProvider<ContainerModel?> _selectedContainerProvider =
      StateProvider<ContainerModel?>((final _) => null);

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

  static const String customGoogleMapUrl =
      '''https://maps.googleapis.com/maps/api/staticmap?key=AIzaSyA79I49uHsh9f7OEOLC1_Dx-VgQ4Kc1NnA&size=640x640&center=50.450001%2C30.523333000000008&zoom=10&x={x}&y={y}&z={z}''';

  static final StaticMapController _controller = StaticMapController(
    googleApiKey: 'AIzaSyA79I49uHsh9f7OEOLC1_Dx-VgQ4Kc1NnA',
    width: 640,
    height: 640,
    zoom: 10,
    scale: MapScale.scale2,
    center: Location(defaultLatLng.latitude, defaultLatLng.longitude),
  );

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
    final bool Function() isMounted = useIsMounted();
    final MapController controller = useMemoized(MapController.new);
    useWidgetState(dispose: controller.dispose);
    final ObjectRef<bool> isMovingToCurrentLocation = useRef<bool>(false);

    final ObjectRef<Tween<double>?> latitudeTween =
        useRef<Tween<double>?>(null);
    final ObjectRef<Tween<double>?> longtitudeTween =
        useRef<Tween<double>?>(null);
    final ObjectRef<Tween<double>?> zoomTween = useRef<Tween<double>?>(null);
    final AnimationController mapAnimationController =
        useAnimationController(duration: const Duration(milliseconds: 750));

    Future<void> animateTo(
      final LatLng latLng, {
      final double zoom = 14,
    }) async {
      latitudeTween.value = Tween<double>(
        begin: controller.center.latitude,
        end: latLng.latitude,
      );
      longtitudeTween.value = Tween<double>(
        begin: controller.center.longitude,
        end: latLng.longitude,
      );
      zoomTween.value = Tween<double>(begin: controller.zoom, end: zoom);
      try {
        if (B2CExpandedOverlay.snapController.currentSnappingPosition !=
            B2CExpandedOverlay.mainSnappingPosition) {
          await B2CExpandedOverlay.snapController
              .snapToPosition(B2CExpandedOverlay.mainSnappingPosition);
        }
        mapAnimationController.reset();
        return await mapAnimationController.forward();
      } finally {
        latitudeTween.value = longtitudeTween.value = zoomTween.value = null;
      }
    }

    /// Move to the current location provided by [latLngProvider].
    ///
    /// * If location permission is not granted, request the permission.
    /// * If location services are disabled, request to enable the services.
    Future<void> moveToCurrentLocation() async {
      final AsyncValue<LatLng> snapshot = ref.read(latLngProvider);
      if (snapshot.valueOrNull != null) {
        await animateTo(snapshot.valueOrNull!);
      } else if (!snapshot.hasError) {
        return;
      }
      if (snapshot.error is PermissionDeniedException) {
        final LocationPermission permission =
            await Geolocator.requestPermission();
        if (!isMounted()) {
          return;
        } else if (permission == LocationPermission.deniedForever ||
            permission == LocationPermission.unableToDetermine) {
          // ignore: use_build_context_synchronously
          await dialog(
            theme,
            title: $.alert.locationDenied.title,
            body: $.alert.locationDenied.body,
            approve: $.alert.locationDenied.approve,
            deny: $.alert.locationDenied.deny,
            onApprove: () async => await Geolocator.openAppSettings()
                ? await navigator.maybePop()
                : null,
            onDeny: navigator.maybePop,
          ).show<void>(context);
        }
      } else if (snapshot.error is LocationServiceDisabledException &&
          isMounted()) {
        // ignore: use_build_context_synchronously
        await dialog(
          theme,
          title: $.alert.locationDisabled.title,
          body: $.alert.locationDisabled.body,
          approve: $.alert.locationDisabled.approve,
          deny: $.alert.locationDisabled.deny,
          onApprove: () async => await Geolocator.openLocationSettings()
              ? await navigator.maybePop()
              : null,
          onDeny: navigator.maybePop,
        ).show<void>(context);
      } else {
        return;
      }

      if (isMounted()) {
        final LocationPermission permission =
            await Geolocator.checkPermission();
        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          ref.refresh(latLngProvider);
          await moveToCurrentLocation();
        }
      }
    }

    useMemoized(() {
      _mapNavigationController.stream
          .listen((final _) => animateTo(_, zoom: 18));
      final Animation<double> animation = CurvedAnimation(
        parent: mapAnimationController,
        curve: Curves.fastOutSlowIn,
      );
      mapAnimationController.addListener(() {
        final Tween<double>? latitude = latitudeTween.value;
        final Tween<double>? longtitude = longtitudeTween.value;
        final Tween<double>? zoom = zoomTween.value;
        if (latitude != null && longtitude != null && zoom != null) {
          controller.move(
            LatLng(
              latitude.evaluate(animation),
              longtitude.evaluate(animation),
            ),
            zoom.evaluate(animation),
          );
        }
      });
    });

    return InnerDrawer(
      key: drawerKey,
      onTapClose: true,
      swipe: false,
      offset: const IDOffset.horizontal(1 / 3),
      rightChild: const B2CContainersFilter(),
      scaffold: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          FlutterMap(
            mapController: controller,
            options: MapOptions(
              zoom: 14,
              keepAlive: true,
              center: defaultLatLng,
              onTap: (final _, final LatLng latLng) =>
                  ref.refresh(_selectedContainerProvider.notifier),
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            children: <Widget>[
              TileLayer(
                urlTemplate: googleMapUrl,
                minZoom: 4,
                userAgentPackageName: ref.watch(
                  packageInfoProvider.select(
                    (final PackageInfo info) => info.packageName,
                  ),
                ),
              ),

              // MarkerClusterLayerOptions(
              //   rotate: false,
              //   markers: <Marker>[
              //     for (final LatLng latLng
              //         in ref.watch(_containerLatLngProvider))
              //       Marker(
              //         point: latLng,
              //         rotate: false,
              //         builder: (final BuildContext context) => Container(
              //           height: 200,
              //           width: 200,
              //           color: Colors.red,
              //         ),
              //       )
              //   ],
              //   builder: (final _, final List<Marker> markers) =>
              //       FloatingActionButton(
              //     onPressed: null,
              //     child: Text(markers.length.toString()),
              //   ),
              // ),

              Consumer(
                builder: (final _, final WidgetRef ref, final Widget? child) {
                  final LatLng? latLng = ref.watch(
                    latLngProvider.select((final _) => _.valueOrNull),
                  );
                  return MarkerLayer(
                    markers: <Marker>[
                      if (latLng != null)
                        Marker(
                          point: latLng,
                          rotate: false,
                          builder: (final _) => Container(
                            height: 250,
                            width: 250,
                            color: Colors.blue,
                          ),
                        ),
                      for (final LatLng latLng in ref.watch(
                        containersProvider.select(
                          (final Iterable<ContainerModel> containers) =>
                              containers.map(
                            (final ContainerModel container) => LatLng(
                              container.latitude,
                              container.longtitude,
                            ),
                          ),
                        ),
                      ))
                        Marker(
                          point: latLng,
                          rotate: false,
                          builder: (final _) => GestureDetector(
                            onTap: () async {
                              (ref.read(_selectedContainerProvider.notifier))
                                      .state =
                                  (ref.read(containersProvider))
                                      .whereType<ContainerModel?>()
                                      .firstWhere(
                                        (final ContainerModel? container) =>
                                            container!.latitude ==
                                                latLng.latitude &&
                                            container.longtitude ==
                                                latLng.longitude,
                                        orElse: () => null,
                                      );
                              double zoom = controller.zoom;
                              zoom = zoom.clamp(14, zoom < 14 ? 14 : zoom);
                              await animateTo(latLng, zoom: zoom);
                            },
                            child: Container(
                              height: 200,
                              width: 200,
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),

          /// Action Buttons
          Align(
            alignment: Alignment.bottomRight,
            child: Consumer(
              builder: (final _, final WidgetRef ref, final Widget? child) {
                final ContainerModel? selectedContainer =
                    ref.watch(_selectedContainerProvider);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    /// Current Location
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: iconButton(
                        theme,
                        CupertinoIcons.location_fill,
                        iconSize: 28,
                        radius: 24,
                        onTap: () async {
                          if (!isMovingToCurrentLocation.value) {
                            isMovingToCurrentLocation.value = true;
                            try {
                              await moveToCurrentLocation();
                            } finally {
                              isMovingToCurrentLocation.value = false;
                            }
                          }
                        },
                      ),
                    ),

                    /// Filter
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: iconButton(
                        theme,
                        CupertinoIcons.bars,
                        iconSize: 32,
                        radius: 24,
                        onTap: () => drawerKey.currentState?.open(),
                      ),
                    ),

                    if (selectedContainer != null) ...<Widget>[
                      const SizedBox(height: 16),
                      Flexible(
                        child: SizedBox(
                          height: 104,
                          child: ContainerCardSwiper(selectedContainer),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                );
              },
            ),
          ),

          const B2CExpandedOverlay(),
        ],
      ),
    );
  }
}

/// The swiper of [ContainerModel] on [B2CScreen].
class ContainerCardSwiper extends HookConsumerWidget {
  /// The swiper of [ContainerModel] on [B2CScreen].
  const ContainerCardSwiper(final this.container, {final super.key});

  /// The first model of this [Swiper].
  final ContainerModel container;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final int itemCount = ref.watch(
      B2CScreen._containerLatLngProvider
          .select((final _) => _.length.clamp(1, 3)),
    );
    return Swiper(
      loop: itemCount > 1,
      itemCount: itemCount,
      itemBuilder: (final BuildContext context, final int index) {
        final ContainerModel container;
        if (index == 0) {
          container = this.container;
        } else {
          final Iterable<ContainerModel> containers =
              ref.read(containersProvider);
          final int index = containers.toList().indexOf(this.container);
          int newIndex = index + (index == 1 ? 1 : -1);
          if (newIndex >= containers.length) {
            newIndex = 0;
          } else if (newIndex < 0) {
            newIndex = containers.length - 1;
          }
          container = containers.elementAt(newIndex);
        }
        return Consumer(
          builder: (final _, final WidgetRef ref, final Widget? child) {
            final String? address = ref.watch(
              addressProvider(LatLng(container.latitude, container.longtitude)),
            );
            return address == null
                ? child!
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ContainerCard(container, address),
                  );
          },
          child: const CircularProgressIndicator.adaptive(),
        );
      },
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(
          DiagnosticsProperty<ContainerModel>('container', container),
        ),
    );
  }
}
