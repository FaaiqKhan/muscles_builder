import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key, required this.gameRef});

  static const String id = "game_over_menu_screen";
  final MusclesBuilderGame gameRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Over"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Score: ${gameRef.score}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              "(Protein Bonus: ${gameRef.proteinBonus})",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: Spacings.contentSpacingOf32,
            ),
            ElevatedButton(
              onPressed: () {
                gameRef.reset();
                gameRef.resumeEngine();
                gameRef.overlays.remove(GameOverScreen.id);
              },
              child: Text(
                "Again",
                style: Theme.of(context).textTheme.labelSmall,
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
                style: Theme.of(context).textTheme.labelSmall,
              ),
            )
          ],
        ),
      ),
    );
  }
}
