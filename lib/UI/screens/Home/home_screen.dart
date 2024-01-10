import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pietyservices/UI/screens/Home/storeType.dart';
import 'package:flutter/cupertino.dart';

Future<Position> _getGeoLocationPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    // await Geolocator.requestPermission();
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error');
    });
    return await Geolocator.getCurrentPosition();
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<void> GetAddressFromLatLong(Position position) async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  print(placemarks);
  Placemark place = placemarks[0];
  Address =
      '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
}

String location = '';
String Address = 'null';

Future<void> get() async {
  Position position = await _getGeoLocationPosition();
  location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
  print(location);
  GetAddressFromLatLong(position);
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DocumentReference doc =
      FirebaseFirestore.instance.collection('admin_panel').doc('data');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 134, 4),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              const Text(
                'Hello',
                style: TextStyle(color: Colors.white, fontSize: 31),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Your Location   ',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 2.0,
              right: 0.0,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30, child: Text(Address)),
                  Row(
                    children: [
                      /* const Icon(
                        Icons.location_pin,
                        color: Colors.white,
                        // size: 35,
                      ),*/
                      /*   SizedBox(
                        height: 40,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return Card(
                                    margin: const EdgeInsets.all(8.0),
                                    elevation: 5,
                                    child: Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom +
                                            10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Change Delivery Location",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0),
                                          ),
                                          Text(
                                            "Select a delivery location to see EcoMates",
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down,
                          ),
                          splashRadius: 20.0,
                        ),
                      ),*/
                    ],
                  ),
                ]),
          ),
        ]),
        toolbarHeight: 150,
      ),
      body: SingleChildScrollView(child: storeType(documentReference: doc)),
    );
  }
}

final db = FirebaseFirestore.instance;
