import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';
import 'package:muscles_builder/screens/game_pause_screen.dart';

class PauseButtonComponent extends SpriteComponent
    with HasGameRef<MusclesBuilderGame>, TapCallbacks {
  void pauseGame() {
    gameRef.pauseEngine();
    gameRef.timer.pause();
    gameRef.vaccineTimer.pause();
    gameRef.proteinTimer.pause();
    gameRef.overlays.add(GamePauseScreen.id);
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await gameRef.loadSprite(Globals.pauseButtonSprite);
    size = Vector2.all(44);
    anchor = Anchor.topRight;
    position = Vector2(
      gameRef.size.x - Spacings.contentSpacingOf12,
      gameRef.size.y * 0.01,
    );
    return await super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    pauseGame();
    super.onTapDown(event);
  }
}
