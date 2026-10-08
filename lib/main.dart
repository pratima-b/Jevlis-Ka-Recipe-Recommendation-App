import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/nav/bottom_nav_screen.dart';
import 'widgets/connectivity_wrapper.dart';
import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('Favorite');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jevlis Ka?',
      theme: ThemeData(
        // Keep the original Material 2 appearance during the migration.
        useMaterial3: false,
        fontFamily: 'Satoshi',
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFFFF3F00),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Telma',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF3F00),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
