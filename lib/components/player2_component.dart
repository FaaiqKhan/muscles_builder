import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:muscles_builder/components/player_animations.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

enum Direction { up, down, left, right, upLeft, upRight, downLeft, downRight }

class Player2Component extends SpriteAnimationComponent
    with HasGameReference<MusclesBuilderGame> {
  late PlayerAnimations _animations;
  late Direction _currentPlayerDirection;

  final double _playerMovementSpeed = 500;

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
    _currentPlayerDirection = Direction.down;
    size = Vector2(90, 130); // exact game size
  }

  void updateDirection(JoystickDirection direction) {
    switch (direction) {
      case JoystickDirection.up:
        animation = _animations.up;
        _currentPlayerDirection = Direction.up;
        break;
      case JoystickDirection.upLeft:
        animation = _animations.upLeft;
        _currentPlayerDirection = Direction.upLeft;
        break;
      case JoystickDirection.upRight:
        animation = _animations.upRight;
        _currentPlayerDirection = Direction.upRight;
        break;
      case JoystickDirection.right:
        animation = _animations.right;
        _currentPlayerDirection = Direction.right;
        break;
      case JoystickDirection.down:
        animation = _animations.down;
        _currentPlayerDirection = Direction.down;
        break;
      case JoystickDirection.downRight:
        animation = _animations.downRight;
        _currentPlayerDirection = Direction.downRight;
        break;
      case JoystickDirection.downLeft:
        animation = _animations.downLeft;
        _currentPlayerDirection = Direction.downLeft;
        break;
      case JoystickDirection.left:
        animation = _animations.left;
        _currentPlayerDirection = Direction.left;
        break;
      case JoystickDirection.idle:
        idleAnimation(_currentPlayerDirection);
        animationTicker?.reset();
        break;
    }
  }

  void idleAnimation(Direction direction) {
    switch (direction) {
      case Direction.up:
        animation = _animations.idleUp;
        break;
      case Direction.down:
        animation = _animations.idleDown;
        break;
      case Direction.left:
        animation = _animations.idleLeft;
        break;
      case Direction.right:
        animation = _animations.idleRight;
        break;
      case Direction.upLeft:
        animation = _animations.idleUpLeft;
        break;
      case Direction.upRight:
        animation = _animations.idleUpRight;
        break;
      case Direction.downLeft:
        animation = _animations.idleDownLeft;
        break;
      case Direction.downRight:
        animation = _animations.idleDownRight;
        break;
    }
  }

  @override
  void update(double dt) async {
    super.update(dt);

    updateDirection(game.joystickDirection);

    if (game.joystickRelativeDelta.length != 0) {
      position += game.joystickRelativeDelta * _playerMovementSpeed * dt;
    }
  }
}
