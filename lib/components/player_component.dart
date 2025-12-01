import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:muscles_builder/components/dumbbell_component.dart';
import 'package:muscles_builder/components/animations/player_animations.dart';
import 'package:muscles_builder/components/protein_component.dart';
import 'package:muscles_builder/components/vaccine_component.dart';
import 'package:muscles_builder/components/virus_animated_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

enum Direction { up, down, left, right, upLeft, upRight, downLeft, downRight }

class Player2Component extends SpriteAnimationComponent
    with HasGameReference<MusclesBuilderGame>, CollisionCallbacks {
  Player2Component()
      : super(
          size: Vector2(90, 130),
          anchor: Anchor.center,
        );

  late PlayerAnimations _animations;

  late double _leftBounds;
  late double _topBounds;
  late double _rightBounds;
  late double _bottomBounds;
  late double _vaccinationTime;

  final double _playerMovementSpeed = 500;

  bool _vaccinated = false;
  bool _virusAttacked = false;

  double _freezeTime = 3.0;

  @override
  FutureOr<void> onLoad() async {
    final image = await game.images.load(Globals.playerHelix);

    final frameCount = image.width ~/ 80;

    final sheet = SpriteSheet(
      image: image,
      srcSize: Vector2(64, 64),
    );

    _animations = PlayerAnimations(sheet, frameCount);

    animation = _animations.down; // starting direction

    position = game.size / 2; // move player at the center of the screen

    final oneHalfOfSpriteWidth = size.x / 2;
    final oneHalfOfSpriteHeight = size.y / 1.7;

    _leftBounds = oneHalfOfSpriteWidth;
    _topBounds = oneHalfOfSpriteHeight;
    _rightBounds = game.size.x - oneHalfOfSpriteWidth;
    _bottomBounds = game.size.y - oneHalfOfSpriteHeight;

    add(RectangleHitbox());
  }

  @override
  void update(double dt) async {
    if (_vaccinated) {
      _updateVaccinationState(dt);
    }

    if (_virusAttacked) {
      animationTicker?.reset();
      return _updatePlayerFreezeState(dt);
    }

    animation = _animations.updateDirection(
      game.joystickDirection,
    );

    if (_animations.isPlayerInIdleState) {
      animationTicker?.reset();
      return;
    }

    animation?.stepTime = _animations.updateAnimationSpeed(
      game.joystickRelativeDelta,
    );

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

    if (game.joystickRelativeDelta.length != 0) {
      position += game.joystickRelativeDelta * _playerMovementSpeed * dt;
    }

    super.update(dt);
  }

  void _freezePlayer() {
    _virusAttacked = true;
    game.virusAttacked();
  }

  void _updatePlayerFreezeState(double dt) {
    _freezeTime -= dt;
    if (_freezeTime <= 0.0) {
      _freezeTime = 3.0;
      _virusAttacked = false;
      animationTicker?.reset();
    }
  }

  void _updateVaccinationState(double dt) {
    if (_vaccinationTime > 0.0) {
      _vaccinationTime -= dt;
    } else {
      _vaccinated = false;
      _vaccinationTime = game.vaccineTime;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is VirusAnimatedComponent &&
        !_vaccinated &&
        !_virusAttacked &&
        game.isWarmupCompleted) {
      _freezePlayer();
    } else if (other is VaccineComponent && !_virusAttacked) {
      other.removeFromParent();
      _vaccinated = true;
      _vaccinationTime = game.vaccineTime;
      game.showVaccineTimerBarComponent(
        _vaccinationTime,
        Vector2(30, 150),
      );
    } else if (other is ProteinComponent && !_virusAttacked) {
      other.removeFromParent();
      game.addProteinBonus();
    } else if (other is DumbbellComponent && !_virusAttacked) {
      other.removeFromParent();
      game.dumbbellPicked(other.dumbbell);
    }
    super.onCollision(intersectionPoints, other);
  }
}
