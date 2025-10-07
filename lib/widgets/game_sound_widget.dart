import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';

class GameSoundWidget extends StatelessWidget {
  const GameSoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context).gameSound,
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
              activeColor: context.musclesBuilderTheme.accentText,
              activeTrackColor: context.musclesBuilderTheme.primaryText,
              inactiveTrackColor: context.musclesBuilderTheme.unselected,
              onChanged: context.read<SettingsCubit>().updateGameSoundSwitch,
            );
          },
        )
      ],
    );
  }
}
