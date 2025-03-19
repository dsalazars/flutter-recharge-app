import 'package:flutter/material.dart';

ThemeData defaultTheme() {
  return ThemeData(
    primaryColor: Colors.pink, // (obsoleto, usa `colorScheme`)
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
    // Personalización del borde en los TextFields
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.pink,
          width: 2,
        ), // Borde cuando está inactivo
        borderRadius: BorderRadius.circular(12), // Radio del borde
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.pinkAccent,
          width: 2,
        ), // Borde al enfocar
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.pinkAccent,
          width: 2,
        ), // Borde al haber error
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.pink,
          width: 2,
        ), // Borde al enfocar con error
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    // Personalización del borde en los botones
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent, // Color de fondo del botón
        foregroundColor: Colors.white, // Color del texto
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Borde menos redondeado
          side: const BorderSide(
            color: Colors.red,
            width: 2,
          ), // Borde del botón
        ),
      ),
    ),
  );
}
