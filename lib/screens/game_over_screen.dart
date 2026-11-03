import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/hud_game_status/hud_game_status_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/widgets/ads/google_interstitial_ad_widget.dart';
import 'package:muscles_builder/widgets/screen_title_widget.dart';

class GameOverScreen extends StatelessWidget {
  static const String id = "game_over_menu_screen";

  final VoidCallback exitGame;
  final VoidCallback playAgain;

  const GameOverScreen({
    required this.exitGame,
    required this.playAgain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.musclesBuilderTheme.background,
      body: Stack(
        children: [
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Spacings.contentSpacingOf32),
                    child: ScreenTitleWidget(
                      title: AppLocalizations.of(context).gameOver,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocBuilder<HudGameStatusCubit, HudGameStatusState>(
                          buildWhen: (prev, curr) =>
                              prev.score != curr.score ||
                              prev.proteinBonus != curr.proteinBonus,
                          builder: (context, state) {
                            final int total = state.score + state.proteinBonus;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _StatLine(
                                  label:
                                      "${AppLocalizations.of(context).total}: ",
                                  value: "$total",
                                ),
                                _StatLine(
                                  label:
                                      "${AppLocalizations.of(context).scoreTitle}: ",
                                  value: "${state.score}",
                                ),
                                _StatLine.localized(
                                  AppLocalizations.of(context)
                                      .proteinBonus(state.proteinBonus),
                                  "${state.proteinBonus}",
                                ),
                              ],
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: Spacings.contentSpacingOf32,
                            bottom: Spacings.contentSpacingOf12,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ElevatedButton(
                              onPressed: playAgain,
                              child: Text(AppLocalizations.of(context).again),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: OutlinedButton(
                            onPressed: exitGame,
                            child: Text(AppLocalizations.of(context).imTired),
                          ),
                        ),
                      ],
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

/// A "Label: 12" line where the number is set in the monospace stat font.
class _StatLine extends StatelessWidget {
  const _StatLine({required this.label, required this.value});

  /// Splits an already-localized sentence around the trailing [value].
  factory _StatLine.localized(String text, String value) {
    final idx = text.lastIndexOf(value);
    if (idx < 0) return _StatLine(label: text, value: '');
    return _StatLine(label: text.substring(0, idx), value: value);
  }

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: context.musclesBuilderTheme.primaryText,
      fontSize: 18,
      height: 1.6,
    );
    return Text.rich(
      TextSpan(
        text: label,
        style: base,
        children: [
          TextSpan(
            text: value,
            style: base?.copyWith(
              fontFamily: "JetBrains Mono",
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
