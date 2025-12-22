import 'package:flutter/material.dart';
import 'package:gadura_land/Screens/FieldExecutive/profile.dart';
import 'package:gadura_land/Screens/FieldExecutive/session.dart';
import 'package:gadura_land/Screens/Regional/regionalhomepage.dart';

import 'package:gadura_land/Screens/homepage.dart';
import 'package:gadura_land/Auth/login.dart';
import 'package:gadura_land/onboarding/onboarding.dart';
import 'package:gadura_land/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garuda Land',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
