import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';

class GameSoundWidget extends StatelessWidget {
  const GameSoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Game sound",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: context.musclesBuilderTheme.primaryText),
        ),
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (previous, current) =>
              previous.gameSoundSwitch != current.gameSoundSwitch,
          builder: (context, state) {
            return Switch(
              value: state.gameSoundSwitch,
              activeColor: context.musclesBuilderTheme.primaryText,
              inactiveTrackColor:
                  context.musclesBuilderTheme.primaryText.withAlpha(120),
              onChanged: context.read<SettingsCubit>().updateGameSoundSwitch,
            );
          },
        )
      ],
    );
  }
}
