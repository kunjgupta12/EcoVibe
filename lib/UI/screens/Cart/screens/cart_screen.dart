import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

AppBar _appbar(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return AppBar(
    elevation: 1,
    backgroundColor: const Color.fromARGB(255, 0, 134, 4),
    leading: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Center(
        child: Icon(
          Icons.chevron_left_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
    ),
    title: const Text(
      "Cart",
      style: TextStyle(fontSize: 22),
    ),
  );
}

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(context),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CartProducts(),
                  CartTotal(),
                ],
              ),
            ),
          ),
        ));
  }
}
