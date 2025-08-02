import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

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
