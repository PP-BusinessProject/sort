import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_converters_lite/json_converters_lite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../generated/models.g.dart';
import '../../widgets/containers/containers_filter.dart';
import '../auth/supabase_session_provider.dart';

Iterable<T> Function(Object? value) _cast<T extends Object>(
  final JsonConverter<T, Map<String, Object?>> converter,
) =>
    (final Object? value) => IterableConverter(converter).fromJson(
          (value! as Iterable<Object?>).cast<Map<String, Object?>>(),
        );

final FutureProvider<Iterable<ContainerModel>?> containersProvider =
    FutureProvider<Iterable<ContainerModel>?>(
  (final FutureProviderRef<Iterable<ContainerModel>?> ref) async {
    final Iterable<int> filteredTypeIds =
        ref.watch(ContainersFilter.typeFilterProvider);
    final double filteredFullness =
        ref.watch(ContainersFilter.fullnessFilterProvider);
    PostgrestFilterBuilder statement = Supabase.instance.client.rest
        .from('containers')
        .select(<String>['*', 'tanks', 'address:addresses(*)'].join(','));
    if (filteredFullness < 1) {
      statement =
          statement.filter('tanks(current_volume)', 'lte', filteredFullness);
    }
    if (filteredTypeIds.isNotEmpty) {
      statement = statement.in_('tanks(type_id)', filteredTypeIds.toList());
    }
    return statement.withConverter(_cast(containerConverter));
  },
  dependencies: <ProviderOrFamily>[
    ContainersFilter.typeFilterProvider,
    ContainersFilter.fullnessFilterProvider
  ],
);

final FutureProvider<Iterable<ContainerReportTypeModel>?>
    containerReportTypesProvider =
    FutureProvider<Iterable<ContainerReportTypeModel>?>(
  (final FutureProviderRef<Iterable<ContainerReportTypeModel>?> ref) async =>
      Supabase.instance.client.rest
          .from('container_report_types')
          .select(
            <String>['*', 'locales:container_report_types_locales(*)']
                .join(','),
          )
          .withConverter(_cast(containerReportTypeConverter)),
);

final FutureProvider<Iterable<ContainerTankTypeModel>?>
    containerTankTypesProvider =
    FutureProvider<Iterable<ContainerTankTypeModel>?>(
  (final FutureProviderRef<Iterable<ContainerTankTypeModel>?> ref) async =>
      Supabase.instance.client.rest
          .from('container_tank_types')
          .select(
            <String>['*', 'locales:container_tank_types_locales(*)'].join(','),
          )
          .withConverter(_cast(containerTankTypeConverter)),
);

final FutureProvider<Iterable<CompanyBonusModel>?> bonusesProvider =
    FutureProvider<Iterable<CompanyBonusModel>?>(
  (final FutureProviderRef<Iterable<CompanyBonusModel>?> ref) async =>
      Supabase.instance.client.rest
          .from('bonuses')
          .select(
            <String>[
              '*',
              'locales:bonus_locales(*)',
              'owner:users(*)',
              'prices:bonus_prices(*)',
              'bonus_images(*,image:images(*))'
            ].join(','),
          )
          .withConverter(_cast(companyBonusConverter)),
);

final FutureProvider<PersonModel?> personProvider =
    FutureProvider<PersonModel?>(
  (final FutureProviderRef<PersonModel?> ref) async {
    final String? userId =
        ref.watch(sessionProvider.select((final _) => _.valueOrNull?.user?.id));
    if (userId == null) {
      return null;
    }
    final Iterable<PersonModel>? people = await Supabase.instance.client.rest
        .from('people')
        .select(<String>['*'].join(','))
        .filter('user_id', 'eq', userId)
        .withConverter(_cast(personConverter));
    return people == null || people.isEmpty ? null : people.first;
  },
  dependencies: <ProviderOrFamily>[sessionProvider],
);

final FutureProvider<Iterable<LocaleModel>?> localesProvider =
    FutureProvider<Iterable<LocaleModel>?>(
  (final FutureProviderRef<Iterable<LocaleModel>?> ref) async => await Supabase
      .instance.client.rest
      .from('locales')
      .select()
      .withConverter(_cast(localeConverter)),
);
