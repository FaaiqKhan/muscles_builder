import 'package:flutter/material.dart';
import 'package:muscles_builder/theme/muscles_builder_theme.dart';

const _primaryAction = Color(0xFF246BFD);

final ThemeData musclesBuilderThemeData = ThemeData(
  useMaterial3: true,
  fontFamily: "Inter",
  textTheme: const TextTheme(
    // Large splashy titles (main menu, game over) - stroke+fill treatment,
    // always set in Fraunces regardless of the base Inter font family.
    displayLarge: TextStyle(
      fontFamily: "Fraunces",
      fontSize: 36,
      fontWeight: FontWeight.w900,
    ),
    displayMedium: TextStyle(
      fontFamily: "Fraunces",
      fontSize: 32,
      fontWeight: FontWeight.w800,
    ),
    displaySmall: TextStyle(
      fontFamily: "Fraunces",
      fontSize: 28,
      fontWeight: FontWeight.w700,
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
      fontFamily: "Fraunces",
      fontSize: 20,
      fontWeight: FontWeight.w700,
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
      fontWeight: FontWeight.w600,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryAction,
      foregroundColor: Colors.white,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      elevation: 0,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _primaryAction,
      side: const BorderSide(color: _primaryAction, width: 1.5),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(vertical: 14.5, horizontal: 32),
    ),
  ),
  extensions: const <ThemeExtension<MusclesBuilderTheme>>[
    MusclesBuilderTheme(
      background: Color(0xFFFFFFFF),
      surface: Color(0xFFFAFAFA),
      surface2: Color(0xFFF5F5F5),
      border: Color(0xFFEEEEEE),
      borderStrong: Color(0xFFE0E0E0),
      primaryText: Color(0xFF212121),
      secondaryText: Color(0xFF424242),
      tertiaryText: Color(0xFF616161),
      mutedText: Color(0xFF9E9E9E),
      accentText: Color(0xFFFACC15),
      primaryAction: _primaryAction,
      damageBar: Color(0xFFFF0000),
      healthBar: Color(0xFF00AA00),
      muscleGrowthBar: Color(0xFFFFE600),
      powerUpPurple: Color(0xFF9C27B0),
      powerUpBlue: Color(0xFF00BFFF),
      unselected: Color(0xFFE0E0E0),
      dialogBoxSurface: Color(0xFFF7F7F7),
    ),
  ],
);
