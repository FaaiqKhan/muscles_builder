import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class VaccineComponent extends SpriteComponent with CollisionCallbacks {
  VaccineComponent({
    required Sprite sprite,
    required this.screenSize,
    required Vector2 startPosition,
    required double vaccineTime,
    Anchor? anchor,
    Vector2? size,
  }) : super(
          sprite: sprite,
          position: startPosition,
          size: size ?? Vector2(60, 60),
          anchor: anchor ?? Anchor.center,
        ) {
    _vaccineVisibilityTime = vaccineTime;
  }

  final Vector2 screenSize;
  final Vector2 _velocity = Vector2(200, 200);

  late double _vaccineVisibilityTime;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;
    _vaccineVisibilityTime -= dt;
    if (_vaccineVisibilityTime <= 0.0) {
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
