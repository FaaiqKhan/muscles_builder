import 'package:flutter/material.dart';
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "I'm tired",
              style: TextStyle(fontSize: 50),
            ),
            Text(
              "Score: ${gameRef.score}",
              style: const TextStyle(fontSize: 50),
            ),
            Text(
              "(Protein Bonus: ${gameRef.proteinBonus})",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 200,
            ),
            ElevatedButton(
              onPressed: () {
                gameRef.reset();
                gameRef.resumeEngine();
                gameRef.overlays.remove(GameOverScreen.id);
              },
              child: const Text("Again"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                gameRef.reset();
                gameRef.resumeEngine();
                gameRef.overlays.remove(GameOverScreen.id);
                Navigator.of(context).pop();
              },
              child: const Text("Home"),
            )
          ],
        ),
      ),
    );
  }
}
