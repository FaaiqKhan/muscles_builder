import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:muscles_builder/components/player2_component.dart';

class PlayerAnimations {
  late final SpriteAnimation idleUp;
  late final SpriteAnimation idleUpRight;
  late final SpriteAnimation idleRight;
  late final SpriteAnimation idleDownRight;
  late final SpriteAnimation idleDown;
  late final SpriteAnimation idleDownLeft;
  late final SpriteAnimation idleLeft;
  late final SpriteAnimation idleUpLeft;
  late final SpriteAnimation up;
  late final SpriteAnimation upRight;
  late final SpriteAnimation right;
  late final SpriteAnimation downRight;
  late final SpriteAnimation down;
  late final SpriteAnimation downLeft;
  late final SpriteAnimation left;
  late final SpriteAnimation upLeft;

  Direction _currentPlayerDirection = Direction.down;

  PlayerAnimations(SpriteSheet sheet, int frameCount) {
    const stepTime = 0.1;

    idleDownLeft = sheet.createAnimation(
      row: 0,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    idleDown = sheet.createAnimation(
      row: 1,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    idleDownRight = sheet.createAnimation(
      row: 2,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    idleRight = sheet.createAnimation(
      row: 3,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    idleUpRight = sheet.createAnimation(
      row: 4,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    idleUp = sheet.createAnimation(
      row: 5,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    idleUpLeft = sheet.createAnimation(
      row: 6,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    idleLeft = sheet.createAnimation(
      row: 7,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    downLeft = sheet.createAnimation(
      row: 8,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    down = sheet.createAnimation(
      row: 9,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    downRight = sheet.createAnimation(
      row: 10,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    right = sheet.createAnimation(
      row: 11,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    upRight = sheet.createAnimation(
      row: 12,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    up = sheet.createAnimation(
      row: 13,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    upLeft = sheet.createAnimation(
      row: 14,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
    left = sheet.createAnimation(
      row: 15,
      stepTime: stepTime,
      from: 0,
      to: frameCount - 1,
    );
  }

  SpriteAnimation updateDirection(JoystickDirection direction) {
    switch (direction) {
      case JoystickDirection.up:
        _currentPlayerDirection = Direction.up;
        return up;
      case JoystickDirection.upLeft:
        _currentPlayerDirection = Direction.upLeft;
        return upLeft;
      case JoystickDirection.upRight:
        _currentPlayerDirection = Direction.upRight;
        return upRight;
      case JoystickDirection.right:
        _currentPlayerDirection = Direction.right;
        return right;
      case JoystickDirection.down:
        _currentPlayerDirection = Direction.down;
        return down;
      case JoystickDirection.downRight:
        _currentPlayerDirection = Direction.downRight;
        return downRight;
      case JoystickDirection.downLeft:
        _currentPlayerDirection = Direction.downLeft;
        return downLeft;
      case JoystickDirection.left:
        _currentPlayerDirection = Direction.left;
        return left;
      case JoystickDirection.idle:
        return idleAnimation(_currentPlayerDirection);
    }
  }

  SpriteAnimation idleAnimation(Direction direction) {
    switch (direction) {
      case Direction.up:
        return idleUp;
      case Direction.down:
        return idleDown;
      case Direction.left:
        return idleLeft;
      case Direction.right:
        return idleRight;
      case Direction.upLeft:
        return idleUpLeft;
      case Direction.upRight:
        return idleUpRight;
      case Direction.downLeft:
        return idleDownLeft;
      case Direction.downRight:
        return idleDownRight;
    }
  }

  double updateAnimationSpeed(Vector2 move) {
    final speed = move.length;

    // Define the animation speed range
    const minStep = 0.05; // very fast (running)
    const maxStep = 0.20; // very slow (barely moving)

    if (speed == 0) {
      return 0.1; // Idle animations should be slower or fixed
    }

    // Normalize joystick speed (0 → 1)
    final normalized = (speed / 1.0).clamp(0.0, 1.0);

    // Inverse mapping: faster speed → lower stepTime
    return maxStep - (normalized * (maxStep - minStep));
  }
}
