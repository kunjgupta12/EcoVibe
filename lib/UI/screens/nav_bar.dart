import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pietyservices/UI/screens/Cart/screens/catalog_screen.dart';
import 'package:pietyservices/UI/screens/Home/home_screen.dart';
import 'package:pietyservices/UI/screens/Rates/rates.dart';
import 'package:pietyservices/main.dart';

import 'nav.dart';

class Navpage extends StatefulWidget {
  const Navpage({super.key});

  @override
  State<Navpage> createState() => _profilepageState();
}

class _profilepageState extends State<Navpage> {
  int index = 0;
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
