import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/utils/ui_utils.dart';

class ExerciseTimeWidget extends StatelessWidget {
  const ExerciseTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).exerciseTime,
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
            buildWhen: (previous, current) =>
                previous.exerciseTime != current.exerciseTime,
            builder: (context, state) {
              return Row(
                children: GameExerciseTime.values
                    .map(
                      (exerciseTime) => TextButton(
                        onPressed: () => context
                            .read<SettingsCubit>()
                            .updateExerciseTime(exerciseTime),
                        child: Text(
                          exerciseTime.value,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: UiUtils.selectedAndNonSelectedText(
                                      context,
                                      state.exerciseTime == exerciseTime,
                                    ),
                                  ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
