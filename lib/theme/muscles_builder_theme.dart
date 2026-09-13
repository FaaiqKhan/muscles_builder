import 'package:flutter/material.dart';

class MusclesBuilderTheme extends ThemeExtension<MusclesBuilderTheme> {
  final Color background;
  final Color surface;
  final Color surface2;
  final Color border;
  final Color borderStrong;
  final Color primaryText;
  final Color secondaryText;
  final Color tertiaryText;
  final Color mutedText;
  final Color accentText;
  final Color primaryAction;
  final Color damageBar;
  final Color healthBar;
  final Color muscleGrowthBar;
  final Color powerUpPurple;
  final Color powerUpBlue;
  final Color unselected;
  final Color dialogBoxSurface;

  const MusclesBuilderTheme({
    required this.background,
    required this.surface,
    required this.surface2,
    required this.border,
    required this.borderStrong,
    required this.primaryText,
    required this.secondaryText,
    required this.tertiaryText,
    required this.mutedText,
    required this.accentText,
    required this.primaryAction,
    required this.damageBar,
    required this.healthBar,
    required this.muscleGrowthBar,
    required this.powerUpPurple,
    required this.powerUpBlue,
    required this.unselected,
    required this.dialogBoxSurface,
  });

  static MusclesBuilderTheme dark = MusclesBuilderTheme(
    background: Color(0xFF181A20),
    surface: Color(0xFF1F222A),
    surface2: Color(0xFF262A35),
    border: Color(0xFF35383F),
    borderStrong: Color(0xFF4A4D54),
    primaryText: Color(0xFFFFFFFF),
    secondaryText: Color(0xFFEEEEEE),
    tertiaryText: Color(0xFFBDBDBD),
    mutedText: Color(0xFF757575),
    accentText: Color(0xFFFACC15),
    primaryAction: Color(0xFF246BFD),
    damageBar: Color(0xFFFF0000),
    healthBar: Color(0xFF00FF00),
    muscleGrowthBar: Color(0xFFFFE600),
    powerUpPurple: Color(0xFF9C27B0),
    powerUpBlue: Color(0xFF00BFFF),
    unselected: Color(0xFF4A4D54),
    dialogBoxSurface: Color(0xFFF7F7F7),
  );

  @override
  ThemeExtension<MusclesBuilderTheme> copyWith({
    Color? background,
    Color? surface,
    Color? surface2,
    Color? border,
    Color? borderStrong,
    Color? primaryText,
    Color? secondaryText,
    Color? tertiaryText,
    Color? mutedText,
    Color? accentText,
    Color? primaryAction,
    Color? damageBar,
    Color? healthBar,
    Color? muscleGrowthBar,
    Color? powerUpPurple,
    Color? powerUpBlue,
    Color? unselected,
    Color? dialogBoxSurface,
  }) {
    return MusclesBuilderTheme(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surface2: surface2 ?? this.surface2,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      tertiaryText: tertiaryText ?? this.tertiaryText,
      mutedText: mutedText ?? this.mutedText,
      accentText: accentText ?? this.accentText,
      primaryAction: primaryAction ?? this.primaryAction,
      damageBar: damageBar ?? this.damageBar,
      healthBar: healthBar ?? this.healthBar,
      muscleGrowthBar: muscleGrowthBar ?? this.muscleGrowthBar,
      powerUpPurple: powerUpPurple ?? this.powerUpPurple,
      powerUpBlue: powerUpBlue ?? this.powerUpBlue,
      unselected: unselected ?? this.unselected,
      dialogBoxSurface: dialogBoxSurface ?? this.dialogBoxSurface,
    );
  }

  @override
  ThemeExtension<MusclesBuilderTheme> lerp(
    covariant ThemeExtension<MusclesBuilderTheme>? other,
    double t,
  ) {
    if (other is! MusclesBuilderTheme) return this;
    return MusclesBuilderTheme(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      tertiaryText: Color.lerp(tertiaryText, other.tertiaryText, t)!,
      mutedText: Color.lerp(mutedText, other.mutedText, t)!,
      accentText: Color.lerp(accentText, other.accentText, t)!,
      primaryAction: Color.lerp(primaryAction, other.primaryAction, t)!,
      damageBar: Color.lerp(damageBar, other.damageBar, t)!,
      healthBar: Color.lerp(healthBar, other.healthBar, t)!,
      muscleGrowthBar: Color.lerp(muscleGrowthBar, other.muscleGrowthBar, t)!,
      powerUpPurple: Color.lerp(powerUpPurple, other.powerUpPurple, t)!,
      powerUpBlue: Color.lerp(powerUpBlue, other.powerUpBlue, t)!,
      unselected: Color.lerp(unselected, other.unselected, t)!,
      dialogBoxSurface:
          Color.lerp(dialogBoxSurface, other.dialogBoxSurface, t)!,
    );
  }
}
