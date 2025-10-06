import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/cubits/hud_game_status/hud_game_status_cubit.dart';
import 'package:muscles_builder/dependencyInjection/application_di.dart';
import 'package:muscles_builder/domain/repositories/game_settings_repository.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';
import 'package:muscles_builder/screens/game_over_screen.dart';
import 'package:muscles_builder/screens/game_pause_screen.dart';
import 'package:muscles_builder/widgets/hud_game_status.dart';

class MusclesBuilderGameScreen extends StatelessWidget {
  const MusclesBuilderGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MusclesBuilderGame(
        themeData: Theme.of(context),
        gameTheme: context.musclesBuilderTheme,
        hudGameStatusCubit: context.read<HudGameStatusCubit>(),
        gameSettingsRepository: serviceLocator.get<GameSettingsRepository>(),
      ),
      overlayBuilderMap: {
        GameOverScreen.id: (_, MusclesBuilderGame gameRef) {
          return GameOverScreen(
            exitGame: () {
              gameRef.exitGame();
              Navigator.of(context).pop();
            },
            playAgain: gameRef.playAgain,
          );
        },
        GamePauseScreen.id: (_, MusclesBuilderGame gameRef) {
          return GamePauseScreen(
            gameRef: gameRef,
          );
        },
        HudGameStatusWidget.id: (_, MusclesBuilderGame gameRef) {
          return HudGameStatusWidget(
            onPause: gameRef.pauseGame,
          );
        },
      },
      initialActiveOverlays: [
        HudGameStatusWidget.id,
      ],
    );
  }
}
