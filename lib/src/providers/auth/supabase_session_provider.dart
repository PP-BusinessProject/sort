import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:riverpod/riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../misc_providers.dart';

/// The provider of the current user signed in from [Supabase].
final StreamProvider<Session?> sessionProvider = StreamProvider<Session?>(
  (final StreamProviderRef<Session?> ref) async* {
    final StreamController<Session?> sessionController =
        StreamController<Session?>();
    Supabase.instance.client.auth.onAuthStateChange(
      (final AuthChangeEvent event, final Session? session) async {
        sessionController.sink.add(session);
        final Box<String> hive = ref.read(hiveProvider);
        if (session == null) {
          await hive.delete('session');
        } else {
          await hive.put(
            'session',
            json.encode(
              <String, Object?>{
                'currentSession': session.toJson(),
                'expiresAt': session.expiresAt,
              },
            ),
          );
        }
      },
    );

    final String? persistedSession = ref.read(hiveProvider).get('session');
    if (persistedSession != null) {
      await Supabase.instance.client.auth.recoverSession(persistedSession);
    } else {
      yield Supabase.instance.client.auth.currentSession;
    }

    try {
      yield* sessionController.stream;
    } finally {
      await sessionController.close();
    }
  },
  dependencies: <ProviderOrFamily>[hiveProvider],
);
