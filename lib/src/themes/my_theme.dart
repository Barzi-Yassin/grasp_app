import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.cyan.shade700,
    ),
    scaffoldBackgroundColor: Colors.grey.shade400,
    colorScheme: ColorScheme.light(),
    primaryColor: Colors.black,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.cyan.shade600,
      splashColor: Colors.white,
      elevation: 10,
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(
        //  displaySmall.background used for the Auth textFormFields >>> hint color
        backgroundColor: Colors.grey.shade800,
      ),
    ),
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(

    //   ),
    // ),
  );

  static final darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black54,
    ),
    scaffoldBackgroundColor: Colors.grey.shade800,
    colorScheme: ColorScheme.dark(),
    primaryColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey.shade900,
      splashColor: Colors.blueGrey.shade800,
      elevation: 10,
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(
        backgroundColor: Colors.black54,
      ),
    ),
  );
}
