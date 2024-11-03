import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/components/vaccine_component.dart';
import 'package:muscles_builder/components/virus_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class PlayerComponent extends SpriteComponent
    with HasGameRef<MusclesBuilderGame>, CollisionCallbacks {
  PlayerComponent({required this.joystick});

  final double _speed = 500;
  final double _spriteWidthHeight = 100;

  final JoystickComponent joystick;

  late double _leftBounds;
  late double _topBounds;
  late double _rightBounds;
  late double _bottomBounds;

  late Sprite playerFit;
  late Sprite playerFever;
  late Sprite playerSkinny;
  late Sprite playerMuscular;

  bool _virusAttacked = false;
  bool isVaccinated = false;
  final Timer _timer = Timer(3);

  late double oneHalfOfSpriteWidth;
  late double oneHalfOfSpriteHeight;

  void _freezePlayer() {
    if (!_virusAttacked) {
      FlameAudio.play(Globals.virusSound);
      _virusAttacked = true;
      playerSprite();
      if (gameRef.score > 0) {
        gameRef.score -= 1;
      }
      _timer.start();
    }
  }

  void _unFreezePlayer() {
    _virusAttacked = false;
    playerSprite();
  }

  void playerSprite() {
    if (_virusAttacked) {
      sprite = playerFever;
    } else if (gameRef.score > 10 && gameRef.score <= 20) {
      sprite = playerFit;
    } else if (gameRef.score > 20) {
      sprite = playerMuscular;
    } else {
      sprite = playerSkinny;
    }
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    playerFit = await gameRef.loadSprite(Globals.playerFitSprite);
    playerFever = await gameRef.loadSprite(Globals.playerFeverSprite);
    playerSkinny = await gameRef.loadSprite(Globals.playerSkinnySprite);
    playerMuscular = await gameRef.loadSprite(Globals.playerMuscularSprite);

    playerSprite();
    position = gameRef.size / 2;
    height = width = _spriteWidthHeight;
    anchor = Anchor.center;

    oneHalfOfSpriteWidth = size.x / 1.5;
    oneHalfOfSpriteHeight = size.y / 1.5;

    add(RectangleHitbox());
  }

  @override
  void onMount() {
    final context = gameRef.buildContext!;
    _leftBounds = oneHalfOfSpriteWidth;
    _topBounds = oneHalfOfSpriteHeight +
        MediaQuery.of(context).viewPadding.top +
        Theme.of(context).textTheme.displaySmall!.fontSize!;
    _rightBounds = gameRef.size.x - oneHalfOfSpriteWidth;
    _bottomBounds = gameRef.size.y - oneHalfOfSpriteHeight;
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_virusAttacked) {
      if (joystick.direction == JoystickDirection.idle) {
        return;
      }
      playerSprite();
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
    } else {
      _timer.update(dt);
      if (_timer.finished) {
        _unFreezePlayer();
      }
    }
  }

  void injectVaccine() {
    if (!_virusAttacked) {
      isVaccinated = true;
      FlameAudio.play(Globals.vaccineSound);
      gameRef.vaccineTimer.start();
    }
  }

  void removeVaccine() {
    isVaccinated = false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is VirusComponent) {
      if (!isVaccinated) {
        _freezePlayer();
      }
    }
    if (other is VaccineComponent) {
      injectVaccine();
    }
  }
}
