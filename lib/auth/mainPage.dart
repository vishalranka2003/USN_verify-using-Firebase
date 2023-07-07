import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signup_signin/pages/welcomeScreen.dart';
import 'package:signup_signin/pages/login.dart';
import 'package:signup_signin/auth/mainPage.dart';
import 'package:signup_signin/auth/authpage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WelcomeNewUser();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}

class usnfound extends StatefulWidget {
  const usnfound({super.key});

  @override
  State<usnfound> createState() => _usnfoundState();
}

class _usnfoundState extends State<usnfound> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WelcomeNewUser();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
