import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pietyservices/Bloc/Auth/Auth_bloc.dart';
import 'package:pietyservices/Bloc/Auth/Auth_state.dart';
import 'package:pietyservices/UI/screens/nav_bar.dart';
import 'package:pietyservices/UI/screens/Login/splash.dart';
import 'UI/screens/Login/signing_screen.dart';
import 'UI/screens/Home/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'pietyservices',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  get();
  await FirebaseAppCheck.instance
      .activate(androidProvider: AndroidProvider.playIntegrity);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: GetMaterialApp(
        theme: ThemeData(fontFamily: 'OpenSans'),
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (oldState, newState) {
            return oldState is AuthInitialState;
          },
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return SplashScreen();
            } else if (state is AuthLoggedOutState) {
              return SplashScreen();
            } else {
              return Scaffold();
            }
          },
        ),
      ),
    );
  }
}
