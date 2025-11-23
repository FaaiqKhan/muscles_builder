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
    size = Vector2(90, 130); // exact game size
  }

  @override
  void update(double dt) async {
    super.update(dt);

    animation = _animations.updateDirection(
      game.joystickDirection,
    );

    if (game.joystickDirection == JoystickDirection.idle) {
      animationTicker?.reset();
      return;
    }

    animation?.stepTime = _animations.updateAnimationSpeed(
      game.joystickRelativeDelta,
    );

    if (game.joystickRelativeDelta.length != 0) {
      position += game.joystickRelativeDelta * _playerMovementSpeed * dt;
    }
  }
}
