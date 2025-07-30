import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScorePanelBackground extends CustomPainterComponent {
  final Color fillColor;
  final Color borderColor;

  ScorePanelBackground({
    required Vector2 size,
    required this.fillColor,
    required this.borderColor,
  }) : super(position: Vector2.zero(), size: size);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    final shadowRect = Rect.fromLTRB(-5, -5, size.x + 5, size.y + 2.5);
    final rRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(12),
    );

    // Draw shadow first
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        shadowRect,
        const Radius.circular(12),
      ));
    canvas.drawShadow(path, fillColor, 6, false);

    // Draw fill
    final fillPaint = Paint()..color = fillColor;
    canvas.drawRRect(rRect, fillPaint);

    // Draw border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rRect, borderPaint);
  }
}
