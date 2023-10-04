import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static Color blueColor = Color(0xFF5D9CEC);
  static Color mintGreenColor = Color(0xFFDFECDB);
  static Color navyColor = Color(0xFF060E1E);
  static Color whiteColor = Color(0xFFFFFFFF);
  static Color liteNavyColor = Color(0xFF141922);
  static Color greyColor = Color(0xFFC8C9CB);
  static Color greenColor = Color(0xFF61E757);
  static Color blackColor = Color(0xFF383838);
  /*static Color greyyColor = Color(0xFFA9A9A9);*/

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: mintGreenColor,
      primaryColor: blueColor,
      appBarTheme: AppBarTheme(
          titleSpacing: 40,
          toolbarHeight: 60,
          elevation: 0,
          centerTitle: false,
          color: blueColor,
          titleTextStyle: GoogleFonts.poppins(
            color: whiteColor,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          )),
      textTheme: TextTheme(
        titleMedium: GoogleFonts.poppins(
            color: blackColor, fontWeight: FontWeight.w700, fontSize: 18),
        titleSmall: GoogleFonts.poppins(
            color: blackColor, fontWeight: FontWeight.w700, fontSize: 14),
        labelLarge: GoogleFonts.inter(
            color: greyColor, fontWeight: FontWeight.w400, fontSize: 20),
        labelMedium: GoogleFonts.inter(
            color: blueColor, fontWeight: FontWeight.w400, fontSize: 14),
        labelSmall: GoogleFonts.inter(
            color: blackColor, fontWeight: FontWeight.w400, fontSize: 18),
        bodyLarge: GoogleFonts.poppins(
            color: blueColor, fontWeight: FontWeight.w700, fontSize: 18),
        bodyMedium: GoogleFonts.inter(
            color: blackColor, fontWeight: FontWeight.w400, fontSize: 20)
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: blueColor, size: 35),
        unselectedIconTheme: IconThemeData(color: greyColor, size: 35),
      ),
      textSelectionTheme: TextSelectionThemeData(selectionColor: blueColor),
      cardColor: whiteColor,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: blueColor,
          shape: StadiumBorder(side: BorderSide(color: whiteColor, width: 4))),
      bottomAppBarTheme: BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
        color: whiteColor,
      ));
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: navyColor,
      primaryColor: blueColor,
      appBarTheme: AppBarTheme(
          titleSpacing: 40,
          toolbarHeight: 60,
          elevation: 0,
          centerTitle: false,
          color: blueColor,
          titleTextStyle: GoogleFonts.poppins(
            color: navyColor,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          )),
      textTheme: TextTheme(
        titleMedium: GoogleFonts.poppins(
            color: whiteColor, fontWeight: FontWeight.w700, fontSize: 18),
        titleSmall: GoogleFonts.poppins(
            color: whiteColor, fontWeight: FontWeight.w700, fontSize: 14),
        labelLarge: GoogleFonts.inter(
            color: greyColor, fontWeight: FontWeight.w400, fontSize: 20),
        labelMedium: GoogleFonts.inter(
            color: blueColor, fontWeight: FontWeight.w400, fontSize: 14),
        labelSmall: GoogleFonts.inter(
            color: whiteColor, fontWeight: FontWeight.w400, fontSize: 18),
        bodyLarge: GoogleFonts.poppins(
            color: blueColor, fontWeight: FontWeight.w700, fontSize: 18),
          bodyMedium: GoogleFonts.inter(
              color: whiteColor, fontWeight: FontWeight.w400, fontSize: 20)
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: blueColor, size: 35),
        unselectedIconTheme: IconThemeData(color: greyColor, size: 35),
      ),
      textSelectionTheme: TextSelectionThemeData(selectionColor: blueColor),
      cardColor: liteNavyColor,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: liteNavyColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 4,
          backgroundColor: blueColor,
          shape:
              StadiumBorder(side: BorderSide(color: liteNavyColor, width: 4))),
      bottomAppBarTheme: BottomAppBarTheme(
          shape: CircularNotchedRectangle(),
          color: liteNavyColor,
          elevation: 4));
}
