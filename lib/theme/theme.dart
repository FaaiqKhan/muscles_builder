import 'package:flutter/material.dart';
import 'package:muscles_builder/theme/muscles_builder_theme.dart';

final ThemeData musclesBuilderThemeData = ThemeData(
  useMaterial3: true,
  fontFamily: "Bungee-Regular",
  textTheme: const TextTheme(
    // Large splashy titles (main menu, game over)
    displayLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w900,
    ),
    displayMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w800,
    ),
    displaySmall: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),

    // Section headers (pause, score, stats)
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),

    // Titles (buttons, power-up labels)
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),

    // Paragraph / messages
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

    // Labels (timers, UI elements)
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
  extensions: const <ThemeExtension<dynamic>>[
    MusclesBuilderTheme(
      background: Color(0xFFDCDCDC),
      primaryText: Color(0xFF3E3E3E),
      accentText: Color(0xFFFEE60A),
      button: Color(0xFF111111),
      buttonHover: Color(0xFFFF4C4C),
      damageBar: Color(0xFFFF0000),
      healthBar: Color(0xFF00AA00),
      muscleGrowthBar: Color(0xFFFFE600),
      powerUpPurple: Color(0xFF9C27B0),
      powerUpBlue: Color(0xFF00BFFF),
      unselected: Color(0xFFD3D3D3),
    ),
  ],
);
