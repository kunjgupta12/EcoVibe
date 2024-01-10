import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' show cos, sqrt, asin;

class NavigationScreen extends StatefulWidget {
  final String? name;
  final double curlat;
  final double curlng;
  final double lat;
  final double lng;
  final String? mobile;
  NavigationScreen(
      this.name, this.curlat, this.curlng, this.lat, this.lng, this.mobile);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final Completer<GoogleMapController?> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  StreamSubscription<loc.LocationData>? locationSubscription;
  late int randomNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavigation();
    addMarker();

    randomNumber = Random().nextInt(10000) + 1;
    print('+91' + widget.mobile.toString());

    FirebaseFirestore.instance
        .collection('locations')
        .doc('+91' + widget.mobile.toString())
        .collection('booking_request')
        .add({
      'otp': randomNumber,
      'user_lat': widget.curlat,
      'user_long': widget.curlng,
      'ecomate_lat': widget.lat,
      'ecomate_long': widget.lng,
      'contact Number': FirebaseAuth.instance.currentUser!.phoneNumber
    });
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sourcePosition == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  polylines: Set<Polyline>.of(polylines.values),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.curlat, widget.curlng),
                    zoom: 16,
                  ),
                  markers: {sourcePosition!, destinationPosition!},
                  onTap: (latLng) {
                    print(latLng);
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Positioned(
                  top: 30,
                  left: 15,
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                Positioned(
                    bottom: 150,
                    right: 10,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.navigation_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            FirebaseFirestore.instance
                                .collection('locations')
                                .doc('+91' + widget.mobile.toString())
                                .collection('booking_request')
                                .add({
                              'otp': randomNumber,
                              'user_lat': widget.curlat,
                              'user_long': widget.curlng,
                              'ecomate_lat': widget.lat,
                              'ecomate_long': widget.lng,
                              'contact Number':
                                  FirebaseAuth.instance.currentUser!.phoneNumber
                            });

                            /*    await launchUrl(Uri.parse(
                                'google.navigation:q=${widget.lat}, ${widget.lng}&key=AIzaSyA3GwUl1lyE_0-f8EaI71VX3KbfFaK1Q54'));*/
                          },
                        ),
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: List.filled(1, BoxShadow(blurRadius: 2),
                            growable: true),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Column(
                      children: [
                        Text(
                          'Ecomate Name: ' + widget.name.toString(),
                          style: TextStyle(fontSize: 30),
                        ),
                        Text('OTP:' + randomNumber.toString()),
                        MaterialButton(
                          onPressed: () async {
                            final url = Uri.parse(
                              'tel:+91' + '' + '${(widget.mobile)}',
                            );
                            if (await canLaunchUrl(url)) {
                              launchUrl(url, mode: LaunchMode.platformDefault);
                            } else {
                              // ignore: avoid_print
                              print("Can't open  $url");
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.call),
                              Text(
                                "Contact Ecomate",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  getNavigation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    final GoogleMapController? controller = await _controller.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (_permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = await location.getLocation();
      locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocation) {
        controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(widget.curlat, widget.curlng),
          zoom: 16,
        )));
        if (mounted) {
          controller
              ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
          setState(() {
            sourcePosition = Marker(
              markerId:
                  MarkerId(LatLng(widget.curlat, widget.curlng).toString()),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position: LatLng(widget.curlat, widget.curlng),
              infoWindow: InfoWindow(
                  title:
                      '${double.parse((getDistance(LatLng(widget.lat, widget.lng)).toStringAsFixed(2)))} km'),
              onTap: () {
                print('market tapped');
              },
            );
          });
          getDirections(LatLng(widget.lat, widget.lng));
        }
      });
    }
  }

  getDirections(LatLng dst) async {
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyA3GwUl1lyE_0-f8EaI71VX3KbfFaK1Q54',
        PointLatLng(widget.curlat, widget.curlng),
        PointLatLng(dst.latitude, dst.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        points.add({'lat': point.latitude, 'lng': point.longitude});
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.green,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double getDistance(LatLng destposition) {
    return calculateDistance(widget.curlat, widget.curlng,
        destposition.latitude, destposition.longitude);
  }

  addMarker() {
    setState(() {
      sourcePosition = Marker(
        markerId: MarkerId('source'),
        position: LatLng(widget.curlat, widget.curlng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
      destinationPosition = Marker(
        markerId: MarkerId('destination'),
        position: LatLng(widget.lat, widget.lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      );
    });
  }
}
