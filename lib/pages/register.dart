import 'package:firebase_auth/firebase_auth.dart';  
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:signup_signin/auth/mainPage.dart';
import 'package:signup_signin/pages/login.dart';
import 'package:signup_signin/pages/register.dart';
import 'package:signup_signin/pages/student.dart';
import 'package:signup_signin/pages/welcomeScreen.dart';
import '../firebase_options.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.openlogin});
  final VoidCallback openlogin;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController lastNamecontroller = TextEditingController();
  TextEditingController usncontroller = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        addUserDetails(
            firstNamecontroller.text.trim(),
            lastNamecontroller.text.trim(),
            usncontroller.text.toUpperCase().trim(),
            emailController.text.trim());
      } catch (e) {
        if (e is FirebaseAuthException) {
          String errorMessage = '';

          // Handle specific Firebase Auth exceptions
          switch (e.code) {
            case 'weak-password':
              errorMessage = 'The password provided is too weak.';
              break;
            case 'email-already-in-use':
              errorMessage = 'The account already exists for that email.';
              break;
            case 'invalid-email':
              errorMessage = 'The email address is not valid.';
              break;
            // Add more cases for other Firebase Auth exceptions if needed

            default:
              errorMessage = 'An error occurred. Please try again later.';
          }

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('An error occurred. Please try again later.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  void navigatetostudentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => finduser(),
      ),
    );
  }

  Future addUserDetails(
      String firstName, String lastName, String usn, String email) async {
    await FirebaseFirestore.instance.collection('students').add({
      'FirstName': firstName,
      'LastName': lastName,
      'USN': usn,
      'Email': email,
    });
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                // logo
                const Icon(
                  Icons.account_circle,
                  size: 20,
                ),
                const SizedBox(height: 20),
                // welcome back, you've been missed!
                Text(
                  'Register Now 🤩',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                // password textfield
                MyTextField(
                  controller: firstNamecontroller,
                  hintText: 'FirstName',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // password textfield
                MyTextField(
                  controller: lastNamecontroller,
                  hintText: 'LastName',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // password textfield
                MyTextField(
                  controller: usncontroller,
                  hintText: 'USN',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // password textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                // sign up button
                MyButton(
                  label: "Sign up",
                  onTap: signUp,
                ),
                const SizedBox(height: 20),
                MyButton(
                  label: "Fetch details",
                  onTap: navigatetostudentPage,
                ),

                const SizedBox(height: 20),

                // or continue with
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text(
                //           'Or continue with',
                //           style: TextStyle(color: Colors.grey[700]),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 25),

                // google + apple sign in buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: const [
                //     // google button
                //     SquareTile(imagePath: 'lib/images/google.png'),

                //     SizedBox(width: 25),

                //     // apple button
                //     SquareTile(imagePath: 'lib/images/apple.png')
                //   ],
                // ),

                const SizedBox(height: 10),

                // not a member? register now
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "I'm a member?",
                //       style: TextStyle(color: Colors.grey[700]),
                //     ),
                //     const SizedBox(width: 4),
                //     GestureDetector(
                //       onTap: widget.openlogin,
                //       child: const Text(
                //         'Login now',
                //         style: TextStyle(
                //           color: Colors.blue,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
