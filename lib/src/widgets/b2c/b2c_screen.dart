import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../generated/models.g.dart';
import '../../providers/auth/supabase_session_provider.dart';
import '../../providers/database/model_providers.dart';
import '../auth/authorization_screen.dart';
import '../auth/profile_screen.dart';
import '../error_screen.dart';
import '../splash_screen.dart';
import 'b2c_map.dart';

/// The main screen.
class B2CScreen extends HookConsumerWidget {
  /// The main screen.
  const B2CScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    const Widget loadingWidget =
        Center(child: CircularProgressIndicator.adaptive());
    Widget? content = ref.watch(
      sessionProvider.select(
        (final _) => _.when<Widget?>(
          error: ErrorScreen.new,
          loading: () => loadingWidget,
          data: (final Session? session) =>
              session == null ? const AuthorizationScreen() : null,
        ),
      ),
    );
    content ??= ref.watch(
      personProvider.select(
        (final _) => _.when(
          error: ErrorScreen.new,
          loading: () => loadingWidget,
          data: (final PersonModel? user) =>
              user == null ? const ProfileScreen() : const B2CMap(),
        ),
      ),
    );
    SplashScreen.showSplash?.add(identical(content, loadingWidget));
    return content!;
  }
}
