import 'package:catcher/catcher.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/providers/misc_providers.dart';
import 'src/screens/error_screen.dart';
import 'src/screens/root_screen.dart';
import 'src/utils/crashlytics_handler.dart';
import 'src/utils/logger.dart';

Object? main() => Catcher(
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
      rootWidget: ProviderScope(
        overrides: <Override>[
          widgetsBindingProvider
              .overrideWithValue(WidgetsFlutterBinding.ensureInitialized()),
        ],
        child: const RootScreen(),
      ),
    );
