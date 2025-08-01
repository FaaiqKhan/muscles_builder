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
  PlayerComponent({required this.joystick, required bool isGameSoundOn})
      : _isGameSoundOn = isGameSoundOn,
        super();

  final bool _isGameSoundOn;

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

  bool _vaccinated = false;
  bool _virusAttacked = false;

  double _freezeTime = 3.0;
  double _vaccinationTime = 5.0;

  late double oneHalfOfSpriteWidth;
  late double oneHalfOfSpriteHeight;

  void _freezePlayer() {
    if (_isGameSoundOn) {
      FlameAudio.play(Globals.virusSound);
    }
    _virusAttacked = true;
    game.decreaseScoreBy(1);
    playerSprite();
  }

  void playerSprite() {
    if (_virusAttacked) {
      sprite = playerFever;
    } else if (game.gameScore > 10 && game.gameScore <= 20) {
      sprite = playerFit;
    } else if (game.gameScore > 20) {
      sprite = playerMuscular;
    } else {
      sprite = playerSkinny;
    }
  }

  void _updatePlayerFreezeState(double dt) {
    _freezeTime -= dt;
    if (_freezeTime <= 0.0) {
      _freezeTime = 3.0;
      _virusAttacked = false;
      playerSprite();
    }
  }

  void _updateVaccinationState(double dt) {
    if (_vaccinationTime > 0.0) {
      _vaccinationTime -= dt;
    } else {
      _vaccinated = false;
      _vaccinationTime = 5.0;
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
    if (_vaccinated) {
      _updateVaccinationState(dt);
    }
    if (_virusAttacked) {
      return _updatePlayerFreezeState(dt);
    }
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
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is VirusComponent &&
        !_vaccinated &&
        !_virusAttacked &&
        game.isWarmupCompleted) {
      _freezePlayer();
    } else if (other is VaccineComponent && !_virusAttacked) {
      other.removeFromParent();
      _vaccinated = true;
      _vaccinationTime = 5.0;
      if (_isGameSoundOn) {
        FlameAudio.play(Globals.vaccineSound);
      }
    } else if (other is ProteinComponent && !_virusAttacked) {
      other.removeFromParent();
      // Generate number from 0 to 8
      int randomBonusScore = game.random.nextInt(9);
      game.proteinBonus = randomBonusScore;
      game.increaseScoreBy(randomBonusScore);
      if (_isGameSoundOn) {
        FlameAudio.play(Globals.proteinSound);
      }
    } else if (other is DumbbellComponent && !_virusAttacked) {
      if (_isGameSoundOn) {
        FlameAudio.play(Globals.dumbbellSound);
      }
      other.removeFromParent();
      switch (other.dumbbell) {
        case Globals.dumbbellMediumSprite:
          game.increaseScoreBy(2);
          break;
        case Globals.dumbbellHeavySprite:
          game.increaseScoreBy(3);
          break;
        default:
          game.increaseScoreBy(1);
      }
      game.add(DumbbellComponent());
    }
  }

  void reset() {
    sprite = playerSkinny;
  }
}
