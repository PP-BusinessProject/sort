import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_converters_lite/json_converters_lite.dart';

import '../api.dart';
import '../generated/models.g.dart';
import '../widgets/containers/containers_filter.dart';
import 'flutter_providers.dart';

Iterable<T> Function(Object? value) _cast<T extends Object>(
  final JsonConverter<T, Map<String, Object?>> converter,
) =>
    (final Object? value) => IterableConverter(converter).fromJson(
          (value! as Iterable<Object?>).cast<Map<String, Object?>>(),
        );

final FutureProvider<Iterable<ContainerModel>> containersProvider =
    FutureProvider<Iterable<ContainerModel>>(
  (final FutureProviderRef<Iterable<ContainerModel>> ref) {
    final Iterable<int> filteredTypeIds =
        ref.watch(ContainersFilter.typeFilterProvider);
    final double filteredFullness =
        ref.watch(ContainersFilter.fullnessFilterProvider);
    return sortApi.get(
      '/containers',
      parameters: <String, Object?>{
        'tanks': null,
        'address': null,
        if (filteredFullness < 1) 'tanks.current_volume': '<=$filteredFullness',
        if (filteredTypeIds.isNotEmpty) 'tanks.type_id': filteredTypeIds
      },
      fromJson: _cast(containerConverter),
    );
  },
  dependencies: <ProviderOrFamily>[
    ContainersFilter.typeFilterProvider,
    ContainersFilter.fullnessFilterProvider
  ],
);

final FutureProvider<Iterable<ContainerReportTypeModel>>
    containerReportTypesProvider =
    FutureProvider<Iterable<ContainerReportTypeModel>>(
  (final FutureProviderRef<Iterable<ContainerReportTypeModel>> ref) =>
      sortApi.get(
    '/containerReportTypes',
    parameters: <String, Object?>{
      'locales': null,
    },
    fromJson: _cast(containerReportTypeConverter),
  ),
);

final FutureProvider<Iterable<ContainerTankTypeModel>>
    containerTankTypesProvider =
    FutureProvider<Iterable<ContainerTankTypeModel>>(
  (final FutureProviderRef<Iterable<ContainerTankTypeModel>> ref) =>
      sortApi.get(
    '/containerTankTypes',
    parameters: <String, Object?>{
      'locales': null,
    },
    fromJson: _cast(containerTankTypeConverter),
  ),
);

final FutureProvider<Iterable<BonusModel>> bonusesProvider =
    FutureProvider<Iterable<BonusModel>>(
  (final FutureProviderRef<Iterable<BonusModel>> ref) => sortApi.get(
    '/bonuses',
    parameters: <String, Object?>{
      'locales': null,
      'owner': null,
      'prices': null,
      'images.image': null,
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
        'person': null,
      },
      fromJson: _cast(userConverter),
    );
    return users.isEmpty ? null : users.first;
  },
  dependencies: <ProviderOrFamily>[$phoneNumberProvider],
);
