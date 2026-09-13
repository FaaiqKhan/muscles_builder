import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/widgets/settings_option_pill_row.dart';

class ExerciseTimeWidget extends StatelessWidget {
  const ExerciseTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) =>
          previous.exerciseTime != current.exerciseTime,
      builder: (context, state) {
        return SettingsOptionPillRow<GameExerciseTime>(
          label: AppLocalizations.of(context).exerciseTime,
          options: GameExerciseTime.values,
          selected: state.exerciseTime,
          labelBuilder: (option) => option.value,
          onSelect: (option) =>
              context.read<SettingsCubit>().updateExerciseTime(option),
        );
      },
    );
  }
}
