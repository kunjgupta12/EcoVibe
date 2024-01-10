import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pietyservices/UI/screens/Cart/screens/confirm.dart';

import '../../../../Assets/app_colors.dart';
import '../controllers/cart_controller.dart';

class CartTotal extends StatelessWidget {
  final CartController controller = Get.find();
  CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Info",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: screenHeight * .025),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sub total",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Text(
                    '\₹${controller.total}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "PickUp cost",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Text(
                  '0.0',
                  //  "+${context.watch<CartProvider>().shoppingCost}",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.005),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Text(
                    '\₹${controller.total}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.025,
        ),
        Obx(
          () => MaterialButton(
            onPressed: () {
              print(controller.total);
              if (controller.total != '0.00') {
                Get.to(() => Confirm(
                      total: '\₹${controller.total}',
                    ));
              } else {
                Get.snackbar(
                  'No items Found',
                  'Please add items',
                  messageText: Text(
                    'Please add items',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.white,
                  onTap: (_) {},
                );
              }
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
                      "Get Cash ₹${controller.total}",
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
                ))),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          onPressed: () {
            controller.deleteAllProducts();
          },
          child: const Text('Delete All'),
        ),
      ],
    );
  }
}
