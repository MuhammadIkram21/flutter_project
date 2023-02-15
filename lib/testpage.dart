import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Screens/welcome.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed Out");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Welcome()));
            });
          },
        ),
      ),
    );
  }
}
