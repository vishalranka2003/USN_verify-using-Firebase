import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:signup_signin/pages/student.dart';
import 'pages/login.dart';
import 'package:signup_signin/auth/mainPage.dart';
import 'pages/login.dart';
import 'package:signup_signin/pages/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Logout Implementaton',
      home: finduser(),
    );
  }
}
