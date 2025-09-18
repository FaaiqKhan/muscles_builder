import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:muscles_builder/components/dumbbell_component.dart';
import 'package:muscles_builder/components/protein_component.dart';
import 'package:muscles_builder/components/vaccine_component.dart';
import 'package:muscles_builder/components/virus_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class PlayerComponent extends SpriteComponent
    with HasGameReference<MusclesBuilderGame>, CollisionCallbacks {
  PlayerComponent({required bool isGameSoundOn})
      : _isGameSoundOn = isGameSoundOn,
        super(
          size: Vector2(80, 100),
          anchor: Anchor.center,
        );

  final bool _isGameSoundOn;

  final double _playerMovementSpeed = 500;

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
    playerFit = await game.loadSprite(Globals.playerFitSprite);
    playerFever = await game.loadSprite(Globals.playerFeverSprite);
    playerSkinny = await game.loadSprite(Globals.playerSkinnySprite);
    playerMuscular = await game.loadSprite(Globals.playerMuscularSprite);

    playerSprite();
    position = game.size / 2;

    final oneHalfOfSpriteWidth = size.x / 2;
    final oneHalfOfSpriteHeight = size.y / 1.7;

    _leftBounds = oneHalfOfSpriteWidth;
    _topBounds = oneHalfOfSpriteHeight;
    _rightBounds = game.size.x - oneHalfOfSpriteWidth;
    _bottomBounds = game.size.y - oneHalfOfSpriteHeight;

    // Main body polygon (torso & legs)
    add(
      PolygonHitbox([
        Vector2(size.x * 0.25, size.y * 0.25), // left shoulder
        Vector2(size.x * 0.75, size.y * 0.25), // right shoulder
        Vector2(size.x * 0.65, size.y * 0.9),  // right leg
        Vector2(size.x * 0.35, size.y * 0.9),  // left leg
      ])
        ..collisionType = CollisionType.passive,
    );

    // Head circle
    add(
      CircleHitbox.relative(
        0.15, // radius relative to size
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.1),
      )..collisionType = CollisionType.passive,
    );
  }

  @override
  void update(double dt) {
    if (_vaccinated) {
      _updateVaccinationState(dt);
    }
    if (_virusAttacked) {
      return _updatePlayerFreezeState(dt);
    }
    if (game.joystickDirection == JoystickDirection.idle) {
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
    position.add(game.joystickRelativeDelta * _playerMovementSpeed * dt);
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
      game.increaseProteinBonusBy(randomBonusScore);
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
