import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class ProteinComponent extends SpriteComponent
    with HasGameReference<MusclesBuilderGame>, CollisionCallbacks {
  ProteinComponent({required this.startPosition});

  late Vector2 _velocity;
  final Vector2 startPosition;

  final double _speed = 200;
  final double _spriteHeight = 60;

  // Protein visibility is for 5 seconds
  double _proteinVisibilityTime = 5.0;

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite(Globals.proteinSprite);
    position = startPosition;
    width = height = _spriteHeight;
    anchor = Anchor.center;
    _velocity = game.moveSprite(_speed);
    add(RectangleHitbox());
    await super.onLoad();
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
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      final Vector2 collisionPoint = intersectionPoints.first;
      if (collisionPoint.x == 0) {
        // at the very left side
        _velocity.x = -_velocity.x;
      }
      if (collisionPoint.x >= game.size.x - 60) {
        // at the very right side
        _velocity.x = -_velocity.x;
      }
      if (collisionPoint.y == 0) {
        // at the very top side
        _velocity.y = -_velocity.y;
      }
      if (collisionPoint.y >= game.size.y - 60) {
        // at the very bottom side
        _velocity.y = -_velocity.y;
      }
    }
  }
}
