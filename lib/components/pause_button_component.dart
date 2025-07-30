import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';
import 'package:muscles_builder/screens/game_pause_screen.dart';

class PauseButtonComponent extends SpriteComponent
    with HasGameReference<MusclesBuilderGame>, TapCallbacks {
  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite(Globals.pauseButtonSprite);
    return await super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    pauseGame();
    super.onTapDown(event);
  }

  void pauseGame() {
    game.pauseEngine();
    if (game.vaccineTimer.isRunning()) {
      game.vaccineTimer.pause();
    }
    game.overlays.add(GamePauseScreen.id);
  }
}
