import 'package:catcher/catcher.dart';

import 'utils/crashlytics_handler.dart';
import 'utils/logger.dart';
import 'widgets/error_screen.dart';

/// The [Catcher] debug config.
CatcherOptions debugConfig({final bool initialised = false}) => CatcherOptions(
      initialised ? ErrorPageReportMode() : SilentReportMode(),
      <ReportHandler>[ConsoleHandler()],
      logger: ChangedCatcherLogger(),
    );

/// The [Catcher] release config.
CatcherOptions releaseConfig({final bool initialised = false}) =>
    CatcherOptions(
      initialised ? ErrorPageReportMode() : SilentReportMode(),
      <ReportHandler>[CrashlyticsHandler()],
      logger: ChangedCatcherLogger(),
    );
