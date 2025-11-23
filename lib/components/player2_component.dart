import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:muscles_builder/components/player_animations.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class Player2Component extends SpriteAnimationComponent
    with HasGameReference<MusclesBuilderGame> {
  late PlayerAnimations animations;

  final double _playerMovementSpeed = 500;

  @override
  FutureOr<void> onLoad() async {
    final image = await game.images.load(Globals.playerHelix);

    final frameCount = image.width ~/ 64;

    final sheet = SpriteSheet(
      image: image,
      srcSize: Vector2(64, 64),
    );

    animations = PlayerAnimations(sheet, frameCount);

    animation = animations.down; // starting direction
    size = Vector2(64, 64); // exact game size
  }

  void updateDirection(Vector2 move) {
    if (move == Vector2.zero()) {
      animationTicker?.reset();
      return;
    }

    final angle = move.angleToSigned(Vector2(0, -1));
    final degrees = angle * 180 / pi;

    if (degrees > -80.0 && degrees < -10.0) {
      animation = animations.upRight;
    } else if (degrees >= -100.0 && degrees <= -80.0) {
      animation = animations.right;
    } else if (degrees > -170.0 && degrees < -100.0) {
      animation = animations.downRight;
    } else if (degrees >= -180.0 && degrees <= -170.0) {
      animation = animations.down;
    } else if (degrees >= 170.0 && degrees <= 180.0) {
      animation = animations.down;
    } else if (degrees < 170.0 && degrees >= 100.0) {
      animation = animations.downLeft;
    } else if (degrees < 100.0 && degrees >= 80.0) {
      animation = animations.left;
    } else if (degrees < 80.0 && degrees >= 10.0) {
      animation = animations.upLeft;
    } else {
      animation = animations.up;
    }
  }

  @override
  void update(double dt) async {
    super.update(dt);

    if (game.joystickDirection == JoystickDirection.idle) {
      return;
    }

    final move = game.joystickRelativeDelta;

    updateDirection(move);

    if (move.length != 0) {
      position += move * _playerMovementSpeed * dt;
    }
  }
}
