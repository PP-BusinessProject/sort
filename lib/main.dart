import 'package:catcher/catcher.dart';

import 'src/utils/logger.dart';
import 'src/widgets/error_screen.dart';
import 'src/widgets/splash_screen.dart';

void main() => Catcher(
      ensureInitialized: true,
      debugConfig: CatcherOptions(
        ErrorPageReportMode(),
        <ReportHandler>[ConsoleHandler()],
        logger: ChangedCatcherLogger(),
      ),
      releaseConfig: CatcherOptions(
        ErrorPageReportMode(),
        <ReportHandler>[ConsoleHandler()],
        logger: ChangedCatcherLogger(),
      ),
      rootWidget: const SplashScreen(),
    );
