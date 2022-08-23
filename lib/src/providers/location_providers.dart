import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../utils/logger.dart';
import 'flutter_providers.dart';

/// The [Provider] of the current user's [LatLng].
final StreamProvider<LatLng> latLngProvider = StreamProvider<LatLng>(
  (final StreamProviderRef<LatLng> ref) => GeolocatorPlatform.instance
      .getPositionStream(locationSettings: const LocationSettings())
      .handleError(
        // ignore: argument_type_not_assignable_to_error_handler
        logger.e,
        test: (final Object? error) =>
            error is! PermissionDeniedException &&
            error is! LocationServiceDisabledException,
      )
      .map(
        (final Position position) =>
            LatLng(position.latitude, position.longitude),
      ),
);

/// The [Provider] of the placemarks for the specified [LatLng] with current
/// locale.
final FutureProviderFamily<List<Placemark>, LatLng> placemarksProvider =
    FutureProvider.family<List<Placemark>, LatLng>(
  (final FutureProviderRef<List<Placemark>> ref, final LatLng latLng) =>
      placemarkFromCoordinates(
    latLng.latitude,
    latLng.longitude,
    localeIdentifier: ref.watch(i18nProvider).name,
  ),
  dependencies: <ProviderOrFamily>[i18nProvider],
);

/// The [Provider] of the address for the specified [LatLng] with current
/// locale.
final ProviderFamily<String?, LatLng> addressProvider =
    Provider.family<String?, LatLng>(
  (final ProviderRef<String?> ref, final LatLng latLng) => ref.watch(
    placemarksProvider(latLng)
        .select((final AsyncValue<List<Placemark>> snapshot) {
      final List<Placemark>? addresses = snapshot.valueOrNull;
      if (addresses != null && addresses.isNotEmpty) {
        final String address = <String?>[
          addresses.first.street,
          addresses.first.name
        ].whereType<String>().join(', ');
        if (address.isNotEmpty) {
          return address;
        }
      }
      return null;
    }),
  ),
  dependencies: <ProviderOrFamily>[placemarksProvider],
);
