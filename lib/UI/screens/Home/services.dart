import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final String name;
  final String price;

  final String image;
  ProductItem({required this.name, required this.price, required this.image});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayheight = MediaQuery.of(context).size.height;
    var cardImage = NetworkImage(widget.image);
    return Card(
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.lightGreen,
      elevation: 2,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              radius: 35.0,
              backgroundImage: NetworkImage(widget.image),
              backgroundColor: Colors.white,
            ),

            //Image.network(cardImage.url) ,
            title: Text(widget.name, style: TextStyle(fontSize: 40.0)),
            subtitle: Text(widget.price, style: TextStyle(fontSize: 20.0)),
          ),
          ButtonBar(
            children: <Widget>[
              MaterialButton(
                  color: Colors.white30,
                  onPressed: () {
                    /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorDetails(
                                  name: widget.name,
                                  Degree: widget.Degree,
                                  price: widget.price,
                                  email: widget.email,
                                  registrationnumber:
                                      widget.registraionnumber,
                                  Experience: widget.Experience,
                                  image: widget.image,
                                )));*/
                  },
                  child: Text(
                    'Book',
                    style: TextStyle(),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
