import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pietyservices/Models/OrderModels/Order.dart';
import 'package:pietyservices/UI/screens/Login/signing_screen.dart';
import 'package:pietyservices/UI/screens/Profile/user_profile.dart';
import 'package:pietyservices/UI/screens/Share/share.dart';
import 'package:pietyservices/UI/screens/Home/home_screen.dart';

import 'History/order.dart';

class Navpage extends StatefulWidget {
  const Navpage({super.key});

  @override
  State<Navpage> createState() => _profilepageState();
}

class _profilepageState extends State<Navpage> {
  int index = 0;
  final screens = [HomeScreen(), order(), UserProfile()];
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color.fromARGB(255, 154, 201, 155),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          height: 60,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag),
              label: 'Orders',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
