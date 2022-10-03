import 'package:flutter/material.dart';

ThemeGenerator themeCurrent = ThemeGenerator();

class ThemeGenerator with ChangeNotifier {
  static bool _isDarkTheme = true;
  static bool get getthemeCurrentDarkTrueLightFalse =>
      _isDarkTheme; // just to access the the bool globaly.
  ThemeMode get themeCurrent => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: Colors.lightBlue,
        colorScheme: ColorScheme.light(),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.cyan.shade700,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: Colors.grey[700],
        colorScheme: ColorScheme.dark(),
      );
}
