import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';
import 'package:muscles_builder/widgets/screen_title.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key, required this.gameRef});

  static const String id = "game_over_menu_screen";
  final MusclesBuilderGame gameRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const ScreenTitle(
                title: "Game Over",
                topPadding: 0.04,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Score: ${gameRef.score}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    Text(
                      "(Protein Bonus: ${gameRef.proteinBonus})",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    const SizedBox(height: Spacings.contentSpacingOf32),
                    ElevatedButton(
                      onPressed: () {
                        gameRef.reset();
                        gameRef.resumeEngine();
                        gameRef.overlays.remove(GameOverScreen.id);
                      },
                      child: Text(
                        "Again",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                    const SizedBox(height: Spacings.contentSpacingOf12),
                    ElevatedButton(
                      onPressed: () {
                        gameRef.reset();
                        gameRef.resumeEngine();
                        gameRef.overlays.remove(GameOverScreen.id);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "I'm tired",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
