import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class VirusAnimatedComponent extends SpriteAnimationComponent
    with CollisionCallbacks {
  VirusAnimatedComponent({
    required this.screenSize,
    required Vector2 velocity,
    required List<Image> sprite,
    required Vector2 startPosition,
  })  : _velocity = velocity,
        super(
          size: Vector2(60, 61),
          anchor: Anchor.center,
          position: startPosition,
          animation: SpriteAnimation(
            sprite
                .map((img) => Sprite(img))
                .map((sprite) => SpriteAnimationFrame(
                      sprite,
                      0.1,
                    ))
                .toList(),
          ),
        );

  final Vector2 screenSize;
  final Vector2 _velocity;

  @override
  FutureOr<void> onLoad() {
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
