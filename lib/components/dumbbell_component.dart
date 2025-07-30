import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/components/player_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class DumbbellComponent extends SpriteComponent
    with HasGameReference<MusclesBuilderGame>, CollisionCallbacks {
  final double desiredRatio = 0.13;
  final double resizedWidth = 512;
  final int fontGapping = 20;
  late String dumbbell;

  Vector2 _getRandomDumbbellPosition(double spriteSize) {
    final context = game.buildContext!;
    final h = MediaQuery.of(context).viewPadding.top + fontGapping + spriteSize;
    final int width = (game.size.x - spriteSize).toInt();
    final int height = (game.size.y - h - spriteSize).toInt();
    double calculatedX = game.random.nextInt(width).toDouble();
    double calculatedY = game.random.nextInt(height).toDouble();
    final x = calculatedX < spriteSize ? spriteSize : calculatedX;
    final y = calculatedY <= h ? h + calculatedY : calculatedY;
    return Vector2(x, y);
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    final randomValue = game.random.nextInt(game.dumbbells.length);
    dumbbell = game.dumbbells[randomValue];

    sprite = await game.loadSprite(dumbbell);
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
      if (game.isGameSoundOn) {
        FlameAudio.play(Globals.dumbbellSound);
      }
      removeFromParent();
      switch (dumbbell) {
        case Globals.dumbbellMediumSprite:
          game.gameStatusPanelComponent.increaseScoreBy(2);
          break;
        case Globals.dumbbellHeavySprite:
          game.gameStatusPanelComponent.increaseScoreBy(3);
          break;
        default:
          game.gameStatusPanelComponent.increaseScoreBy(1);
      }
      game.add(DumbbellComponent());
    }
  }
}
