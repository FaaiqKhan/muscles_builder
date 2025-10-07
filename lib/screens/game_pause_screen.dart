import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/widgets/ads/google_interstitial_ad_widget.dart';

class GamePauseScreen extends StatelessWidget {
  const GamePauseScreen({
    super.key,
    required this.backToGym,
    required this.iMTired,
  });

  static const String id = "game_pause_screen";

  final VoidCallback backToGym;
  final VoidCallback iMTired;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.musclesBuilderTheme.background,
      body: Stack(
        children: [
          AlertDialog(
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
                  onPressed: backToGym,
                  child: Text(
                    AppLocalizations.of(context).backToGym,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                const SizedBox(height: Spacings.contentSpacingOf12),
                ElevatedButton(
                  onPressed: iMTired,
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
          GoogleInterstitialAdWidget(
            key: UniqueKey(),
          ),
        ],
      ),
    );
  }
}
