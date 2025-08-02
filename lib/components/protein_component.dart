import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class ProteinComponent extends SpriteComponent with CollisionCallbacks {
  ProteinComponent({
    required Sprite sprite,
    required this.screenSize,
    required Vector2 startPosition,
    Anchor? anchor,
    Vector2? size,
  }) : super(
          sprite: sprite,
          position: startPosition,
          size: size ?? Vector2(60, 60),
          anchor: anchor ?? Anchor.center,
        );

  final Vector2 screenSize;
  final Vector2 _velocity = Vector2(200, 200);

  // Protein visibility is for 5 seconds
  double _proteinVisibilityTime = 5.0;

  @override
  FutureOr<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;
    _proteinVisibilityTime -= dt;
    if (_proteinVisibilityTime <= 0.0) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is ScreenHitbox) {
      MusclesBuilderGame.bounceBack(
        objectSize: size,
        screenSize: screenSize,
        originalVelocity: _velocity,
        collisionPoint: intersectionPoints.first,
      );
      position.clamp(
        Vector2.zero(),
        screenSize,
      );
    }
    super.onCollision(intersectionPoints, other);
  }
}
