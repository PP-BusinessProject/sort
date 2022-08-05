import 'package:catcher/catcher.dart';
import 'package:catcher/model/platform_type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

/// The provider of the error inside the app.
final StateProvider<Tuple2<ReportMode, Report>?> errorProvider =
    StateProvider<Tuple2<ReportMode, Report>?>(
  (final StateProviderRef<Tuple2<ReportMode, Report>?> ref) => null,
);

/// The custom page report mode.
class ErrorPageReportMode extends ReportMode {
  /// The custom page report mode.
  ErrorPageReportMode();

  @override
  Future<void> requestAction(
    final Report report,
    final BuildContext? context,
  ) async {
    if (context != null) {
      final ProviderContainer container =
          ProviderScope.containerOf(context, listen: false);
      container.read(errorProvider.notifier).state =
          Tuple2<ReportMode, Report>(this, report);
    }
    super.onActionConfirmed(report);
  }

  @override
  bool isContextRequired() => true;

  @override
  List<PlatformType> getSupportedPlatforms() => PlatformType.values;
}
