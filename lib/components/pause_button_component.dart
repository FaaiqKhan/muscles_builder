import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';
import 'package:muscles_builder/screens/game_pause_screen.dart';

class PauseButtonComponent extends CustomPainterComponent
    with HasGameReference<MusclesBuilderGame>, TapCallbacks {
  final double radius;

  final Color borderColor;
  final Color backgroundColor;
  final Color iconColor;

  PauseButtonComponent({
    required this.radius,
    required this.borderColor,
    required this.backgroundColor,
    required this.iconColor,
    Vector2? position,
    Anchor? anchor,
  }) : super(
          size: Vector2.all(radius * 2),
          position: position ?? Vector2.zero(),
          anchor: anchor ?? Anchor.center,
        );

  @override
  void render(Canvas canvas) {
    final center = Offset(radius, radius);
    final rRect = RRect.fromRectAndRadius(
      Rect.fromCircle(center: center, radius: radius),
      Radius.circular(radius),
    );

    // Draw shadow first
    final path = Path()..addRRect(rRect);
    canvas.drawShadow(path, iconColor, 3, false);

    // Draw circle background
    final circlePaint = Paint()..color = backgroundColor.withAlpha(200);
    canvas.drawCircle(
      center,
      radius,
      circlePaint,
    );

    // Draw pause icon (two rectangles)
    final barWidth = radius * 0.2;
    final barHeight = radius * 0.9;
    final barGap = radius * 0.2;

    final paint = Paint()..color = iconColor;

    // Draw left bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx - barGap, center.dy),
          width: barWidth,
          height: barHeight,
        ),
        Radius.circular(barWidth),
      ),
      paint,
    );

    // Draw right bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx + barGap, center.dy),
          width: barWidth,
          height: barHeight,
        ),
        Radius.circular(barWidth),
      ),
      paint,
    );

    // Draw border
    final borderPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rRect, borderPaint);
    super.render(canvas);
  }

  @override
  void onTapDown(TapDownEvent event) {
    pauseGame();
    super.onTapDown(event);
  }

  void pauseGame() {
    game.pauseEngine();
    game.overlays.add(GamePauseScreen.id);
  }
}
