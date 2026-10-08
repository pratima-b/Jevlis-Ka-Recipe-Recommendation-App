# Jevlis-Ka — Flutter 3.47.5 modernization

This version updates the Dart source toward current Flutter/Dart conventions while preserving the existing app architecture and API behavior.

## Applied
- Typed JSON factory parameters and `toJson()` return values in models.
- Removed the unused `dart:convert` import from `nutrients.dart`.
- Added the Flutter foundation import needed by BLoC part files using `@immutable`.
- Migrated legacy `Key? key` / `super(key: key)` constructors to `super.key` where applicable.
- Modernized public `createState()` signatures to return `State<Widget>`.
- Added missing public widget keys.
- Removed the known unused `percent` local.
- Removed the unnecessary Cupertino import reported by analyzer.
- Removed unnecessary `.toList()` calls in spread expressions where safe.
- Added explicit return type for the Home screen header helper.
- Removed the unnecessary `dynamic?` marker.

## Verification
Run from the project root:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter run -d emulator-5554
```

The Android build also requires a Gradle version compatible with the Java runtime selected by Flutter. The project should be verified against the local Android Studio JDK before the first Android build.
