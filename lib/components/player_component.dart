import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class PlayerComponent extends SpriteComponent
    with HasGameRef<MusclesBuilderGame> {
  PlayerComponent({required this.joystick});

  final double _speed = 500;
  final double _spriteHeight = 100;

  final JoystickComponent joystick;

  late double _leftBounds;
  late double _topBounds;
  late double _rightBounds;
  late double _bottomBounds;

  late Sprite playerFit;
  late Sprite playerFever;
  late Sprite playerSkinny;
  late Sprite playerMuscular;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    playerFit = await gameRef.loadSprite(Globals.playerFitSprite);
    playerFever = await gameRef.loadSprite(Globals.playerFeverSprite);
    playerSkinny = await gameRef.loadSprite(Globals.playerSkinnySprite);
    playerMuscular = await gameRef.loadSprite(Globals.playerMuscularSprite);

    sprite = playerSkinny;
    position = gameRef.size / 2;
    height = width = _spriteHeight;
    anchor = Anchor.center;

    final statusBarHeight =
        MediaQuery.of(gameRef.buildContext!).viewPadding.top +
            MediaQuery.of(gameRef.buildContext!).viewPadding.bottom;

    final x = size.x / 1.5;
    final y = size.y / 1.5;

    _leftBounds = x;
    _topBounds = y + statusBarHeight;
    _rightBounds = gameRef.size.x - x;
    _bottomBounds = gameRef.size.y - y;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (joystick.direction == JoystickDirection.idle) {
      return;
    }
    if (x >= _rightBounds) {
      x = _rightBounds;
    }
    if (x <= _leftBounds) {
      x = _leftBounds;
    }
    if (y >= _bottomBounds) {
      y = _bottomBounds;
    }
    if (y <= _topBounds) {
      y = _topBounds;
    }
    position.add(joystick.relativeDelta * _speed * dt);
  }
}
