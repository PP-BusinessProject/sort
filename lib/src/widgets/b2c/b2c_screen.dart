import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../flavors.dart';
import '../../generated/models.g.dart';
import '../../providers/flutter_providers.dart';
import '../../providers/model_providers.dart';
import '../auth/authorization_screen.dart';
import '../auth/profile_screen.dart';
import '../error_screen.dart';
import '../splash_screen.dart';
import 'b2c_map.dart';

/// The main [SortFlavor.b2c] screen.
class B2CScreen extends HookConsumerWidget {
  /// The main [SortFlavor.b2c] screen.
  const B2CScreen({final super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    const Widget loadingWidget =
        Center(child: CircularProgressIndicator.adaptive());
    Widget? content = ref.watch(
      signedInProvider.select(
        (final _) => _.when<Widget?>(
          error: ErrorScreen.new,
          loading: () => loadingWidget,
          data: (final User? user) =>
              user == null ? const AuthorizationScreen() : null,
        ),
      ),
    );
    content ??= ref.watch(
      userProvider.select(
        (final _) => _.when(
          error: ErrorScreen.new,
          loading: () => loadingWidget,
          data: (final UserModel? user) =>
              user == null ? const ProfileScreen() : const B2CMap(),
        ),
      ),
    );
    SplashScreen.showSplash?.add(identical(content, loadingWidget));
    return content!;
  }
}
