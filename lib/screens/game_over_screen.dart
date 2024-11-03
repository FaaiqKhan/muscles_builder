import 'package:flutter/material.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';
import 'package:muscles_builder/screens/home_screen.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key, required this.gameRef});

  static const String id = "game_over_menu_screen";
  final MusclesBuilderGame gameRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Game Over",
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
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.reset();
                  gameRef.resumeEngine();
                  gameRef.overlays.remove(GameOverScreen.id);
                },
                child: const Text(
                  "Play again",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.reset();
                  gameRef.resumeEngine();
                  gameRef.overlays.remove(GameOverScreen.id);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Main menu",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
