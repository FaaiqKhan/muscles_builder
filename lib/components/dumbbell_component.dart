import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class DumbbellComponent extends SpriteComponent
    with HasGameReference<MusclesBuilderGame>, CollisionCallbacks {
  // Sprite widths from the design (heavier dumbbells are slightly larger).
  static const Map<String, double> _widthByType = {
    Globals.dumbbellLightSprite: 34,
    Globals.dumbbellMediumSprite: 38,
    Globals.dumbbellHeavySprite: 42,
  };
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
    final aspect = sprite!.srcSize.y / sprite!.srcSize.x;

    width = _widthByType[dumbbell] ?? 34;
    height = width * aspect;
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void onMount() {
    position = _getRandomDumbbellPosition(width);
    super.onMount();
  }
}
