import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/Screens/login.dart';
import 'package:flutter_project/ReusedCode/reusable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mysignup extends StatefulWidget {
  const Mysignup({Key? key}) : super(key: key);

  @override
  State<Mysignup> createState() => _MysignupState();
}

class _MysignupState extends State<Mysignup> {
  @override
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: const AssetImage('assets/signup.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
          )),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 200,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text);

                  FirebaseFirestore.instance.collection('user').add({
                    "UserName": _userNameTextController.text,
                    "Email": _emailTextController.text
                  }).then((value) {
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
          ))),
    );
  }
}
