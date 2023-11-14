import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pietyservices/UI/screens/Home/home_screen.dart';
import 'package:pietyservices/UI/screens/Home/storeType.dart';

class Store extends StatefulWidget {
  const Store({required this.storeType, super.key});
  final storeType;
  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('stores'),
      ),
      body: Column(
        children: [
          Container(
            child: Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('stores')
                  .where('storeType', isEqualTo: widget.storeType)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Text('No matching data found.');
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                    // Customize this part to display your data
                    return ListTile(
                      title: Text(data['name']),
                    );
                  }).toList(),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
