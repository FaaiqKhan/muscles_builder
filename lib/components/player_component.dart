import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/components/dumbbell_component.dart';
import 'package:muscles_builder/components/protein_component.dart';
import 'package:muscles_builder/components/vaccine_component.dart';
import 'package:muscles_builder/components/virus_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class PlayerComponent extends SpriteComponent
    with HasGameReference<MusclesBuilderGame>, CollisionCallbacks {
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

  bool virusAttacked = false;
  bool isVaccinated = false;
  final Timer _timer = Timer(3);

  late double oneHalfOfSpriteWidth;
  late double oneHalfOfSpriteHeight;

  void _freezePlayer() {
    if (!virusAttacked) {
      if (game.isGameSoundOn) {
        FlameAudio.play(Globals.virusSound);
      }
      virusAttacked = true;
      playerSprite();
      if (game.gameStatusPanelComponent.getScore() > 0) {
        game.gameStatusPanelComponent.decreaseScoreBy(1);
      }
      _timer.start();
    }
  }

  void _unFreezePlayer() {
    virusAttacked = false;
    playerSprite();
  }

  void playerSprite() {
    if (virusAttacked) {
      sprite = playerFever;
    } else if (game.gameStatusPanelComponent.getScore() > 10 &&
        game.gameStatusPanelComponent.getScore() <= 20) {
      sprite = playerFit;
    } else if (game.gameStatusPanelComponent.getScore() > 20) {
      sprite = playerMuscular;
    } else {
      sprite = playerSkinny;
    }
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    playerFit = await game.loadSprite(Globals.playerFitSprite);
    playerFever = await game.loadSprite(Globals.playerFeverSprite);
    playerSkinny = await game.loadSprite(Globals.playerSkinnySprite);
    playerMuscular = await game.loadSprite(Globals.playerMuscularSprite);

    playerSprite();
    position = game.size / 2;
    height = width = _spriteWidthHeight;
    anchor = Anchor.center;

    oneHalfOfSpriteWidth = size.x / 1.5;
    oneHalfOfSpriteHeight = size.y / 1.5;

    add(RectangleHitbox());
  }

  @override
  void onMount() {
    final context = game.buildContext!;
    _leftBounds = oneHalfOfSpriteWidth;
    _topBounds = oneHalfOfSpriteHeight +
        MediaQuery.of(context).viewPadding.top +
        Theme.of(context).textTheme.displaySmall!.fontSize!;
    _rightBounds = game.size.x - oneHalfOfSpriteWidth;
    _bottomBounds = game.size.y - oneHalfOfSpriteHeight;
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!virusAttacked) {
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
    if (!virusAttacked) {
      isVaccinated = true;
      if (game.isGameSoundOn) {
        FlameAudio.play(Globals.vaccineSound);
      }
      game.vaccineTimer.start();
    }
  }

  void removeVaccine() {
    isVaccinated = false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is VirusComponent &&
        !isVaccinated &&
        !virusAttacked &&
        game.gameStatusPanelComponent.isWarmupTimeCompleted) {
      _freezePlayer();
    } else if (other is VaccineComponent && !virusAttacked) {
      injectVaccine();
    } else if (other is ProteinComponent && !virusAttacked) {
      other.removeFromParent();
      // Generate number from 0 to 8
      int randomBonusScore = game.random.nextInt(9);
      game.gameStatusPanelComponent.increaseScoreBy(randomBonusScore);
      if (game.isGameSoundOn) {
        FlameAudio.play(Globals.proteinSound);
      }
      game.proteinTimer.stop();
      game.proteinBonus = randomBonusScore;
    } else if (other is DumbbellComponent && !virusAttacked) {
      if (game.isGameSoundOn) {
        FlameAudio.play(Globals.dumbbellSound);
      }
      other.removeFromParent();
      switch (other.dumbbell) {
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
