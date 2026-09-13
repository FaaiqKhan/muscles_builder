import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/widgets/settings_option_pill_row.dart';

class JoystickPositionWidget extends StatelessWidget {
  const JoystickPositionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SettingsOptionPillRow<JoystickPosition>(
          label: AppLocalizations.of(context).joystickPosition,
          options: JoystickPosition.values,
          selected: state.joystickPosition,
          labelBuilder: (option) => option.name,
          onSelect: (option) =>
              context.read<SettingsCubit>().updatePlayerControllerType(option),
        );
      },
    );
  }
}
