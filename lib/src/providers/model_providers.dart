import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_converters_lite/json_converters_lite.dart';

import '../api.dart';
import '../generated/models.g.dart';
import '../notifiers/content_notifier.dart';
import '../utils/custom_json_converters.dart';
import 'flutter_providers.dart';
import 'misc_providers.dart';

/// An alias to the [StateNotifierProvider] for a [ContentNotifier].
typedef ContentProvider<T extends Object?>
    = StateNotifierProvider<ContentNotifier<T>, T>;

/// An alias to the [StateNotifierProviderRef] for a [ContentNotifier].
typedef ContentProviderRef<T extends Object?>
    = StateNotifierProviderRef<ContentNotifier<T>, T>;

/// An alias to the [StateNotifierProvider] for a [ContentIterableNotifier].
typedef ContentIterableProvider<T extends Object?>
    = StateNotifierProvider<ContentIterableNotifier<T>, Iterable<T>>;

/// An alias to the [StateNotifierProviderRef] for a [ContentIterableNotifier].
typedef ContentIterableProviderRef<T extends Object?>
    = StateNotifierProviderRef<ContentIterableNotifier<T>, Iterable<T>>;

final ContentIterableProvider<ContainerModel> containersProvider =
    ContentIterableProvider<ContainerModel>(
  (final ContentIterableProviderRef<ContainerModel> ref) =>
      ContentIterableNotifier<ContainerModel>(
    ref.watch(hiveProvider),
    key: 'containers',
    converter: const StringConverter(IterableConverter(containerConverter)),
    initialValue: <ContainerModel>[],
    refreshState: (final _) => ref.read(sortApiProvider).get(
          '/containers',
          converter: const IterableConverter(containerConverter),
          cast: (final Object? value) =>
              (value! as Iterable<Object?>).cast<Map<String, Object?>>(),
        ),
  ),
  dependencies: <ProviderOrFamily>[hiveProvider, sortApiProvider],
);

/// The provider of the current signed in [UserModel] from [SortAPI].
final StreamProvider<UserModel?> userProvider = StreamProvider<UserModel?>(
  (final StreamProviderRef<UserModel?> ref) {
    final SortAPI sortApi = ref.watch(sortApiProvider);
    Stream<UserModel?> streamWithInitial(final int phoneNumber) async* {
      final Iterable<UserModel> response = await sortApi.get(
        '/users',
        converter: const IterableConverter(userConverter),
        cast: (final Object? value) =>
            (value! as Iterable<Object?>).cast<Map<String, Object?>>(),
        parameters: <String, Object?>{
          'phone_number': phoneNumber,
          'field': <String>['person'],
        },
      );
      if (response.isEmpty) {
        yield null;
      } else {
        for (final UserModel item in response) {
          yield item;
        }
      }
      yield* sortApi
          .getStream(
            '/users',
            converter: userConverter,
            parameters: <String, Object?>{
              'phone_number': phoneNumber,
              'field': <String>['person'],
            },
            suppress: true,
          )
          .where(
            (final StreamEvent<UserModel, Object?> event) =>
                event.type != StreamEventType.ping,
          )
          .map<UserModel?>(
            (final StreamEvent<UserModel, Object?> event) =>
                event.type == StreamEventType.delete || event.value.isEmpty
                    ? null
                    : event.value.single,
          );
    }

    final int? phoneNumber = ref.watch<int?>($phoneNumberProvider);
    return phoneNumber == null
        ? const Stream<UserModel>.empty()
        : streamWithInitial(phoneNumber);
  },
  dependencies: <ProviderOrFamily>[sortApiProvider, $phoneNumberProvider],
);
