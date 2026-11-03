import 'dart:ui';

import 'package:flame/components.dart';

/// Dark arcade canvas from the design: a diagonal green-black gradient, a soft
/// highlight near the top and a faint 64px grid.
class GameplayBackgroundComponent extends PositionComponent {
  GameplayBackgroundComponent() : super(priority: -100);

  static const Color baseColor = Color(0xFF12150F);
  static const double _gridStep = 64;
  static const double _gridLine = 2;

  final Paint _gridPaint = Paint()..color = const Color(0x09FFFFFF);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
  }

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);

    // linear-gradient(160deg, #2b3324 0%, #1c211a 55%, #12150f 100%)
    canvas.drawRect(
      rect,
      Paint()
        ..shader = Gradient.linear(
          Offset(size.x * 0.33, 0),
          Offset(size.x * 0.67, size.y),
          const [Color(0xFF2B3324), Color(0xFF1C211A), Color(0xFF12150F)],
          const [0, 0.55, 1],
        ),
    );

    // radial-gradient(ellipse at 50% 30%, rgba(255,255,255,.07), transparent 60%)
    canvas.save();
    canvas.translate(size.x * 0.5, size.y * 0.3);
    canvas.scale(size.x * 0.6, size.y * 0.6);
    canvas.drawCircle(
      Offset.zero,
      1,
      Paint()
        ..shader = Gradient.radial(Offset.zero, 1, const [
          Color(0x12FFFFFF),
          Color(0x00FFFFFF),
        ]),
    );
    canvas.restore();

    for (double x = 0; x < size.x; x += _gridStep) {
      canvas.drawRect(Rect.fromLTWH(x, 0, _gridLine, size.y), _gridPaint);
    }
    for (double y = 0; y < size.y; y += _gridStep) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.x, _gridLine), _gridPaint);
    }
  }
}
