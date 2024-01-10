import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../Assets/app_colors.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../screens/cart_screen.dart';

class CatalogProducts extends StatelessWidget {
  CatalogProducts({Key? key}) : super(key: key);

  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Flexible(
        child: ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              return CatalogProductCard(
                index: index,
              );
            }),
      ),
    );
  }
}

class CatalogProductCard extends StatelessWidget {
  CatalogProductCard({Key? key, required this.index}) : super(key: key);

  final cartController = Get.put(CartController());
  final int index;
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Image(
                  image: NetworkImage(
                    productController.products[index].imageUrl,
                  ),
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.1,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                width: screenWidth * .35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productController.products[index].name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      '\₹${productController.products[index].price}/kg',
                      style: const TextStyle(fontSize: 18, color: primarycolor),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    '',
                    //   c.quantity.toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      cartController
                          .addProduct(productController.products[index]);
                      Get.snackbar(
                        'Item Added',
                        'You have added the ${productController.products[index].name} to your cart!',
                        messageText: Text(
                          'You have added the ${productController.products[index].name} to your cart!',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 1),
                        backgroundColor: Colors.white,
                        onTap: (_) {
                          Get.to(
                            () => const CartScreen(),
                            transition: Transition.cupertino,
                          );
                        },
                      );
                    },
                    child: Container(
                      width: screenWidth * .07,
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
    );
  }
}
