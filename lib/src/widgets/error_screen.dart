import 'package:catcher/catcher.dart';
import 'package:catcher/model/platform_type.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../generated/i18n.g.dart';
import 'shared/shared_widgets.dart';

/// The custom page report mode.
class ErrorPageReportMode extends ReportMode {
  @override
  Future<void> requestAction(
    final Report report,
    final BuildContext? context,
  ) async {
    if (context != null) {
      final ProviderContainer container =
          ProviderScope.containerOf(context, listen: false);
      container.read(ErrorScreen.errorProvider.notifier).state = report;
    }
    super.onActionConfirmed(report);
  }

  @override
  bool isContextRequired() => true;

  @override
  List<PlatformType> getSupportedPlatforms() => PlatformType.values;
}

/// The screen used to show an [error].
class ErrorScreen extends HookConsumerWidget {
  /// The screen used to show an [error].
  const ErrorScreen(
    final this.error,
    final this.stackTrace, {
    final super.key,
  });

  /// The error to show on this screen.
  final Object error;

  /// The stackTrace of the [error].
  final StackTrace? stackTrace;

  /// The provider of the error inside the app.
  static final StateProvider<Report?> errorProvider = StateProvider<Report?>(
    (final StateProviderRef<Report?> ref) => null,
  );

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
    return CupertinoPageScaffold(
      child: Column(
        children: <Widget>[
          /// Error Description
          Expanded(
            child: listView(
              mediaQuery,
              children: <Widget>[
                /// Title
                Flexible(
                  child: Text(
                    $.error.error,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 24),

                /// Description
                Flexible(
                  child: Text(
                    $.error.description,
                    style: theme.textTheme.titleMedium,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 24),

                /// Update App
                Flexible(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(0),
                    ),
                    onPressed: () {},
                    child: Text(
                      $.error.confirm,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                )
              ],
            ),
          ),

          /// View Logs
          TextButton(
            onPressed: () => navigator.push<void>(
              PageTransition<void>(
                type: PageTransitionType.fade,
                child: ErrorLogsScreen(error, stackTrace),
              ),
            ),
            child: Text(
              $.error.viewLogs,
              style: theme.textTheme.titleLarge?.copyWith(
                decoration: TextDecoration.underline,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(DiagnosticsProperty<Object>('error', error))
        ..add(DiagnosticsProperty<StackTrace?>('stackTrace', stackTrace)),
    );
  }
}

/// The screen used to show an [error].
class ErrorLogsScreen extends ErrorScreen {
  /// The screen used to show an [error].
  const ErrorLogsScreen(
    final super.error,
    final super.stackTrace, {
    final super.key,
  });

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();
    return CupertinoPageScaffold(
      navigationBar: navigationBar(
        theme,
        previousPageTitle: $.misc.prevPage,
        trailing: Padding(
          padding: const EdgeInsetsDirectional.only(end: 12),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => FlutterClipboard.copy(error.toString()),
            child: Text(
              $.error.copyLogs,
              style: cupertinoTheme.textTheme.navActionTextStyle.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      child: listView(
        mediaQuery,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            error.runtimeType.toString(),
            style: theme.textTheme.headlineLarge,
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              error.toString(),
              style: theme.textTheme.titleMedium,
              maxLines: 999,
              textAlign: TextAlign.start,
            ),
          ),
          if (error is! DioError && stackTrace != null) ...<Widget>[
            const SizedBox(height: 16),
            Text(stackTrace.toString(), maxLines: 999),
          ],
        ],
      ),
    );
  }
}
