import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pietyservices/UI/screens/Login/signing_screen.dart';
import 'package:pietyservices/UI/screens/nav_bar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  User? user;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, _navigate);
  }

  User? currentUser = _auth.currentUser;
  void _navigate() async {
    if (!mounted) return;
    if (currentUser != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Navpage()));
    } else
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    startTime();

    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'EcoVibe',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            //Todo
            /* SpinKitSquareCircle(
              color: Colors.white,
              size: 50.0,
              controller: AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 1200)),
            ),*/
          ],
        ),
      ),
    ));
  }
}
