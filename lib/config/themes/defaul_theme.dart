import 'package:flutter/material.dart';

ThemeData defaultTheme() {
  return ThemeData(
    primaryColor: Colors.pink,
    cardColor: Colors.white,
    cardTheme: CardTheme(color: Colors.white, shadowColor: Colors.white),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.pink,
      brightness: Brightness.light,
      primary: Colors.pink,
      onPrimary: Colors.white,
      secondary: Colors.pinkAccent,
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.pink,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12), 
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.pinkAccent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.pinkAccent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.pink,
          width: 2,
        ), 
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    ),
  );
}
