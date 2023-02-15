import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Screens/forgetpassword.dart';
import 'package:flutter_project/Screens/login.dart';
import 'package:flutter_project/Screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project/Suppot/guest.dart';
import 'package:flutter_project/Screens/welcome.dart';
import 'Suppot/firebase_options.dart';
import 'package:flutter_project/Screens/map.dart';
import 'package:flutter_project/Screens/opencamera.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'welcome',
    routes: {
      'welcome': (context) => const Welcome(),
      'login': (context) => const Login(),
      'signup': (context) => const Mysignup(),
      'forgetpassword': (context) => const Forgetpassword(),
      'guest': (context) => const Guest(),
      'map': (context) => const MapPage(),
      'opencamera': (context) => CameraScreen(),
    },
  ));
}
