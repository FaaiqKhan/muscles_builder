import 'package:flutter/material.dart';

class MusclesBuilderTheme extends ThemeExtension<MusclesBuilderTheme> {
  final Color? background;
  final Color? primaryText;
  final Color? accentText;
  final Color? button;
  final Color? buttonHover;
  final Color? damageBar;
  final Color? healthBar;
  final Color? muscleGrowthBar;
  final Color? powerUpPurple;
  final Color? powerUpBlue;

  const MusclesBuilderTheme({
    required this.background,
    required this.primaryText,
    required this.accentText,
    required this.button,
    required this.buttonHover,
    required this.damageBar,
    required this.healthBar,
    required this.muscleGrowthBar,
    required this.powerUpPurple,
    required this.powerUpBlue,
  });

  static MusclesBuilderTheme dark = MusclesBuilderTheme(
    background: Color(0xFF111111),
    primaryText: Color(0xFFFFFFFF),
    accentText: Color(0xFFFFE600),
    button: Color(0xFFFF4C4C),
    buttonHover: Color(0xFFFFE600),
    damageBar: Color(0xFFFF0000),
    healthBar: Color(0xFF00FF00),
    muscleGrowthBar: Color(0xFFFFE600),
    powerUpPurple: Color(0xFF9C27B0),
    powerUpBlue: Color(0xFF00BFFF),
  );

  @override
  ThemeExtension<MusclesBuilderTheme> copyWith({
    Color? background,
    Color? primaryText,
    Color? accentText,
    Color? button,
    Color? buttonHover,
    Color? damageBar,
    Color? healthBar,
    Color? muscleGrowthBar,
    Color? powerUpPurple,
    Color? powerUpBlue,
  }) {
    return MusclesBuilderTheme(
      background: background ?? this.background,
      primaryText: primaryText ?? this.primaryText,
      accentText: accentText ?? this.accentText,
      button: button ?? this.button,
      buttonHover: buttonHover ?? this.buttonHover,
      damageBar: damageBar ?? this.damageBar,
      healthBar: healthBar ?? this.healthBar,
      muscleGrowthBar: muscleGrowthBar ?? this.muscleGrowthBar,
      powerUpPurple: powerUpPurple ?? this.powerUpPurple,
      powerUpBlue: powerUpBlue ?? this.powerUpBlue,
    );
  }

  @override
  ThemeExtension<MusclesBuilderTheme> lerp(
    covariant ThemeExtension<MusclesBuilderTheme>? other,
    double t,
  ) {
    if (other is! MusclesBuilderTheme) return this;
    return MusclesBuilderTheme(
      background: Color.lerp(background, other.background, t),
      primaryText: Color.lerp(primaryText, other.primaryText, t),
      accentText: Color.lerp(accentText, other.accentText, t),
      button: Color.lerp(button, other.button, t),
      buttonHover: Color.lerp(buttonHover, other.buttonHover, t),
      damageBar: Color.lerp(damageBar, other.damageBar, t),
      healthBar: Color.lerp(healthBar, other.healthBar, t),
      muscleGrowthBar: Color.lerp(muscleGrowthBar, other.muscleGrowthBar, t),
      powerUpPurple: Color.lerp(powerUpPurple, other.powerUpPurple, t),
      powerUpBlue: Color.lerp(powerUpBlue, other.powerUpBlue, t),
    );
  }
}
