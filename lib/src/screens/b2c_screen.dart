import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../generated/models.g.dart';
import '../providers/flutter_providers.dart';
import '../providers/model_providers.dart';
import '../utils/logger.dart';
import 'authorization_screen.dart';
import 'registration_screen.dart';

class SortB2C extends HookConsumerWidget {
  const SortB2C({final super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    AsyncValue<Object?>? value;
    if ((value = ref.watch(signedInProvider)) is AsyncData<User?> &&
        value!.valueOrNull == null) {
      return const AuthorizationScreen();
    } else if ((value = ref.watch(userProvider)) is AsyncData<UserModel?> &&
        value!.valueOrNull == null) {
      return const RegistrationScreen();
    } else if (value is! AsyncData<Object?>) {
      if (value is AsyncError<Object?>) {
        logger.e('Exception occured.', value.error, value.stackTrace);
      }
      return const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      );
    } else {
      return const RegistrationScreen();
    }
  }
}
