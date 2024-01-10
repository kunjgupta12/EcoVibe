import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  // Product's variables: name, price, imageUrl. All required.
  final String name;
  final int price;
  final String imageUrl;

  const Product({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      name: snap['Title'],
      price: snap['Price'],
      imageUrl: snap['Image'],
    );
    return product;
  }
}
