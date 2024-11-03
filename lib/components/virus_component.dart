import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class VirusComponent extends SpriteComponent
    with HasGameRef<MusclesBuilderGame>, CollisionCallbacks {
  VirusComponent({required this.startPosition});

  final double _speed = 200;
  final double _spriteHeight = 60;

  late Vector2 _velocity;

  final Vector2 startPosition;

  Vector2 _moveSprite() {
    // Generate a random angle in radius
    final randomAngle = Random().nextDouble() * 2 * pi;
    // Calculate the sine and cosine of the angle
    final sinAngle = sin(randomAngle);
    final cosAngle = cos(randomAngle);

    final double vx = cosAngle * _speed;
    final double vy = sinAngle * _speed;

    return Vector2(vx, vy);
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.virusSprite);
    position = startPosition;
    width = height = _spriteHeight;
    anchor = Anchor.center;
    _velocity = _moveSprite();
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
      if (collisionPoint.x == 0) {
        // at the very left side
        _velocity.x = -_velocity.x;
      }
      if (collisionPoint.x >= gameRef.size.x - 60) {
        // at the very right side
        _velocity.x = -_velocity.x;
      }
      if (collisionPoint.y == 0) {
        // at the very top side
        _velocity.y = -_velocity.y;
      }
      if (collisionPoint.y >= gameRef.size.y - 60) {
        // at the very bottom side
        _velocity.y = -_velocity.y;
      }
    }
  }
}
