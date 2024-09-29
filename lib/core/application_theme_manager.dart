import 'package:flutter/material.dart';

class ApplicationThemeManager{
  static const Color primaryColor=Color(0XFF5D9CEC);
  static const Color primaryDarkColor=Color(0XFF141922);

    static ThemeData lightThemeMode=ThemeData(
      primaryColor: primaryColor,
scaffoldBackgroundColor: const Color(0XFFDFECDB),
appBarTheme: const AppBarTheme(
  iconTheme: IconThemeData(color: Colors.white),
  backgroundColor: Colors.transparent,
  centerTitle: true,
  toolbarHeight: 120,
  titleTextStyle: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22,
    fontWeight: FontWeight.w700,
  ),
),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
       bodyLarge: TextStyle(
         fontFamily: 'Poppins',
         fontSize: 20,
         fontWeight: FontWeight.bold,
         color: primaryColor,
       ),
        bodyMedium:  TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: primaryColor,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),


      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      )

  );
  static ThemeData darkThemeMode=ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0XFF060E1E),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 120,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: primaryDarkColor
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        bodyMedium:  TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),


      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0XFF141922),
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      )

  );
}