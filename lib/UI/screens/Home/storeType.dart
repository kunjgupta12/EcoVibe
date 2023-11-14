import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pietyservices/UI/screens/Home/image_corsoel.dart';
import 'package:pietyservices/UI/screens/Home/store_card.dart';
import '../../../Bloc/Auth/Auth_bloc.dart';
import '../../../Bloc/Auth/Auth_state.dart';
import '../Login/signing_screen.dart';
import 'home_screen.dart';

class storeType extends StatelessWidget {
  final DocumentReference documentReference;

  storeType({Key? key, required this.documentReference}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text('Top Deals'),
            const SizedBox(
              height: 10,
            ),
            ImageCarousel(),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Top Services',
              style: TextStyle(fontSize: 20),
            ),
            FutureBuilder<DocumentSnapshot>(
              future: documentReference.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text('Document does not exist');
                } else {
                  final List<dynamic> items =
                      snapshot.data!.get('storeTypes') ?? [];

                  // You can now display the array items using ListView.builder or any other widget.
                  return Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Store(
                                          storeType:
                                              items[index]['name'].toString(),
                                        )));
                          },
                          trailing: Image.network(items[index]['icon']),
                          title: Text('${index + 1}: ${items[index]['name']}'),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Center(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoggedOutState) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SignInScreen()));
                  }
                },
                builder: (context, state) {
                  return CupertinoButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).logOut();
                    },
                    child: const Text("Log Out"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
