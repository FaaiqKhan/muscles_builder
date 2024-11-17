import 'package:flutter/material.dart';

/// Use label for buttons text
/// Use body for screen text

final ThemeData _parentTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'PressStart2P-Regular',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
    )
  ),
  scaffoldBackgroundColor: Colors.white,
);

final ThemeData lightTheme = _parentTheme.copyWith(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.red,
    secondary: Colors.pink,
  ),
);

final ThemeData darkTheme = _parentTheme.copyWith(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.orange,
    secondary: Colors.purple,
  ),
  // Define additional theme properties
);
