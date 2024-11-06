import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';

class ExerciseTimeWidget extends StatelessWidget {
  const ExerciseTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Exercise time",
          style: Theme.of(context).textTheme.headlineLarge,
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
                children: ExerciseTime.values
                    .map(
                      (exerciseTime) => TextButton(
                        onPressed: () => context
                            .read<SettingsCubit>()
                            .updateExerciseTime(exerciseTime),
                        child: Text(
                          exerciseTime.value,
                          style: TextStyle(
                            color: state.exerciseTime == exerciseTime
                                ? Colors.amber
                                : Colors.black,
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
