import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../providers/location_providers.dart';
import '../../providers/model_providers.dart';
import '../b2c/b2c_containers_filter.dart';
import '../shared/shared_widgets.dart';
import 'container_card.dart';

/// The screen used to show off the list of [ContainerModel].
class ContainersScreen extends HookConsumerWidget {
  /// The screen used to show off the list of [ContainerModel].
  const ContainersScreen({final super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
    final ScrollController scrollController =
        PrimaryScrollController.of(context)!;
    final bool Function() isMounted = useIsMounted();

    final GlobalKey<InnerDrawerState> drawerKey = useMemoized(GlobalKey.new);
    return InnerDrawer(
      key: drawerKey,
      onTapClose: true,
      swipe: false,
      offset: const IDOffset.horizontal(1 / 3),
      rightChild: const B2CContainersFilter(),
      scaffold: CupertinoPageScaffold(
        navigationBar: navigationBar(
          theme,
          previousPageTitle: $.menu.menu,
          onPressed: navigator.maybePop,
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: iconButton(
              theme,
              CupertinoIcons.bars,
              iconSize: 20,
              radius: 14,
              onTap: () => drawerKey.currentState?.open(),
            ),
          ),
        ),
        child: listView(
          alignment: Alignment.topCenter,
          children: <Widget>[
            for (final ContainerModel container
                in ref.watch(containersProvider))
              Consumer(
                builder: (final _, final WidgetRef ref, final Widget? child) {
                  final String? address = ref.watch(
                    addressProvider(
                      LatLng(container.latitude, container.longtitude),
                    ),
                  );
                  return address == null
                      ? child!
                      : ContainerCard(container, address);
                },
                child: const CircularProgressIndicator.adaptive(),
              )
          ],
        ),
      ),
    );
  }
}
