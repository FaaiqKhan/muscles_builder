import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:muscles_builder/components/rounded_rectangle_component.dart';

class VaccineTimerBarComponent extends PositionComponent {
  final double totalTime;

  double elapsed = 0;

  late RoundedRectangleComponent backgroundBar;
  late RoundedRectangleComponent foregroundBar;

  VaccineTimerBarComponent({
    required this.totalTime,
    required Vector2 size,
    required Vector2 position,
  }) : super(
          size: size,
          position: position,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Background (gray)
    backgroundBar = RoundedRectangleComponent(
      size: size,
      paint: BasicPalette.gray.paint()..style = PaintingStyle.fill,
    );

    // Foreground (green) – represents remaining time
    foregroundBar = RoundedRectangleComponent(
      size: Vector2(size.x, size.y),
      paint: BasicPalette.green.paint()..style = PaintingStyle.fill,
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
