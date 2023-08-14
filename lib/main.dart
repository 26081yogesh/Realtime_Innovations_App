import 'package:flutter/material.dart';
import 'package:realtime_innovations_assignment_app/homepage.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // sqfliteFfiInit();

  // databaseFactory = databaseFactoryFfi;
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Text(
        "RealTime Innovations",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      nextScreen: const HomePage(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
