import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pietyservices/Bloc/Auth/Auth_bloc.dart';
import 'package:pietyservices/UI/screens/Home/image_corsoel.dart';
import 'package:pietyservices/UI/screens/Home/list_services.dart';
import 'package:pietyservices/UI/screens/Home/services.dart';

import '../../../Bloc/Auth/Auth_state.dart';
import '../Login/signing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Colors.green,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
          centerTitle: true,
          title: Text("Hello"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text('Top Deals'),
              SizedBox(
                height: 10,
              ),
              ImageCarousel(),
              SizedBox(
                height: 40,
              ),
              Text(
                'Top Services',
                style: TextStyle(fontSize: 20),
              ),
              listServices(),
              Center(
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoggedOutState) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SignInScreen()));
                    }
                  },
                  builder: (context, state) {
                    return CupertinoButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).logOut();
                      },
                      child: Text("Log Out"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
