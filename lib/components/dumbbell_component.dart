import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:muscles_builder/components/player_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class DumbbellComponent extends SpriteComponent
    with HasGameRef<MusclesBuilderGame>, CollisionCallbacks {
  final double _spriteHeight = 60;

  Vector2 _getRandomDumbbellPosition() {
    double x = gameRef.random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = gameRef.random.nextInt(gameRef.size.y.toInt()).toDouble();
    return Vector2(x, y);
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    final randomValue = gameRef.random.nextInt(gameRef.dumbbells.length);
    final dumbbell = gameRef.dumbbells[randomValue];

    sprite = await gameRef.loadSprite(dumbbell);
    height = width = _spriteHeight;
    position = _getRandomDumbbellPosition();
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PlayerComponent) {
      FlameAudio.play(Globals.dumbbellSound);
      removeFromParent();
      gameRef.add(DumbbellComponent());
    }
  }
}
