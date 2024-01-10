import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color lightGrey = Color.fromARGB(255, 61, 63, 69);
const Color darkGrey = Color.fromARGB(255, 18, 18, 19);
const Color primaryColor = Color.fromARGB(255, 9, 202, 172);
const Color backgroundColor = Color.fromARGB(255, 26, 27, 30);
Color bg = Color.fromARGB(255, 0, 134, 4);

const primarycolor = Color.fromRGBO(86, 173, 51, 1);
const primarycolor2 = Color(0xFFFFF2EA);
const buttoncolor = Color.fromRGBO(30, 100, 24, 1);

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  height: 1.2,
);

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFFF4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
      primaryColor: primaryClr,
      backgroundColor: white,
      scaffoldBackgroundColor: Colors.white);

  static final dark = ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryClr,
      backgroundColor: darkGreyClr);
}

TextStyle get bigTitleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white));
}

TextStyle get textStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 16, color: Colors.white));
}

TextStyle get buttonTextStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white));
}

TextStyle get cardTitleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black));
}

TextStyle get subCardTitleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black));
}
