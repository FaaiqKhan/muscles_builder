import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class RoundedRectangleComponent extends RectangleComponent {
  final double borderRadius;

  RoundedRectangleComponent({
    required super.size,
    super.position,
    super.paint,
    this.borderRadius = 8,
  });

  @override
  void render(Canvas canvas) {
    final rRect = RRect.fromRectAndRadius(
      size.toRect(),
      Radius.circular(borderRadius),
    );
    canvas.drawRRect(rRect, paint);
  }
}
