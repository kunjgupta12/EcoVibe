import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pietyservices/UI/screens/Home/home_screen.dart';

const List<String> carouselImages = [
  'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
  'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
  'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
  'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
  'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
];

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CarouselSlider(
        items: carouselImages.map(
          (i) {
            return StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('image').snapshots(),
                builder: (BuildContext value,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];

                        return Card(
                          child: Image.network(
                            data['image'],
                          ),
                        );
                      });
                });
            /* Builder(
              builder: (BuildContext context) => Image.network(
                i,
                fit: BoxFit.cover,
                height: 200,
              ),
            );*/
          },
        ).toList(),
        options: CarouselOptions(
          onScrolled: (value) {},
          viewportFraction: 1,
          height: 200,
        ),
      ),
    );
  }
}
