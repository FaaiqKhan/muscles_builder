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
  final double desiredRatio = 0.13;
  final double resizedWidth = 512;
  final int fontGapping = 20;
  late String dumbbell;

  Vector2 _getRandomDumbbellPosition(double spriteSize) {
    final context = gameRef.buildContext!;
    final h = MediaQuery.of(context).viewPadding.top + fontGapping + spriteSize;
    final int width = (gameRef.size.x - spriteSize).toInt();
    final int height = (gameRef.size.y - h - spriteSize).toInt();
    double calculatedX = gameRef.random.nextInt(width).toDouble();
    double calculatedY = gameRef.random.nextInt(height).toDouble();
    final x = calculatedX < spriteSize ? spriteSize : calculatedX;
    final y = calculatedY <= h ? h + calculatedY : calculatedY;
    return Vector2(x, y);
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    final randomValue = gameRef.random.nextInt(gameRef.dumbbells.length);
    dumbbell = gameRef.dumbbells[randomValue];

    sprite = await gameRef.loadSprite(dumbbell);
    final resizeRatio = sprite!.srcSize.x / sprite!.srcSize.y;

    width = resizedWidth * desiredRatio;
    height = (sprite!.srcSize.y / resizeRatio) * desiredRatio;
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void onMount() {
    position = _getRandomDumbbellPosition(width);
    super.onMount();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PlayerComponent) {
      FlameAudio.play(Globals.dumbbellSound);
      removeFromParent();
      switch (dumbbell) {
        case Globals.dumbbellMediumSprite:
          gameRef.score += 2;
          break;
        case Globals.dumbbellHeavySprite:
          gameRef.score += 3;
          break;
        default:
          gameRef.score += 1;
      }
      gameRef.add(DumbbellComponent());
    }
  }
}
