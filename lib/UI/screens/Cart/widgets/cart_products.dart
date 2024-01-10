import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pietyservices/UI/screens/Cart/screens/confirm.dart';

import '../../../../Assets/app_colors.dart';
import '../controllers/cart_controller.dart';
import '../models/products_model.dart';

class CartProducts extends StatefulWidget {
  CartProducts({Key? key}) : super(key: key);

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Obx(
      () => SizedBox(
        height: screenHeight * 0.58,
        child: ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: ((context, index) {
            return CartProductCard(
              controller: controller,
              product: controller.products.keys.toList()[index],
              quantity: controller.products.values.toList()[index],
              index: index,
            );
          }),
        ),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  CartProductCard(
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
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Dismissible(
          key: UniqueKey(),
          background: Container(
            color: primarycolor,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
          ),
          onDismissed: (direction) {
            controller.deleteProduct(product);
            Get.snackbar(
              'Product Deleted',
              'You have deleted the ${product.name}!',
              messageText: Text(
                'You have deleted the ${product.name}!',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.white,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Image(
                    image: NetworkImage(
                      product.imageUrl,
                    ),
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.1,
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
                      //     SizedBox(height: screenHeight * 0.015),
                      /*  Text(
                        '',
                        style:
                            const TextStyle(fontSize: 18, color: primarycolor),
                      ),*/
                      SizedBox(height: screenHeight * 0.015),
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.removeProduct(product);
                      },
                      child: Container(
                        width: screenWidth * .08,
                        height: screenHeight * 0.035,
                        decoration: BoxDecoration(
                          color: bg,
                          border: Border.all(color: const Color(0xffF2F2F4)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Icon(
                            Iconsax.minus,
                            color: Colors.white,
                            size: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('$quantity kg'),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        controller.addProduct(product);
                      },
                      child: Container(
                        width: screenWidth * .08,
                        height: screenHeight * 0.035,
                        decoration: BoxDecoration(
                          color: bg,
                          border: Border.all(color: const Color(0xffF2F2F4)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Icon(
                            Iconsax.add,
                            color: Colors.white,
                            size: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
