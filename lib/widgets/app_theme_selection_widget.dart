import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/cubits/theme/theme_cubit.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/widgets/settings_option_pill_row.dart';

class AppThemeSelectionWidget extends StatelessWidget {
  const AppThemeSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) =>
          previous.themeMode != current.themeMode,
      builder: (context, state) {
        return SettingsOptionPillRow<ThemeMode>(
          label: AppLocalizations.of(context).applicationTheme,
          options: ThemeMode.values,
          selected: state.themeMode,
          labelBuilder: (option) => option.name,
          onSelect: (option) => context.read<ThemeCubit>().setThemeMode(option),
        );
      },
    );
  }
}
