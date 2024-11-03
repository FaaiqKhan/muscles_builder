import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

final MusclesBuilderGame _musclesBuilderGame = MusclesBuilderGame();

class MusclesBuilderGameScreen extends StatelessWidget {
  const MusclesBuilderGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _musclesBuilderGame,
    );
  }
}
