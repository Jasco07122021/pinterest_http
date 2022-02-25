import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  // static bool isDarkTheme = true;
  // ThemeMode get currentTheme => isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  //
  // void toggleTheme() {
  //   isDarkTheme = !isDarkTheme;
  //   notifyListeners();
  // }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.white,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black),
        toolbarTextStyle: TextStyle(color: Colors.black),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.7),
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        button: TextStyle(color: Colors.black),
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.black54,
      backgroundColor: Colors.grey,
      iconTheme: const IconThemeData(color: Colors.white),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black54,
        titleTextStyle: TextStyle(color: Colors.white),
        toolbarTextStyle: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black54,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
      ),
      cardColor: Colors.black,
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    );
  }
}