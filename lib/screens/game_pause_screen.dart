import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';

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
                  AppLocalizations.of(context).gamePaused,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = context.musclesBuilderTheme.primaryText),
                  textAlign: TextAlign.center,
                ),
                // Solid text as fill.
                Text(
                  AppLocalizations.of(context).gamePaused,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: context.musclesBuilderTheme.accentText,
                      ),
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
                AppLocalizations.of(context).backToGym,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
            const SizedBox(height: Spacings.contentSpacingOf12),
            ElevatedButton(
              onPressed: () {
                context.read<GoogleAdsCubit>().showInterstitialAd(() {
                  gameRef.reset();
                  gameRef.resumeEngine();
                  gameRef.overlays.remove(GamePauseScreen.id);
                  Navigator.of(context).pop();
                });
              },
              child: Text(
                AppLocalizations.of(context).imTired,
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
