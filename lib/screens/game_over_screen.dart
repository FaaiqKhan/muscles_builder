import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/widgets/screen_title.dart';

class GameOverScreen extends StatelessWidget {
  static const String id = "game_over_menu_screen";

  final int score;
  final int proteinBonus;

  final VoidCallback exitGame;
  final VoidCallback playAgain;

  const GameOverScreen({
    required this.score,
    required this.proteinBonus,
    required this.exitGame,
    required this.playAgain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.musclesBuilderTheme.background,
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
                      "Score: $score",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: context.musclesBuilderTheme.primaryText),
                    ),
                    Text(
                      "(Protein Bonus: $proteinBonus)",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: context.musclesBuilderTheme.primaryText),
                    ),
                    const SizedBox(height: Spacings.contentSpacingOf32),
                    ElevatedButton(
                      onPressed: playAgain,
                      child: Text(
                        "Again",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                    const SizedBox(height: Spacings.contentSpacingOf12),
                    ElevatedButton(
                      onPressed: exitGame,
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
