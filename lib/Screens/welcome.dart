import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Suppot/guest.dart';
import 'package:flutter_project/Screens/login.dart';
import 'package:flutter_project/ReusedCode/reusable_widget.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/using_phone.jpg'),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.white.withOpacity(0.5), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 150, top: 100),
              child: Text(
                'Welcome\n       to\n     DCS',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    left: 50,
                    right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(50),
                      child: Column(
                        children: [
                          firebaseUIButton(context, "SignIn As Member", () {
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            }
                          }),
                          SizedBox(
                            height: 20,
                          ),
                          firebaseUIButton(context, "Login As Guest", () {
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Guest()));
                            }
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
