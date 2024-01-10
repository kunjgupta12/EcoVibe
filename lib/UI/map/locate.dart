import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pietyservices/UI/map/navigation_screen.dart';
import 'package:pietyservices/UI/screens/Home/home_screen.dart';
import 'package:uuid/uuid.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }
}

class LocationModel {
  final double latitude;
  final double longitude;
  final String? name;
  final String? mobile;
  LocationModel(
      {this.mobile,
      this.name,
      required this.latitude,
      required this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      mobile: json['mobile'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class MyHomePage extends StatefulWidget {
  final double Curlat;
  final double Curlong;
  MyHomePage(this.Curlat, this.Curlong);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controllertext = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '14543';
  List<dynamic> _placesList = [];
  final LocationService _locationService = LocationService();
  Position? _currentLocation;
  late List<LocationModel> _locations;
  late CollectionReference _locationsCollection; // Add this line
  Completer<GoogleMapController> _controller = Completer();
  Marker? currentLocationMarker;
  Set<Polyline> _polylines = {}; // Add this line
  @override
  void initState() {
    super.initState();
    _controllertext.addListener(() {});

    _locationsCollection = FirebaseFirestore.instance
        .collection('locations'); // Initialize _locationsCollection
    _locations = []; // Initialize with an empty list
    _getCurrentLocation();
    _currentLocation;
    _loadLocations();
  }

  Future<void> _getCurrentLocation() async {
    final currentLocation = await _locationService.getCurrentLocation();
    setState(() {
      _currentLocation = currentLocation;
    });
  }

  Future<void> _loadLocations() async {
    QuerySnapshot snapshot = await _locationsCollection.get();
    snapshot.docs.forEach((DocumentSnapshot doc) {
      final location =
          LocationModel.fromJson(doc.data() as Map<String, dynamic>);
      setState(() {
        _locations.add(location);
      });
    });
  }

  LocationModel findNearestLocation() {
    if (_locations.isEmpty) {
      // Handle the case where there are no locations available
      return LocationModel(
          latitude: 0.0, longitude: 0.0); // Provide a default value
    }

    double minDistance = double.infinity;
    LocationModel nearestLocation = _locations.first;

    for (final location in _locations) {
      final distance = _locationService.calculateDistance(
        widget.Curlat,
        widget.Curlong,
        location.latitude,
        location.longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearestLocation = location;
      }
    }

    return nearestLocation;
  }

  void _addPolyline() {
    final nearestLocation = findNearestLocation();
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: [
        LatLng(_currentLocation!.latitude, _currentLocation!.longitude),
        LatLng(nearestLocation.latitude, nearestLocation.longitude),
      ],
    );
    setState(() {
      _polylines.add(polyline);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? Center(child:CircularProgressIndicator()) // Show loading indicator while fetching location
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.terrain,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.Curlat, widget.Curlong),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId:const MarkerId('currentLocation'),
                      position: LatLng(widget.Curlat, widget.Curlong),
                      draggable: true,
                      infoWindow:const InfoWindow(title: 'Your Location'),
                    ),
                    Marker(
                      markerId: const MarkerId('nearestLocation'),
                      position: LatLng(findNearestLocation().latitude,
                          findNearestLocation().longitude),
                      infoWindow:const InfoWindow(title: 'Nearest Location'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueMagenta),
                    ),
                  },
                  circles: {
                    Circle(
                      circleId: CircleId('currentLocationCircle'),
                      center: LatLng(widget.Curlat, widget.Curlong),
                      radius: 10, // Radius in meters
                      fillColor: Colors.blue.withOpacity(0.2),
                      strokeColor: Colors.blue,
                    ),
                  },
                  polylines: _polylines,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Positioned(
                  top: 80,
                  left: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      final nearestLocation = findNearestLocation();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Nearest Location'),
                            content: Text(
                              'Latitude: ${nearestLocation.latitude}\nLongitude: ${nearestLocation.longitude}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => NavigationScreen(
                                            nearestLocation.name,
                                            widget.Curlat,
                                            widget.Curlong,
                                            nearestLocation.latitude,
                                            nearestLocation.longitude,
                                            nearestLocation.mobile,
                                          )));
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Find Nearest Location'),
                  ),
                ),
              ],
            ),
    );
  }
}
