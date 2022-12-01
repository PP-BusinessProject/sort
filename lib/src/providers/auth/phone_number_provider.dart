import 'package:phone_form_field/phone_form_field.dart';
import 'package:riverpod/riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import 'supabase_session_provider.dart';

/// The provider of the [PhoneNumber] of the user signed in from [Supabase].
final Provider<PhoneNumber?> $phoneNumberProvider = Provider<PhoneNumber?>(
  (final ProviderRef<PhoneNumber?> ref) {
    try {
      final String phoneNumber = ref.watch(
        sessionProvider.select(
          (final AsyncValue<Session?> session) =>
              session.valueOrNull?.user?.phone ?? '',
        ),
      );
      return phoneNumber.isEmpty ? null : PhoneNumber.parse(phoneNumber);
    } on Exception catch (_) {
      Supabase.instance.log('Exception occured while parsing phoneNumber.');
      return null;
    }
  },
  dependencies: <ProviderOrFamily>[sessionProvider],
);

/// The provider of the phone number of the user from signed in [Supabase].
final Provider<int?> phoneNumberProvider = Provider<int?>(
  (final ProviderRef<int?> ref) => ref.watch(
    $phoneNumberProvider.select(
      (final PhoneNumber? phoneNumber) => int.tryParse(
        phoneNumber?.international.replaceAll(RegExp(r'\D'), '') ?? '',
      ),
    ),
  ),
  dependencies: <ProviderOrFamily>[$phoneNumberProvider],
);
