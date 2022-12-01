import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../const.dart';
import 'misc_providers.dart';

class _SecureLocalStorage extends LocalStorage {
  _SecureLocalStorage()
      : super(
          initialize: () async {},
          hasAccessToken: () =>
              storage.containsKey(key: supabasePersistSessionKey),
          accessToken: () => storage.read(key: supabasePersistSessionKey),
          removePersistedSession: () =>
              storage.delete(key: supabasePersistSessionKey),
          persistSession: (final String value) =>
              storage.write(key: supabasePersistSessionKey, value: value),
        );

  static const FlutterSecureStorage storage = FlutterSecureStorage();
}

final Future<List<Override>> providerOverrides =
    Future<List<Override>>(() async {
  final Iterable<Object?> $ = await Future.wait<Object?>(<Future<Object?>>[
    PackageInfo.fromPlatform(),
    Future<Box<String>>(() async {
      Hive.init((await getApplicationDocumentsDirectory()).path);
      final Box<String> box = await Hive.openBox<String>('storage');
      // await box.clear();
      return box;
    }),
    Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      // authCallbackUrlHostname: 'login-callback',
      headers: <String, String>{'apikey': supabaseAnonKey},
      localStorage: _SecureLocalStorage(),
    ).then((final Supabase instance) => instance.client.rest.rpc('get_time')),
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    ),
  ]);
  final PackageInfo packageInfo = $.elementAt(0)! as PackageInfo;
  final Box<String> storage = $.elementAt(1)! as Box<String>;
  final DateTime currentTime = DateTime.parse($.elementAt(2)! as String);
  return <Override>[
    packageInfoProvider.overrideWithValue(packageInfo),
    hiveProvider.overrideWithValue(storage),
    serverTimeProvider.overrideWithValue(ServerTimeNotifier(currentTime))
  ];
});
