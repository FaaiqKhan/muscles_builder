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
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.78,
              constraints: const BoxConstraints(maxWidth: 290),
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
              decoration: BoxDecoration(
                color: context.musclesBuilderTheme.background,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: context.musclesBuilderTheme.border),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x29181A20),
                    blurRadius: 32,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).gamePaused,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: context.musclesBuilderTheme.primaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Spacings.contentSpacingOf24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: backToGym,
                      child: Text(AppLocalizations.of(context).backToGym),
                    ),
                  ),
                  const SizedBox(height: Spacings.contentSpacingOf12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: iMTired,
                      child: Text(AppLocalizations.of(context).imTired),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GoogleInterstitialAdWidget(key: UniqueKey()),
        ],
      ),
    );
  }
}
