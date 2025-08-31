import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class GamePauseScreen extends StatelessWidget {
  const GamePauseScreen({super.key, required this.gameRef});

  static const String id = "game_pause_screen";
  final MusclesBuilderGame gameRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.musclesBuilderTheme.background,
      body: AlertDialog(
        backgroundColor: context.musclesBuilderTheme.dialogBoxSurface,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: <Widget>[
                // Stroked text as border.
                Text(
                  "Game\nPaused",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = context
                            .musclesBuilderTheme.primaryText),
                  textAlign: TextAlign.center,
                ),
                // Solid text as fill.
                Text(
                  "Game\nPaused",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(
                      color: context
                          .musclesBuilderTheme.accentText),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: Spacings.contentSpacingOf32),
            ElevatedButton(
              onPressed: () {
                gameRef.resumeEngine();
                gameRef.overlays.remove(GamePauseScreen.id);
              },
              child: Text(
                "Back to Gym",
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
                gameRef.overlays.remove(GamePauseScreen.id);
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
    );
  }
}
