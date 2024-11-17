import 'package:flutter/material.dart';

final ThemeData _parentTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'BonaNovaSC',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 14,
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
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
    ),
    bodySmall: TextStyle(
      fontSize: 18,
    ),
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
