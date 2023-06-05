import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffF5F5F5),
    primaryColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryContainer: Colors.white38,
      secondary: Colors.red,
    ),
    textTheme: TextTheme(
        titleMedium: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        titleSmall: const TextStyle(
          color: Color(0xffFAEBD7),
          fontSize: 17,
        ),
        titleLarge: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontSize: 20,
        ),
        displaySmall: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontSize: 12,
        ),
        displayMedium: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        displayLarge: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        bodySmall: const TextStyle(
            color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
    // cardTheme: CardTheme(color: )
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
        titleMedium: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        displaySmall: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
        displayMedium: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        displayLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        bodySmall: TextStyle(
            color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
  );
}
