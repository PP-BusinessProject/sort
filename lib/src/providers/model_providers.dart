import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_converters_lite/json_converters_lite.dart';

import '../api.dart';
import '../generated/models.g.dart';
import 'flutter_providers.dart';

Iterable<T> Function(Object? value) _cast<T extends Object>(
  final JsonConverter<T, Map<String, Object?>> converter,
) =>
    (final Object? value) => IterableConverter(converter).fromJson(
          (value! as Iterable<Object?>).cast<Map<String, Object?>>(),
        );

final FutureProvider<Iterable<ContainerTankTypeModel>>
    containerTankTypesProvider =
    FutureProvider<Iterable<ContainerTankTypeModel>>(
  (final FutureProviderRef<Iterable<ContainerTankTypeModel>> ref) => sortApi
      .get('/containerTankTypes', fromJson: _cast(containerTankTypeConverter)),
);

final FutureProvider<Iterable<ContainerModel>> containersProvider =
    FutureProvider<Iterable<ContainerModel>>(
  (final FutureProviderRef<Iterable<ContainerModel>> ref) =>
      sortApi.get('/containers', fromJson: _cast(containerConverter)),
);

final FutureProvider<Iterable<BonusModel>> bonusesProvider =
    FutureProvider<Iterable<BonusModel>>(
  (final FutureProviderRef<Iterable<BonusModel>> ref) => sortApi.get(
    '/bonuses',
    parameters: <String, Object?>{
      'field': <String>['owner', 'prices', 'images.image']
    },
    fromJson: _cast(bonusConverter),
  ),
);

final FutureProvider<UserModel?> userProvider = FutureProvider<UserModel?>(
  (final FutureProviderRef<UserModel?> ref) async {
    final int? phoneNumber = ref.watch($phoneNumberProvider);
    if (phoneNumber == null) {
      return null;
    }
    final Iterable<UserModel> users = await sortApi.get(
      '/users',
      parameters: <String, Object?>{
        'phone_number': phoneNumber,
        'field': <String>['person']
      },
      fromJson: _cast(userConverter),
    );
    return users.isEmpty ? null : users.first;
  },
  dependencies: <ProviderOrFamily>[$phoneNumberProvider],
);
