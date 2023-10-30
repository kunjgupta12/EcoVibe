import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pietyservices/Bloc/Auth/Auth_bloc.dart';
import 'package:pietyservices/UI/screens/nav_bar.dart';

import '../../../Bloc/Auth/Auth_state.dart';
import '../Home/home_screen.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF366695),
              height: MediaQuery.of(context).size.height * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/Images/machine.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: otpController,
                    maxLength: 6,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "6-Digit OTP",
                        counterText: ""),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoggedInState) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Navpage()));
                      } else if (state is AuthErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.grey,
                          content: Text(state.error),
                          duration: Duration(milliseconds: 2000),
                        ));
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CupertinoButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .verifyOTP(otpController.text);
                          },
                          color: Colors.blue,
                          child: Text("Verify"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
