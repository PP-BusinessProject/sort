import 'package:catcher/catcher.dart';

import 'src/config.dart';
import 'src/widgets/splash_screen.dart';

void main() => Catcher(
      ensureInitialized: true,
      debugConfig: debugConfig(),
      releaseConfig: releaseConfig(),
      rootWidget: const SplashScreen(),
    );
