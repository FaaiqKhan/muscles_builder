import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';
import 'package:muscles_builder/screens/game_over_screen.dart';
import 'package:muscles_builder/screens/game_pause_screen.dart';

class MusclesBuilderGameScreen extends StatelessWidget {
  const MusclesBuilderGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MusclesBuilderGame(),
      overlayBuilderMap: {
        GameOverScreen.id: (BuildContext context, MusclesBuilderGame gameRef) {
          return GameOverScreen(
            gameRef: gameRef,
          );
        },
        GamePauseScreen.id: (BuildContext context, MusclesBuilderGame gameRef) {
          return GamePauseScreen(
            gameRef: gameRef,
          );
        },
      },
    );
  }
}
