import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/widgets/settings_option_pill_row.dart';

class WarmupTimeWidget extends StatelessWidget {
  const WarmupTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) =>
          previous.warmupTime != current.warmupTime,
      builder: (context, state) {
        return SettingsOptionPillRow<WarmupTime>(
          label: AppLocalizations.of(context).warmupTime,
          options: WarmupTime.values,
          selected: state.warmupTime,
          labelBuilder: (option) => option.value,
          onSelect: (option) =>
              context.read<SettingsCubit>().updateWarmupTime(option),
        );
      },
    );
  }
}
