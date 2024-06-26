import 'package:flutter/material.dart';
import '../constant.dart';

abstract class Styles {
  static TextStyle textStyle20(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define your breakpoints and font size scaling
    double fontSize = 20; // Default font size for small screens (phones)
    if (screenWidth > 1200) {
      // Large screens (large tablets, desktops)
      fontSize = 20 * 1.5;
    } else if (screenWidth > 600) {
      // Medium screens (tablets)
      fontSize = 20 * 1.2;
    }

    // Return the TextStyle with the adjusted fontSize
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );
  }

  static double _responsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1200) {
      // Large screens (large tablets, desktops)
      return baseSize * 1.5;
    } else if (screenWidth > 600) {
      // Medium screens (tablets)
      return baseSize * 1.2;
    }
    return baseSize; // Small screens (phones)
  }

  // Methods to get a responsive TextStyle based on the screen width
  static TextStyle textStyle18(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(context, 18),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle textStyle24(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(context, 24),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle textStyle30(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(context, 30),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textStyle14(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(context, 14),
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    );
  }

  static TextStyle textStyleDate(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(context, 16),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );
  }

  static TextStyle textStyle28(BuildContext context) {
    return TextStyle(
      fontSize: _responsiveFontSize(context, 28),
      fontWeight: FontWeight.w500,
      color: Colors.red, // Replace with the actual color variable if needed
    );
  }

  static TextStyle textStyleRL(BuildContext context) {
    return TextStyle(
      color: const Color.fromARGB(255, 44, 43, 43),
      fontSize: _responsiveFontSize(context, 32),
      fontWeight: FontWeight.bold,
      letterSpacing: 3.5,
      shadows: const [
        Shadow(
          offset: Offset(1.0, 1.0),
          blurRadius: 3.0,
          color: Color.fromARGB(255, 236, 236, 236),
        ),
        Shadow(
          offset: Offset(1.0, 1.0),
          blurRadius: 8.0,
          color: Color.fromARGB(255, 230, 19, 19),
        ),
      ],
    );
  }
}
