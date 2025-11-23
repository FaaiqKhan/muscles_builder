import 'package:flame/sprite.dart';

class PlayerAnimations {
  late final SpriteAnimation up;
  late final SpriteAnimation upRight;
  late final SpriteAnimation right;
  late final SpriteAnimation downRight;
  late final SpriteAnimation down;
  late final SpriteAnimation downLeft;
  late final SpriteAnimation left;
  late final SpriteAnimation upLeft;

  PlayerAnimations(SpriteSheet sheet, int frameCount) {
    const stepTime = 0.1;

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
}
