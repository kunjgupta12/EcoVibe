import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Future<List<String>> getImageUrlsFromFirestore() async {
  final CollectionReference imagesCollection = FirebaseFirestore.instance
      .collection('admin_panel'); // Replace with your collection name

  DocumentSnapshot documentSnapshot = await imagesCollection
      .doc('data')
      .get(); // Replace with the specific document ID

  if (documentSnapshot.exists) {
    List<dynamic> dynamicImageUrls = documentSnapshot['dashboardImage'];
    List<String> imageUrls = dynamicImageUrls
        .map((url) => url.toString())
        .toList(); // Replace with your field name
    return imageUrls;
  } else {
    return [];
  }
}

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    getImageUrlsFromFirestore().then((urls) {
      setState(() {
        imageUrls = urls;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imageUrls.map((url) {
        return Container(
          child: Image.network(url),
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
      ),
    );
  }
}
