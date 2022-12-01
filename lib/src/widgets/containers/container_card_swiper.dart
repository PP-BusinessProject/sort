import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../generated/models.g.dart';
import '../../providers/location_providers.dart';
import '../../providers/database/model_providers.dart';
import '../b2c/b2c_map.dart';
import '../containers/container_card.dart';

/// The swiper of [ContainerModel] on [B2CMap].
class ContainerCardSwiper extends HookConsumerWidget {
  /// The swiper of [ContainerModel] on [B2CMap].
  const ContainerCardSwiper(this.container, {super.key});

  /// The first model of this [Swiper].
  final ContainerModel container;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final int itemCount = ref.watch(
      containersProvider.select((final _) => _.valueOrNull?.length ?? 1),
    );
    final ObjectRef<ContainerModel> prevContainer = useRef(container);
    useValueChanged(
      container,
      (final _, final __) => prevContainer.value = container,
    );

    ContainerModel containerFromIndex(final int index) {
      final Iterable<ContainerModel> containers =
          (ref.read(containersProvider).valueOrNull)
                  ?.where((final _) => _.id != null) ??
              const Iterable<ContainerModel>.empty();
      final List<int> containerIds =
          containers.map((final _) => _.id!).toList(growable: false)..sort();
      if (container.id == null ||
          !containerIds.contains(prevContainer.value.id)) {
        return prevContainer.value;
      }
      int newIndex = containerIds.indexOf(container.id!) + index;
      while (newIndex >= containerIds.length) {
        newIndex -= containerIds.length;
      }
      while (newIndex < 0) {
        newIndex += containerIds.length;
      }
      return containers.elementAt(newIndex);
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
          WidgetsBinding.instance.addPostFrameCallback((final _) {
            prevContainer.value = container;
          });
        },
        itemBuilder: (final BuildContext context, final int index) {
          final ContainerModel container = containerFromIndex(index);
          return Consumer(
            builder: (final _, final WidgetRef ref, final Widget? child) {
              final String? address = container.address == null
                  ? ref.watch(
                      addressProvider(
                        LatLng(container.latitude, container.longtitude),
                      ),
                    )
                  : null;
              return container.address == null && address == null
                  ? child!
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ContainerCard(
                        container,
                        address: address,
                        onMap: true,
                      ),
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
