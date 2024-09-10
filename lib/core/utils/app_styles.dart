import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  // Open Sans
  static TextStyle gfOpenSansRegularWhite({required double fontSize}) {
    return GoogleFonts.openSans(
        fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.w400);
  }

  static TextStyle gfOpenSansMediumWhite({required double fontSize}) {
    return GoogleFonts.openSans(
        fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.w700);
  }

  static TextStyle gfOpenSansBoldWhite({required double fontSize}) {
    return GoogleFonts.openSans(
        fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold);
  }

  static TextStyle gfOpenSansRegularBlack({required double fontSize}) {
    return GoogleFonts.openSans(
        fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.w400);
  }

  static TextStyle gfOpenSansMediumBlack({required double fontSize}) {
    return GoogleFonts.openSans(
        fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.w700);
  }

  static TextStyle gfOpenSansBoldBlack({required double fontSize}) {
    return GoogleFonts.openSans(
        fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.bold);
  }

// poppins

  static TextStyle gfPoppinsRegularWhite({required double fontSize}) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.w400);
  }

  static TextStyle gfPoppinsMediumWhite({required double fontSize}) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.w700);
  }

  static TextStyle gfPoppinsBoldWhite({required double fontSize}) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold);
  }

  static TextStyle gfPoppinsRegularBlack({required double fontSize}) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.w400);
  }

  static TextStyle gfPoppinsMediumBlack({required double fontSize}) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.w700);
  }

  static TextStyle gfPoppinsBoldBlack({required double fontSize}) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.bold);
  }

  static TextStyle gfPoppinsRegularGrey({required double fontSize}) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: Colors.grey, fontWeight: FontWeight.w400);
  }

  static TextStyle gfPoppinsMediumGrey({required double fontSize}) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: Colors.grey, fontWeight: FontWeight.w700);
  }

  static TextStyle gfPoppinsBoldGrey({required double fontSize}) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: Colors.grey, fontWeight: FontWeight.bold);
  }

  static TextStyle gfPoppinsCustom(
      {required double fontSize,
      required Color color,
      required FontWeight fontWeight,
      TextDecoration? textDecoration}) {
    return GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: textDecoration);
  }

  // Poppins Assets fonts
  static TextStyle poppinsRegularWhite({required double fontSize}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: FontWeight.w400);
  }

  static TextStyle poppinsMediumWhite({required double fontSize}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: FontWeight.w500);
  }

  static TextStyle poppinsBoldWhite({required double fontSize}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: FontWeight.bold);
  }

  static TextStyle poppinsRegularBlack({required double fontSize}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        color: Colors.black,
        fontWeight: FontWeight.w400);
  }

  static TextStyle poppinsMediumBlack({required double fontSize}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        color: Colors.black,
        fontWeight: FontWeight.w500);
  }

  static TextStyle poppinsBoldBlack({required double fontSize}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        color: Colors.black,
        fontWeight: FontWeight.bold);
  }

  static TextStyle poppinsRegularGrey({required double fontSize}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        color: Colors.grey,
        fontWeight: FontWeight.w400);
  }

  static TextStyle poppinsMediumGrey({required double fontSize}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        color: Colors.grey,
        fontWeight: FontWeight.w500);
  }

  static TextStyle poppinsBoldGrey({required double fontSize}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        color: Colors.grey,
        fontWeight: FontWeight.bold);
  }

  static TextStyle poppinsCustom(
      {required double fontSize,
      required Color color,
      required FontWeight fontWeight,
      TextDecoration? textDecoration}) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      decoration: textDecoration,
    );
  }

  /// Asset Fonts
  /*static TextStyle txtPoppinsMedium14 = TextStyle(
    color: ColorConstant.orange700,
    fontSize: getFontSize(
      14,
    ),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );
*/
}
