import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Assets/app_colors.dart';
import '../widgets/widgets.dart';
import 'cart_screen.dart';

Row _appbar(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Row(
    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: screenWidth * .025,
      ),
      const Text(
        "Be a part of our Journey",
        style: TextStyle(fontSize: 20),
      ),
    ],
  );
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appbar(context),
              SizedBox(height: screenHeight * 0.01),
              CatalogProducts(),
              Center(
                child: MaterialButton(
                  onPressed: () => Get.to(() => const CartScreen(),
                      transition: Transition.cupertino),
                  child: Container(
                    width: screenWidth * .7,
                    height: screenWidth * 0.15,
                    decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Go to Cart 🛒",
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
