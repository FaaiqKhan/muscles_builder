import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:muscles_builder/components/player_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class DumbbellComponent extends SpriteComponent
    with HasGameRef<MusclesBuilderGame>, CollisionCallbacks {
  final double _spriteWidthHeight = 60.0;

  Vector2 _getRandomDumbbellPosition() {
    final int width = (gameRef.size.x - _spriteWidthHeight).toInt();
    double calculatedX = gameRef.random.nextInt(width).toDouble();
    double calculatedY =
        gameRef.random.nextInt(gameRef.size.y.toInt()).toDouble();
    final x =
        calculatedX < _spriteWidthHeight ? _spriteWidthHeight : calculatedX;
    final y = calculatedY < _spriteWidthHeight
        ? _spriteWidthHeight + (gameRef.statusBarHeight ?? 60.0)
        : calculatedY;
    return Vector2(x, y);
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    final randomValue = gameRef.random.nextInt(gameRef.dumbbells.length);
    final dumbbell = gameRef.dumbbells[randomValue];

    sprite = await gameRef.loadSprite(dumbbell);
    height = width = _spriteWidthHeight;
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
      gameRef.score += 1;
      gameRef.add(DumbbellComponent());
    }
  }
}
