import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pietyservices/UI/screens/Cart/screens/catalog_screen.dart';
import 'package:pietyservices/UI/screens/Home/home_screen.dart';
import 'package:pietyservices/UI/screens/Rates/rates.dart';

import 'nav.dart';

class Navpageimg extends StatefulWidget {
  const Navpageimg({super.key});

  @override
  State<Navpageimg> createState() => _profilepageState();
}

class _profilepageState extends State<Navpageimg> {
  int index = 1;
  final screens = [HomeScreen(), CatalogScreen(), Rates_Page()];

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavBar(
        pageIndex: index,
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}

class NavModel {
  final Widget page;
  final GlobalKey<NavigatorState> navKey;

  NavModel({required this.page, required this.navKey});
}
