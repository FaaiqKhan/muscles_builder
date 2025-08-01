import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class VirusComponent extends SpriteComponent with CollisionCallbacks {
  VirusComponent({
    required Sprite sprite,
    required this.screenSize,
    required Vector2 velocity,
    required Vector2 startPosition,
    Anchor? anchor,
    Vector2? size,
  })  : _velocity = velocity,
        super(
          sprite: sprite,
          position: startPosition,
          anchor: anchor ?? Anchor.center,
          size: size ?? Vector2(60, 60),
        );

  final Vector2 screenSize;
  final Vector2 _velocity;

  @override
  FutureOr<void> onLoad() async {
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      final Vector2 collisionPoint = intersectionPoints.first;

      final bool hitLeft = collisionPoint.x <= 0;
      final bool hitRight = collisionPoint.x >= screenSize.x - size.x;
      final bool hitTop = collisionPoint.y <= 0;
      final bool hitBottom = collisionPoint.y >= screenSize.y - size.y;

      if (hitLeft) {
        _velocity.x = _velocity.x.abs(); // bounce right
      }

      if (hitRight) {
        _velocity.x = -_velocity.x.abs(); // bounce left
      }

      if (hitTop) {
        _velocity.y = _velocity.y.abs(); // bounce down
      }

      if (hitBottom) {
        _velocity.y = -_velocity.y.abs(); // bounce up
      }

      position.clamp(
        Vector2.zero(),
        screenSize,
      );
    }
  }
}
