import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/components/rounded_rectangle_component.dart';
import 'package:muscles_builder/theme/muscles_builder_theme.dart';

class VaccineTimerBarComponent extends PositionComponent {
  final double totalTime;

  double elapsed = 0;

  late RoundedRectangleComponent backgroundBar;
  late RoundedRectangleComponent foregroundBar;

  VaccineTimerBarComponent({
    required this.totalTime,
    required Vector2 size,
    required Vector2 position,
    required this.gameTheme,
  }) : super(
          size: size,
          position: position,
        );

  MusclesBuilderTheme gameTheme;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Background (gray)
    backgroundBar = RoundedRectangleComponent(
      size: size,
      paint: Paint()
        ..color = gameTheme.unselected
        ..style = PaintingStyle.fill,
    );

    // Foreground (green) – represents remaining time
    foregroundBar = RoundedRectangleComponent(
      size: Vector2(size.x, size.y),
      paint: Paint()
        ..color = gameTheme.muscleGrowthBar
        ..style = PaintingStyle.fill,
    );

    add(backgroundBar);
    add(foregroundBar);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (elapsed < totalTime) {
      elapsed += dt;
      double progress = (totalTime - elapsed) / totalTime;
      foregroundBar.size.x = size.x * progress;
    } else {
      foregroundBar.size.x = 0; // finished
      removeFromParent();
    }
  }
}
