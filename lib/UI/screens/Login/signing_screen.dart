import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pietyservices/Bloc/Auth/Auth_bloc.dart';
import 'package:pietyservices/Bloc/Auth/Auth_state.dart';

import '../../../styles.dart';
import 'verify_number.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController phoneController = TextEditingController();
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFFA9247) : Color(0xFFC4C4C4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: SingleChildScrollView(
                child: Container(
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: PageView(
                                physics: ClampingScrollPhysics(),
                                controller: _pageController,
                                onPageChanged: (int page) {
                                  setState(() {
                                    _currentPage = page;
                                  });
                                },
                                children: const <Widget>[
                                  OnBoardingContainer(
                                    imagePath: 'assets/Images/onboarding0.png',
                                    imageText:
                                        'Get all chores done with just a click',
                                  ),
                                  OnBoardingContainer(
                                    imagePath: 'assets/Images/onboarding1.png',
                                    imageText: 'Save time for smarter work',
                                  ),
                                  OnBoardingContainer(
                                    imagePath: 'assets/Images/onboarding2.png',
                                    imageText: 'Everything in your vicinity',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildPageIndicator(),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: phoneController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]")),
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter your phone number";
                                      } else if (value.length != 10) {
                                        return "Please enter 10 digits";
                                      } else {
                                        return null;
                                      }
                                    },
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.blue,
                                      ),
                                      errorStyle:
                                          TextStyle(color: Colors.white),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "10-digit mobile number",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  BlocConsumer<AuthBloc, AuthState>(
                                    listener: (context, state) {
                                      if (state is AuthCodeSentState) {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    VerifyPhoneNumberScreen()));
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is AuthLoadingState) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      return CircleAvatar(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            String phoneNumber =
                                                "+91" + phoneController.text;
                                            BlocProvider.of<AuthBloc>(context)
                                                .sendOTP(phoneNumber);
                                          },
                                          color: Colors.blue,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))))));
  }
}

class OnBoardingContainer extends StatelessWidget {
  final String imagePath;
  final String imageText;
  const OnBoardingContainer({
    Key? key,
    required this.imagePath,
    required this.imageText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF366695),
      child: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage(
                  imagePath,
                ),
                height: MediaQuery.of(context).size.height * 0.4,
                // width: 200.0,
              ),
            ),
            SizedBox(height: 20.0),
            AutoSizeText(
              imageText,
              textAlign: TextAlign.center,
              maxLines: 2,
              minFontSize: 20,
              maxFontSize: 30,
              style: kTitleStyle,
            ),
          ],
        ),
      ),
    );
  }
}
