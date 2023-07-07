import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signup_signin/pages/login.dart';
import 'package:signup_signin/pages/register.dart';
import 'package:signup_signin/pages/welcomeScreen.dart';
// import 'package:your_app/register_screen.dart';
// import 'package:your_app/login_screen.dart';

class WelcomeNewUser extends StatelessWidget {
  final User = FirebaseAuth.instance.currentUser!;
  @override
  void SignUserout() {
    FirebaseAuth.instance.signOut();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: SignUserout,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
          child: Text(
        "LOGGED IN AS: " + User.email!,
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
