import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/homepage.dart';
import 'package:gadura_land/Auth/login.dart';
import 'package:gadura_land/onboarding/onboarding.dart';
import 'package:gadura_land/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gadura Land',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
