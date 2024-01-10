import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pietyservices/Bloc/Auth/Auth_bloc.dart';
import 'package:pietyservices/Bloc/Auth/Auth_state.dart';
import 'package:pietyservices/UI/screens/Login/signing_screen.dart';

import '../Cart/widgets/catalog_products.dart';

class Rates_Page extends StatefulWidget {
  const Rates_Page({super.key});

  @override
  State<Rates_Page> createState() => _RatesState();
}

class _RatesState extends State<Rates_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CatalogProducts(),
              Center(
                child:
                    BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                  if (state is AuthLoggedOutState) {
                    Navigator.pushReplacement(context,
                        CupertinoPageRoute(builder: (context) => SignInScreen()));
                  }
                }, builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).logOut();
                      },
                      child: Text('Log Out'));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
