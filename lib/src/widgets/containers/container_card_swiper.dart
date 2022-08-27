import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../generated/models.g.dart';
import '../../providers/location_providers.dart';
import '../../providers/model_providers.dart';
import '../b2c/b2c_map.dart';
import '../containers/container_card.dart';

/// The swiper of [ContainerModel] on [B2CMap].
class ContainerCardSwiper extends HookConsumerWidget {
  /// The swiper of [ContainerModel] on [B2CMap].
  const ContainerCardSwiper(final this.container, {final super.key});

  /// The first model of this [Swiper].
  final ContainerModel container;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final WidgetsBinding widgetsBinding = WidgetsBinding.instance;
    final int itemCount = ref.watch(
      containersProvider
          .select((final _) => _.valueOrNull?.length.clamp(1, 3) ?? 1),
    );
    final ObjectRef<ContainerModel> prevContainer = useRef(container);
    useValueChanged(
      container,
      (final _, final __) => prevContainer.value = container,
    );

    ContainerModel containerFromIndex(final int index) {
      final Iterable<ContainerModel> containers;
      if (index == 0 ||
          !(containers = ref.read(containersProvider).valueOrNull ??
                  <ContainerModel>[])
              .contains(prevContainer.value)) {
        return container;
      } else {
        int newIndex = containers.toList().indexOf(prevContainer.value);
        newIndex = newIndex + (index >= 1 ? index : -1);
        if (newIndex >= containers.length) {
          newIndex = 0;
        } else if (newIndex < 0) {
          newIndex = containers.length - 1;
        }
        return containers.elementAt(newIndex);
      }
    }

    return SizedBox(
      height: ContainerCard.onMapHeight,
      child: Swiper(
        key: ValueKey<ContainerModel>(container),
        loop: itemCount > 1,
        itemCount: itemCount,
        onIndexChanged: (final int index) {
          final ContainerModel container = containerFromIndex(index);
          B2CMap.navigation
              ?.add(LatLng(container.latitude, container.longtitude));
          widgetsBinding.addPostFrameCallback((final _) {
            prevContainer.value = container;
          });
        },
        itemBuilder: (final BuildContext context, final int index) {
          final ContainerModel container = containerFromIndex(index);
          return Consumer(
            builder: (final _, final WidgetRef ref, final Widget? child) {
              final String? address = ref.watch(
                addressProvider(
                  LatLng(container.latitude, container.longtitude),
                ),
              );
              return address == null
                  ? child!
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ContainerCard(container, address, onMap: true),
                    );
            },
            child: const CircularProgressIndicator.adaptive(),
          );
        },
      ),
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
