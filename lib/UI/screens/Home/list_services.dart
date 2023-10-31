import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pietyservices/UI/screens/Home/services.dart';

class listServices extends StatefulWidget {
  const listServices({super.key});

  @override
  State<listServices> createState() => _listServicesState();
}

class _listServicesState extends State<listServices> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Popular ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                child: Row(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('services')
                            .snapshots(),
                        builder: (BuildContext value,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return CircularProgressIndicator();
                          if (snapshot.hasError) return Text(('Some error'));

                          return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot data =
                                      snapshot.data!.docs[index];
                                  return ListTile(
                                    title: ProductItem(
                                        name: data['name'],
                                        price: data['price'],
                                        image: data['image']),
                                  );
                                }),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
