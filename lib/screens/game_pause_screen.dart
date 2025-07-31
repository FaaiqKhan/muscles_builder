import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class GamePauseScreen extends StatelessWidget {
  const GamePauseScreen({super.key, required this.gameRef});

  static const String id = "game_pause_screen";
  final MusclesBuilderGame gameRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withAlpha(128),
      body: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Game\npaused",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: Spacings.contentSpacingOf32),
            ElevatedButton(
              onPressed: () {
                gameRef.resumeEngine();
                gameRef.overlays.remove(GamePauseScreen.id);
              },
              child: const Text("Back to Gym"),
            ),
            const SizedBox(height: Spacings.contentSpacingOf12),
            ElevatedButton(
              onPressed: () {
                gameRef.reset();
                gameRef.resumeEngine();
                gameRef.overlays.remove(GamePauseScreen.id);
                Navigator.of(context).pop();
              },
              child: const Text("I'm tired"),
            ),
          ],
        ),
      ),
    );
  }
}
