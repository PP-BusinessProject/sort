# Sort

## ![Icon](./source/launcher_icons/b2c.png?raw=true 'Icon')

### Build

flutter build apk --release --split-per-abi --split-debug-info --obfuscate

### Update Dependencies

dart pub upgrade --null-safety --precompile

### Generate Assets

flutter pub run "tool/generate_assets.dart" --class-name AssetsCG --output-file "lib\\generated\\assets.g.dart" --exclude "\\fonts\\"

### Generate Localization

flutter pub run "tool/generate_localization.dart" -f keys -S "assets/translations" -O "lib/generated" -o localization.g.dart

### Create Launch Icons

flutter pub run flutter_launcher_icons:main

### Native Splash

flutter pub run flutter_native_splash:create
flutter pub run flutter_native_splash:remove

### Localization

- `resConfigs` in app/gradle defaultOptions

### Deep Links (Android)

- adb shell
- am start -a android.intent.action.VIEW -d "smstretching://stories/6184" ru.smstretching.appstudio
