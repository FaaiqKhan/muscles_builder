import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';

class GameDifficultyLevelWidget extends StatelessWidget {
  const GameDifficultyLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Difficulty level",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
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
                      "Easy",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: state.gameDifficultyLevel ==
                                    GameDifficultyLevel.easy
                                ? Colors.amber
                                : Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .updateGameDifficultyLevel(GameDifficultyLevel.medium),
                    child: Text(
                      "Medium",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: state.gameDifficultyLevel ==
                            GameDifficultyLevel.medium
                            ? Colors.amber
                            : Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .updateGameDifficultyLevel(GameDifficultyLevel.hard),
                    child: Text(
                      "Hard",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: state.gameDifficultyLevel ==
                            GameDifficultyLevel.hard
                            ? Colors.amber
                            : Theme.of(context).colorScheme.tertiary,
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
