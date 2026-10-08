# Jevlis Ka - Flutter 3.47.5 / Chrome migration

This version is prepared for a modern Dart 3 / Flutter 3.47.x development workflow with Chrome as the first target.

## Main changes

- Updated Dart SDK constraint to Dart 3.10+ and removed the old dependency lock file.
- Removed the obsolete `firebase_dynamic_links` dependency and code. Firebase Dynamic Links is no longer available.
- Replaced the discontinued `share` package with `share_plus`.
- Replaced the old Git-based `bottom_nav_bar` dependency with Flutter's built-in `BottomNavigationBar`.
- Updated `dio`, `flutter_bloc`, `flutter_html`, `url_launcher`, and related dependencies.
- Updated `headline1` to `displayLarge`.
- Updated `textScaleFactor` to `textScaler`.
- Updated `AppBarTheme.color` to `backgroundColor`.
- Initialized Hive and opened the `Favorite` box before the app starts.
- Updated the stale counter test to a Jevlis Ka smoke test.

## Chrome run

```powershell
flutter clean
flutter pub get
flutter devices
flutter analyze
flutter run -d chrome
```

Android Studio and Visual Studio are not required for the Chrome target.

## Important

The Spoonacular API key is currently in `lib/api/api_key.dart`. For production web deployment, move API access behind a backend/proxy so the key is not exposed in browser code.

The recipe share URL is currently a normal HTTPS URL. Firebase Dynamic Links/deep-link handling is intentionally not included in this Chrome-first migration.
