import 'package:catcher/catcher.dart';
import 'package:flutter/widgets.dart';

import 'src/utils/crashlytics_handler.dart';
import 'src/utils/logger.dart';
import 'src/widgets/error_screen.dart';
import 'src/widgets/splash_screen.dart';

void main() => Catcher(
      navigatorKey: GlobalKey<NavigatorState>(),
      debugConfig: CatcherOptions(
        ErrorPageReportMode(),
        <ReportHandler>[ConsoleHandler()],
        logger: ChangedCatcherLogger(),
      ),
      releaseConfig: CatcherOptions(
        ErrorPageReportMode(),
        <ReportHandler>[CrashlyticsHandler()],
        logger: ChangedCatcherLogger(),
      ),
      rootWidget: const SplashScreen(),
    );
