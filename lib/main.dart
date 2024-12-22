import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_app/firebase_options.dart';
import 'package:stacked_app/screens/login/login.dart/login.dart';
import 'package:stacked_app/screens/login/login_view.dart';
import 'package:stacked_app/screens/sign/sign_view.dart';
import 'package:stacked_app/screens/splash_screen/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with options for the current platform
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),  // Use LoginDatabase as the home screen
    );
  }
}
