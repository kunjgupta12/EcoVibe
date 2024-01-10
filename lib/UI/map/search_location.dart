import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pietyservices/UI/map/locate.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../Assets/app_colors.dart';

class Googleplaces extends StatefulWidget {
  const Googleplaces({super.key});

  @override
  State<Googleplaces> createState() => _GoogleplacesState();
}

class _GoogleplacesState extends State<Googleplaces> {
  final LocationService _locationService = LocationService();
  Position? _currentLocation;

  TextEditingController _controller = TextEditingController();
  TextEditingController _address = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '14543';
  List<dynamic> _placesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    _currentLocation;

    _controller.addListener(() {
      onChange();
    });
  }

  Future<LatLng> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng latLng = LatLng(location.latitude, location.longitude);
        return latLng;
      } else {
        throw Exception('No location found for the given address');
      }
    } catch (e) {
      print('Error getting LatLng: $e');
      rethrow;
    }
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  Future<void> _getCurrentLocation() async {
    final currentLocation = await _locationService.getCurrentLocation();
    setState(() {
      _currentLocation = currentLocation;
    });
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyA3GwUl1lyE_0-f8EaI71VX3KbfFaK1Q54";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var responsee = await http.get(Uri.parse(request));
    var data = responsee.body.toString();
    print(data);
    if (responsee.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(responsee.body.toString())['predictions'];
      });
    } else
      throw Exception('FAILED');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
                      Get.to(() => MyHomePage(_currentLocation!.latitude,
                          _currentLocation!.longitude));
                    },
                    child: Container(
                        height: screenHeight * .065,
                        decoration: BoxDecoration(
                          color: buttoncolor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Proceed with current location",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            Icon(
                              Icons.my_location,
                              color: Colors.white,
                            )
                          ],
                        ))),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Center(
                  child: Text('Or'),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                TextField(
                  controller: _address,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(style: BorderStyle.solid)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                          )),
                      hintText: 'House Number'),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                TextField(
                  controller: _address,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(style: BorderStyle.solid)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                          )),
                      hintText: 'Locality'),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                TextField(
                  controller: _address,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(style: BorderStyle.solid)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                          )),
                      hintText: 'City'),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Center(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(style: BorderStyle.solid)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(style: BorderStyle.solid)),
                        hintText: 'Enter Location Manually'),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: _placesList.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 60,
                            child: ListTile(
                              shape: RoundedRectangleBorder(),
                              onTap: () async {
                                List<Location> locations =
                                    await locationFromAddress(
                                        _placesList[index]['description']);
                                setState(() {
                                  _controller.text =
                                      _placesList[index]['description'];
                                  _address?.text = _placesList[index]
                                          ['structured_formatting']
                                      ['secondary_text'];
                                });
                                try {
                                  LatLng latLng = await getLatLngFromAddress(
                                      _controller.text);
                                  print(
                                      'Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}');
                                  Get.off(() => MyHomePage(
                                      latLng.latitude, latLng.longitude));
                                } catch (e) {
                                  print('Error: $e');
                                }
                              },
                              title: Text(_placesList[index]['description']),
                            ),
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
