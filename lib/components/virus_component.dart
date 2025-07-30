import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class VirusComponent extends SpriteComponent
    with HasGameReference<MusclesBuilderGame>, CollisionCallbacks {
  VirusComponent({required this.startPosition});

  late double _speed;
  final double _spriteHeight = 60;

  late Vector2 _velocity;

  final Vector2 startPosition;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await game.loadSprite(Globals.virusSprite);
    position = startPosition;
    width = height = _spriteHeight;
    anchor = Anchor.center;
    switch (game.gameDifficultyLevel) {
      case GameDifficultyLevel.easy:
        _speed = 200;
        break;
      case GameDifficultyLevel.medium:
        _speed = 250;
        break;
      case GameDifficultyLevel.hard:
        _speed = 300;
        break;
    }
    _velocity = game.moveSprite(_speed);
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
