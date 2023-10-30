import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pietyservices/Bloc/Auth/Auth_bloc.dart';
import 'package:pietyservices/UI/screens/Home/carsoel.dart';
import 'package:pietyservices/UI/screens/Home/services.dart';

import '../../../Bloc/Auth/Auth_state.dart';
import '../Login/signing_screen.dart';

const List<String> carouselImages = [
  'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
  'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
  'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
  'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
  'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
];

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
              CarouselImage(),
              SizedBox(
                height: 40,
              ),
              Text(
                'Top Services',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                child: Center(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
