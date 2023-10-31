import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    // Replace 'images' with the path to your Firebase Storage images
    fetchImageUrls('images');
  }

  Future<void> fetchImageUrls(String folder) async {
    final ListResult result = await _storage.ref(folder).listAll();
    imageUrls = await Future.wait(
        result.items.map((Reference ref) => ref.getDownloadURL()));
  
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        onScrolled: (value) {},
        viewportFraction: 1,
        height: 200,
        autoPlay: true,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
      ),
      items: imageUrls.map((url) {
        return CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      }).toList(),
    );
  }
}
