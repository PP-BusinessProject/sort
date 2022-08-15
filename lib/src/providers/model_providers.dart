import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_converters_lite/json_converters_lite.dart';

import '../api.dart';
import '../generated/models.g.dart';
import '../notifiers/content_notifier.dart';
import 'flutter_providers.dart';

/// An alias to the [StateNotifierProvider] for a [ContentNotifier].
typedef ContentProvider<T extends Object>
    = StateNotifierProvider<ContentNotifier<T>, Iterable<T>>;

/// An alias to the [StateNotifierProviderRef] for a [ContentNotifier].
typedef ContentProviderRef<T extends Object>
    = StateNotifierProviderRef<ContentNotifier<T>, Iterable<T>>;

/// An alias to the [StateNotifierProvider] for a [ContentOptionalNotifier].
typedef ContentOptionalProvider<T extends Object?>
    = StateNotifierProvider<ContentOptionalNotifier<T?>, T?>;

/// An alias to the [StateNotifierProviderRef] for a [ContentOptionalNotifier].
typedef ContentOptionalProviderRef<T extends Object?>
    = StateNotifierProviderRef<ContentOptionalNotifier<T?>, T?>;

ContentNotifier<T> contentProvider<T extends Object>(
  final String path, {
  required final JsonConverter<T, Map<String, Object?>> converter,
  final Map<String, Object?>? parameters,
}) =>
    ContentNotifier<T>(
      refreshState: () => sortApi.get(
        path,
        parameters: parameters,
        fromJson: (final Object? value) =>
            IterableConverter(converter).fromJson(
          (value! as Iterable<Object?>).cast<Map<String, Object?>>(),
        ),
      ),
      // stream: sortApi.getStream(
      //   path,
      //   parameters: parameters,
      //   fromJson: (final Object? value) =>
      //       IterableConverter(converter).fromJson(
      //     (value! as Iterable<Object?>).cast<Map<String, Object?>>(),
      //   ),
      //   suppress: true,
      // ),
    );

ContentOptionalNotifier<T?> contentOptionalProvider<T extends Object>(
  final String path, {
  required final JsonConverter<T, Map<String, Object?>> converter,
  required final Map<String, Object?>? parameters,
  final FutureOr<T?> Function()? initialState,
}) =>
    ContentOptionalNotifier<T?>(
      refreshState: () async {
        if (parameters == null) {
          return null;
        }
        final T? $initialState = await initialState?.call();
        if ($initialState != null) {
          return $initialState;
        }
        final Iterable<T> items = await sortApi.get<Iterable<T>>(
          path,
          fromJson: (final Object? value) =>
              IterableConverter(converter).fromJson(
            (value! as Iterable<Object?>).cast<Map<String, Object?>>(),
          ),
          parameters: parameters,
        );
        return items.isEmpty ? null : items.single;
      },

      // stream: parameters == null
      //     ? Stream<StreamEvent<Iterable<T?>>>.empty()
      //     : sortApi
      //         .getStream<Iterable<T>>(
      //           path,
      //           fromJson: (final Object? value) =>
      //               IterableConverter(converter).fromJson(
      //             (value! as Iterable<Object?>).cast<Map<String, Object?>>(),
      //           ),
      //           parameters: parameters,
      //           suppress: true,
      //         )
      //         .where(
      //           (final StreamEvent<Iterable<T>> event) =>
      //               event.prevValue.isNotEmpty || event.value.isNotEmpty,
      //         ),
    );

final StateProviderFamily<bool, String> _loadingProvider =
    StateProvider.family<bool, String>(
  (final StateProviderRef<bool> ref, final String key) => true,
);

final ContentProvider<ContainerModel> containersProvider =
    ContentProvider<ContainerModel>(
  (final ContentProviderRef<ContainerModel> ref) => contentProvider(
    '/containers',
    converter: containerConverter,
  ),
);

final ContentProvider<BonusModel> bonusesProvider = ContentProvider<BonusModel>(
  (final ContentProviderRef<BonusModel> ref) => contentProvider(
    '/bonuses',
    converter: bonusConverter,
    parameters: <String, Object?>{
      'field': <String>['owner', 'prices', 'images.image']
    },
  ),
);

final Provider<bool> userLoadingProvider = Provider<bool>(
  (final ProviderRef<bool> ref) => ref.watch(_loadingProvider('user')),
  dependencies: <ProviderOrFamily>[_loadingProvider],
);

final ContentOptionalProvider<UserModel?> userProvider =
    ContentOptionalProvider<UserModel?>(
  (final ContentOptionalProviderRef<UserModel?> ref) {
    final StateController<bool> isLoading =
        ref.refresh(_loadingProvider('user').notifier);
    final int? phoneNumber = ref.watch($phoneNumberProvider);
    return contentOptionalProvider(
      '/users',
      converter: userConverter,
      parameters: phoneNumber != null
          ? <String, Object?>{
              'phone_number': phoneNumber,
              'field': <String>['person']
            }
          : null,
    )
      ..addRefreshListener(() => isLoading.state = true)
      ..addRefreshCallback((final bool success) => isLoading.state = false);
  },
  dependencies: <ProviderOrFamily>[
    $phoneNumberProvider,
    _loadingProvider('user').notifier,
  ],
);

// final Provider<bool> personLoadingProvider = Provider<bool>(
//   (final ProviderRef<bool> ref) => ref.watch(_loadingProvider('person')),
//   dependencies: <ProviderOrFamily>[_loadingProvider],
// );

// final ContentOptionalProvider<PersonModel?> personProvider =
//     ContentOptionalProvider<PersonModel?>(
//   (final ContentOptionalProviderRef<PersonModel?> ref) {
//     final StateController<bool> isLoading =
//         ref.refresh(_loadingProvider('person').notifier);
//     final int? userId =
//         ref.watch(userProvider.select((final UserModel? user) => user?.id));
//     return contentOptionalProvider(
//       '/people',
//       converter: personConverter,
//       parameters: userId != null ? <String, Object?>{'user_id': userId} : null,
//       initialState: () => ref.read(userProvider)?.person,
//     )
//       ..addRefreshListener(() => isLoading.state = true)
//       ..addRefreshCallback((final bool success) => isLoading.state = false);
//   },
//   dependencies: <ProviderOrFamily>[userProvider, _loadingProvider],
// );
