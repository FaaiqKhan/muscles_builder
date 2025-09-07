import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/hud_game_status/hud_game_status_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/widgets/screen_title.dart';

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
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ScreenTitle(
                title: AppLocalizations.of(context).gameOver,
                topPadding: 0.04,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<HudGameStatusCubit, HudGameStatusState>(
                      buildWhen: (prev, curr) => prev.score != curr.score,
                      builder: (context, state) {
                        return Text(
                          "${AppLocalizations.of(context).scoreTitle}: ${state.score}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: context.musclesBuilderTheme.primaryText,
                              ),
                        );
                      },
                    ),
                    BlocBuilder<HudGameStatusCubit, HudGameStatusState>(
                      buildWhen: (prev, curr) =>
                          prev.proteinBonus != curr.proteinBonus,
                      builder: (context, state) {
                        return Text(
                          AppLocalizations.of(context)
                              .proteinBonus(state.proteinBonus),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: context.musclesBuilderTheme.primaryText,
                              ),
                        );
                      },
                    ),
                    const SizedBox(height: Spacings.contentSpacingOf32),
                    ElevatedButton(
                      onPressed: playAgain,
                      child: Text(
                        AppLocalizations.of(context).again,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                    const SizedBox(height: Spacings.contentSpacingOf12),
                    ElevatedButton(
                      onPressed: exitGame,
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
            ],
          ),
        ),
      ),
    );
  }
}
