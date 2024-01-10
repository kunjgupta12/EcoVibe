import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pietyservices/UI/map/locate.dart';
import 'package:pietyservices/UI/map/search_location.dart';

import '../../../../Assets/app_colors.dart';
import '../controllers/cart_controller.dart';
import '../models/products_model.dart';

Row _appbar(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Row(
    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: screenWidth * .1,
          height: screenHeight * .05,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Icon(
              Icons.chevron_left_outlined,
              color: Colors.grey,
              size: 26,
            ),
          ),
        ),
      ),
      SizedBox(
        width: screenWidth * .025,
      ),
      const Text(
        "Confirm",
        style: TextStyle(fontSize: 15),
      ),
    ],
  );
}

class Confirm extends StatefulWidget {
  final String total;
  const Confirm({required this.total, super.key});

  @override
  State<Confirm> createState() => _ConfirmState();
}

final CartController controller = Get.put(CartController());

class _ConfirmState extends State<Confirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              _appbar(context),
              Obx(
                () => SizedBox(
                  height: 670,
                  child: ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: ((context, index) {
                      return CartProduct(
                        controller: controller,
                        product: controller.products.keys.toList()[index],
                        quantity: controller.products.values.toList()[index],
                        index: index,
                      );
                    }),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Get.to(() => Googleplaces());
                },
                child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: buttoncolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: controller.total.toString() != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Proceed with ₹${controller.total}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                )
                              ],
                            )
                          : const Text(
                              "CONTINUE SHOPPING",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 12),
                            ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartProduct extends StatelessWidget {
  const CartProduct(
      {Key? key,
      required this.controller,
      required this.index,
      required this.product,
      required this.quantity})
      : super(key: key);

  final CartController controller;
  final int index;
  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Image(
              image: NetworkImage(
                product.imageUrl,
              ),
              width: screenWidth * 0.25,
              height: screenHeight * 0.12,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: screenWidth * .35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: screenHeight * 0.015),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(width: 10),
              Text(
                quantity.toString() + 'kg',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
