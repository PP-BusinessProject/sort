import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ndialog/ndialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../extensions.dart';
import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../providers/database/model_providers.dart';
import '../../styles.dart';
import '../shared/shared_widgets.dart';
import 'container_card.dart';

/// The screen used to submit a [ContainerReportModel].
class ContainerReportScreen extends HookConsumerWidget {
  /// The screen used to submit a [ContainerReportModel].
  const ContainerReportScreen(
    this.container, {
    this.address,
    super.key,
  });

  /// The container to display in this screen.
  final ContainerModel container;

  /// The address of the [container] to display in this screen.
  final String? address;

  static final StateProvider<int?> _reportTypeProvider = StateProvider<int?>(
    (final StateProviderRef<int?> ref) => ref.watch(
      containerReportTypesProvider.select(
        (final _) {
          final Iterable<ContainerReportTypeModel>? reportTypes = _.valueOrNull;
          return reportTypes == null || reportTypes.isEmpty
              ? null
              : reportTypes.first.id;
        },
      ),
    ),
  );

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context);
    final bool isInformationRequired =
        ref.watch(_reportTypeProvider.select((final _) => _ == null));
    final bool Function() isMounted = useIsMounted();
    final ValueNotifier<String> information = useState('');

    Future<void> report() async {
      try {
        await (Supabase.instance.client.rest.from('container_reports')).insert(
          ContainerReportModel(
            containerId: container.id,
            typeId: ref.read(_reportTypeProvider),
            information: information.value,
          ).toMap(),
        );
        if (isMounted()) {
          await ref.refresh(personProvider.future);
          // ignore: use_build_context_synchronously
          await NDialog(
            title: Text($.alert.success.title),
            content: Text($.alert.success.body),
            actions: <Widget>[
              TextButton(
                onPressed: navigator.maybePop,
                child: Text($.alert.success.approve),
              )
            ],
          ).show<void>(context);
        }
        await navigator.maybePop();
      } on Exception catch (_) {
        try {
          if (isMounted()) {
            await NDialog(
              title: Text($.alert.error.title),
              content: Text($.alert.error.body),
              actions: <Widget>[
                TextButton(
                  onPressed: navigator.maybePop,
                  child: Text($.alert.error.approve),
                )
              ],
            ).show<void>(context);
          }
        } finally {
          rethrow;
        }
      }
    }

    return CupertinoPageScaffold(
      navigationBar: navigationBar(
        theme,
        previousPageTitle: $.misc.prevPage,
        trailing: Padding(
          padding: const EdgeInsetsDirectional.only(end: 12),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: isInformationRequired && information.value.isEmpty
                ? null
                : report,
            child: Text(
              $.containers.report.send,
              style: cupertinoTheme.textTheme.navActionTextStyle.copyWith(
                color: isInformationRequired && information.value.isEmpty
                    ? theme.disabledColor
                    : null,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      child: listView(
        mediaQuery,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Flexible(
            child: ContainerCard(container, address: address, disabled: true),
          ),
          const SizedBox(height: 80),
          const Flexible(child: _ContainerReportTypePicker()),
          const SizedBox(height: 80),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    $.containers.report.information,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4),
                  child: CupertinoTextField(
                    minLines: 5,
                    maxLines: 8,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      border: Border.all(width: 1 / 2),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[boxShadow(theme)],
                    ),
                    style: theme.textTheme.bodyMedium,
                    placeholder: isInformationRequired
                        ? $.containers.report.informationRequired
                        : $.containers.report.informationOptional,
                    placeholderStyle: theme.textTheme.bodyMedium,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(1023),
                    ],
                    onChanged: (final String value) =>
                        information.value = value,
                  ),
                )
              ],
            ),
          )
        ],
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
        ..add(StringProperty('address', address)),
    );
  }
}

class _ContainerReportTypePicker extends HookConsumerWidget {
  const _ContainerReportTypePicker();

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    final I18NLocale currentLocale = I18NLocalizations.of(context)!.current;
    final I18N $ = currentLocale();
    final StateProvider<int?> reportProvider =
        ContainerReportScreen._reportTypeProvider;
    final int? selectedType = ref.watch(reportProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final ContainerReportTypeModel? reportType
            in <ContainerReportTypeModel?>[
          ...ref.watch(
                containerReportTypesProvider.select((final _) => _.valueOrNull),
              ) ??
              <ContainerReportTypeModel?>[],
          null
        ])
          if (reportType == null || reportType.id != null)
            Flexible(
              child: GestureDetector(
                onTap: () =>
                    ref.read(reportProvider.notifier).state = reportType?.id,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Material(
                        child: Radio<int?>(
                          value: reportType?.id,
                          groupValue: selectedType,
                          onChanged: (final int? value) =>
                              ref.read(reportProvider.notifier).state = value,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        reportType?.name(currentLocale.locale) ??
                            $.containers.report.other,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}
