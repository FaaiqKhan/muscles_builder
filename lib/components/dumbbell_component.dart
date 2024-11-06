import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/components/player_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class DumbbellComponent extends SpriteComponent
    with HasGameRef<MusclesBuilderGame>, CollisionCallbacks {
  final double _spriteSize = 60.0;

  Vector2 _getRandomDumbbellPosition() {
    final context = gameRef.buildContext!;
    final h = MediaQuery.of(context).viewPadding.top +
        Theme.of(context).textTheme.displaySmall!.fontSize! +
        _spriteSize;
    final int width = (gameRef.size.x - _spriteSize).toInt();
    final int height = (gameRef.size.y - h - _spriteSize).toInt();
    double calculatedX = gameRef.random.nextInt(width).toDouble();
    double calculatedY = gameRef.random.nextInt(height).toDouble();
    final x = calculatedX < _spriteSize ? _spriteSize : calculatedX;
    final y = calculatedY <= h ? h + calculatedY : calculatedY;
    return Vector2(x, y);
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    final randomValue = gameRef.random.nextInt(gameRef.dumbbells.length);
    final dumbbell = gameRef.dumbbells[randomValue];

    sprite = await gameRef.loadSprite(dumbbell);
    height = width = _spriteSize;
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void onMount() {
    position = _getRandomDumbbellPosition();
    super.onMount();
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
