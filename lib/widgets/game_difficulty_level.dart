import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/utils/ui_utils.dart';

class GameDifficultyLevelWidget extends StatelessWidget {
  const GameDifficultyLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).difficultyLevel,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: context.musclesBuilderTheme.primaryText),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: Spacings.contentSpacingOf12,
          ),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Row(
                children: [
                  TextButton(
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .updateGameDifficultyLevel(GameDifficultyLevel.easy),
                    child: Text(
                      AppLocalizations.of(context).easy,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: UiUtils.selectedAndNonSelectedText(
                              context,
                              state.gameDifficultyLevel ==
                                  GameDifficultyLevel.easy,
                            ),
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .updateGameDifficultyLevel(GameDifficultyLevel.medium),
                    child: Text(
                      AppLocalizations.of(context).medium,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: UiUtils.selectedAndNonSelectedText(
                              context,
                              state.gameDifficultyLevel ==
                                  GameDifficultyLevel.medium,
                            ),
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .updateGameDifficultyLevel(GameDifficultyLevel.hard),
                    child: Text(
                      AppLocalizations.of(context).hard,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: UiUtils.selectedAndNonSelectedText(
                              context,
                              state.gameDifficultyLevel ==
                                  GameDifficultyLevel.hard,
                            ),
                          ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
