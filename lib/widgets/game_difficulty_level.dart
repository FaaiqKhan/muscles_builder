import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/widgets/settings_option_pill_row.dart';

class GameDifficultyLevelWidget extends StatelessWidget {
  const GameDifficultyLevelWidget({super.key});

  String _label(BuildContext context, GameDifficulty difficulty) {
    switch (difficulty) {
      case GameDifficulty.easy:
        return AppLocalizations.of(context).easy;
      case GameDifficulty.medium:
        return AppLocalizations.of(context).medium;
      case GameDifficulty.hard:
        return AppLocalizations.of(context).hard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SettingsOptionPillRow<GameDifficulty>(
          label: AppLocalizations.of(context).difficultyLevel,
          options: GameDifficulty.values,
          selected: state.gameDifficultyLevel,
          labelBuilder: (option) => _label(context, option),
          onSelect: (option) =>
              context.read<SettingsCubit>().updateGameDifficultyLevel(option),
        );
      },
    );
  }
}
