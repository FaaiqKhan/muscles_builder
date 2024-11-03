import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:muscles_builder/components/player_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class VaccineComponent extends SpriteComponent
    with HasGameRef<MusclesBuilderGame>, CollisionCallbacks {
  VaccineComponent({required this.startPosition});

  final double _spriteHeight = 60;
  final Vector2 startPosition;
  final double _speed = 200;

  late Vector2 _velocity;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.vaccineSprite);
    position = startPosition;
    width = height = _spriteHeight;
    anchor = Anchor.center;
    _velocity = gameRef.moveSprite(_speed);
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
    } else if (other is PlayerComponent) {
      removeFromParent();
    }
  }
}
