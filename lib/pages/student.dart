import 'dart:math';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../components/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import 'package:flutter/material.dart';
import '../auth/mainPage.dart';

class finduser extends StatefulWidget {
  const finduser({super.key});

  @override
  State<finduser> createState() => _finduserState();
}

// ignore: camel_case_types
class _finduserState extends State<finduser> {
  Future<dynamic> fetchStudentByUSN(String usn, BuildContext context) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('USN', isEqualTo: usn.toUpperCase())
        .get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    if (documents.isNotEmpty) {
      for (var document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String firstName = data['FirstName'];
        String lastName = data['LastName'];
        String email = data['Email'];
        // ignore: use_build_context_synchronously
        navigateToStudentDetailsPage(context, firstName, lastName, email);
      }
    } else {
      // ignore: use_build_context_synchronously
      showNoStudentFoundDialog(context);
    }
  }

  void navigateToStudentDetailsPage(
      BuildContext context, String firstName, String lastName, String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailsPage(
          firstName: firstName,
          lastName: lastName,
          email: email,
        ),
      ),
    );
  }

  void showNoStudentFoundDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('No student found with the provided USN'),
        );
      },
    );
  }

  // void dispose() {
  //   usncontroller.dispose();
  // }

  @override
  TextEditingController usncontroller = TextEditingController();

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
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.account_circle,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Enter the USN to search for the student',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: usncontroller,
                  hintText: 'Enter USN here',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    fetchStudentByUSN(usncontroller.text.trim(), context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  child: Text("Fetch Details"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  child: Text("Register new student"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudentDetailsPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  StudentDetailsPage(
      {required this.firstName, required this.lastName, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('First Name: $firstName'),
            Text('Last Name: $lastName'),
            Text('Email: $email'),
          ],
        ),
      ),
    );
  }
}
