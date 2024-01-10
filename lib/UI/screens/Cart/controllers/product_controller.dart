import 'package:get/get.dart';
import 'package:pietyservices/UI/screens/Cart/services/firestore_db.dart';

import '../models/products_model.dart';

class ProductController extends GetxController {
  // Add a list of Product objects.
  final products = <Product>[].obs;

  @override
  void onInit() {
    products.bindStream(FirestoreDB().getAllProducts());
    super.onInit();
  }
}
