import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RoundedPanel extends ShapeComponent {
  RoundedPanel(Vector2 size, Color color, {double borderWidth = 2.0, Color? borderColor})
      : super(
    shape: RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      const Radius.circular(12),
    ),
    paint: Paint()..color = color,
    border: borderColor != null
        ? Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
        : null,
    position: Vector2.zero(),
    size: size,
  );
}
