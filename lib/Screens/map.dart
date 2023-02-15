import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/ReusedCode/reusable_widget.dart';
// import 'package:flutter_project/home.dart';
import 'package:flutter_project/Screens/forgetpassword.dart';
import 'package:flutter_project/Screens/opencamera.dart';
import 'package:flutter_project/Screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/testpage.dart';
import 'package:flutter_project/Screens/map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? _currentAddress;
  Position? _currentPosition;
  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
  String entries = '';

  String name = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    await rooms.get();
  }

  @override
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "LocationPage",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/map.jpg'),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
              ),
            ),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                    child: Column(children: <Widget>[
                      TextField(
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                          FirebaseFirestore.instance
                              .collection('rooms')
                              .get()
                              .then((QuerySnapshot querySnapshot) {
                            querySnapshot.docs.forEach((doc) {
                              print(doc["address"]);
                              setState(() {
                                entries = doc['address'];
                              });
                            });
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15),
                          hintText: "Where You want to go",
                          suffixIcon: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CameraScreen()));
                            },
                            icon: const Icon(Icons.search),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      name != ''
                          ? SizedBox(
                              height: 300,
                              child: ListTile(
                                title: Text(entries),
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'LAT: ${_currentPosition?.latitude ?? ""}'),
                                  Text(
                                      'LNG: ${_currentPosition?.longitude ?? ""}'),
                                  const SizedBox(height: 32),
                                  ElevatedButton(
                                    onPressed: _getCurrentPosition,
                                    child: const Text("Get Current Location"),
                                  )
                                ],
                              ),
                            ),
                    ])))));
  }
}
