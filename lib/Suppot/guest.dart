import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Screens/map.dart';
import 'package:flutter_project/testpage.dart';

class Guest extends StatefulWidget {
  const Guest({Key? key}) : super(key: key);

  @override
  State<Guest> createState() => _GuestState();
}

class _GuestState extends State<Guest> {
  late String _name;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter your name"),
      content: TextField(
        onChanged: (String value) {
          setState(() {
            _name = value;
          });
        },
        decoration: InputDecoration(hintText: "Name"),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Save"),
          onPressed: () {
            FirebaseFirestore.instance.collection('g-user').add({
              "UserName": _name,
            }).then((value) {
              print("guest added");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MapPage()));
            }).onError((error, stackTrace) {
              print("Error ${error.toString()}");
            });
          },
        ),
      ],
    );
    child:
    Text("Show Dialog");
  }
}
