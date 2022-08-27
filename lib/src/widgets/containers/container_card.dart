import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../flavors.dart';
import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../styles.dart';
import '../b2c/b2c_map.dart';
import '../shared/shared_widgets.dart';

/// The card used to display info about a [ContainerModel] on map.
class ContainerCard extends StatelessWidget {
  /// The card used to display info about a [ContainerModel] on map.
  const ContainerCard(
    final this.container,
    final this.address, {
    final this.onMap = false,
    final super.key,
  });

  /// The container to display in this card.
  final ContainerModel container;

  /// The address of the [container] to display in this card.
  final String address;

  /// If this card is shown on map.
  final bool onMap;

  /// The height of this widget when [onMap] is `false`.
  static const double height = 100;

  /// The height of this widget when [onMap] is `true`.
  static const double onMapHeight = 104;

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
    return SizedBox(
      height: onMap ? onMapHeight : height,
      child: Card(
        shape: outlinedBorder(theme, radius: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /// Grabbing
              if (onMap) divider(width: 80),

              /// Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      /// Image
                      Expanded(
                        child: image(
                          container.images.isNotEmpty
                              ? container.images.first.image?.url
                              : null,
                        ),
                      ),

                      /// Title and Address
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              /// Title
                              Text(
                                $.containers.name(container.id),
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              /// Address
                              const SizedBox(height: 4),
                              Text(
                                address,
                                style: theme.textTheme.bodyMedium,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// Action Buttons
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            /// Icon Buttons
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  /// Show On Map
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        primary: const Color(0xff6490DC),
                                      ),
                                      onPressed: () {
                                        navigator
                                            .popUntil(SortFlavor.b2c.withName);
                                        B2CMap.navigation?.add(
                                          LatLng(
                                            container.latitude,
                                            container.longtitude,
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        CupertinoIcons.map_fill,
                                        color:
                                            theme.brightness == Brightness.light
                                                ? theme.colorScheme.surface
                                                : theme.colorScheme.onSurface,
                                        size: 18,
                                      ),
                                    ),
                                  ),

                                  /// Report
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        primary: const Color(0xffDC6B64),
                                      ),
                                      onPressed: () {},
                                      child: Icon(
                                        CupertinoIcons
                                            .exclamationmark_triangle_fill,
                                        color:
                                            theme.brightness == Brightness.light
                                                ? theme.colorScheme.surface
                                                : theme.colorScheme.onSurface,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// Proceed to Open
                            const SizedBox(height: 12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {},
                                child: Text(
                                  $.containers.open,
                                  style: theme.textTheme.titleSmall,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(
          DiagnosticsProperty<ContainerModel>('container', container),
        )
        ..add(StringProperty('address', address))
        ..add(DiagnosticsProperty<bool>('onMap', onMap)),
    );
  }
}
