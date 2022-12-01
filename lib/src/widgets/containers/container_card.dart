import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:page_transition/page_transition.dart';

import '../../extensions.dart';
import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../styles.dart';
import '../b2c/b2c_map.dart';
import '../shared/shared_widgets.dart';
import 'container_report_screen.dart';

/// The card used to display info about a [ContainerModel] on map.
class ContainerCard extends StatelessWidget {
  /// The card used to display info about a [ContainerModel] on map.
  const ContainerCard(
    this.container, {
    this.address,
    this.onMap = false,
    this.disabled = false,
    super.key,
  });

  /// The container to display in this card.
  final ContainerModel container;

  /// The address of the [container] to display in this card.
  final String? address;

  /// If this card is shown on map.
  final bool onMap;

  /// If actions on this card should be disabled.
  final bool disabled;

  /// The height of this widget when [onMap] is `false`.
  static const double height = 100;

  /// The height of this widget when [onMap] is `true`.
  static const double onMapHeight = 104;

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18NLocale currentLocale = I18NLocalizations.of(context)!.current;
    final I18N $ = currentLocale();
    return SizedBox(
      height: onMap ? onMapHeight : height,
      child: Card(
        shape: onMap
            ? outlinedBorder(theme, radius: 10)
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      /// Image
                      Expanded(
                        child: image(
                          container.images.isNotEmpty
                              ? container.images.first.url
                              : null,
                        ),
                      ),

                      /// Title and Address
                      Expanded(
                        flex: disabled ? 3 : 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ).copyWith(bottom: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /// Title
                              Flexible(
                                child: marqueeText(
                                  $.containers.name(container.id),
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              /// Address
                              if (container.address != null ||
                                  address != null) ...<Widget>[
                                const SizedBox(height: 2),
                                Flexible(
                                  child: Text(
                                    address ??
                                        <Object>[
                                          container.address!
                                              .street(currentLocale.locale),
                                          container.address!.building
                                        ].join(', '),
                                    style: theme.textTheme.bodyMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ),

                      /// Action Buttons
                      if (!disabled)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              /// Icon Buttons
                              Expanded(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    /// Show On Map
                                    Expanded(
                                      child: Tooltip(
                                        message: $.containers.showOnMap,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor: const Color(
                                              0xff6490DC,
                                            ),
                                          ),
                                          onPressed: () {
                                            navigator.popUntil(
                                              ModalRoute.withName('/'),
                                            );
                                            B2CMap.navigation?.add(
                                              LatLng(
                                                container.latitude,
                                                container.longtitude,
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            CupertinoIcons.map_fill,
                                            color: theme.brightness ==
                                                    Brightness.light
                                                ? theme.colorScheme.surface
                                                : theme.colorScheme.onSurface,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// Report
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Tooltip(
                                        message: $.containers.report.report,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor:
                                                const Color(0xffDC6B64),
                                          ),
                                          onPressed: () async =>
                                              navigator.push<void>(
                                            PageTransition<void>(
                                              type: PageTransitionType.fade,
                                              child: ContainerReportScreen(
                                                container,
                                                address: address,
                                              ),
                                            ),
                                          ),
                                          child: Icon(
                                            CupertinoIcons
                                                .exclamationmark_triangle_fill,
                                            color: theme.brightness ==
                                                    Brightness.light
                                                ? theme.colorScheme.surface
                                                : theme.colorScheme.onSurface,
                                            size: 18,
                                          ),
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
        ..add(DiagnosticsProperty<bool>('onMap', onMap))
        ..add(DiagnosticsProperty<bool>('disabled', disabled)),
    );
  }
}
