import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/theme/theme_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/utils/ui_utils.dart';

class AppThemeSelectionWidget extends StatelessWidget {
  const AppThemeSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).applicationTheme,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: context.musclesBuilderTheme.primaryText),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: Spacings.contentSpacingOf12,
          ),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            buildWhen: (previous, current) =>
                previous.themeMode != current.themeMode,
            builder: (context, state) {
              return Row(
                children: ThemeMode.values
                    .map(
                      (mode) => TextButton(
                        onPressed: () =>
                            context.read<ThemeCubit>().setThemeMode(mode),
                        child: Text(
                          mode.name,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: UiUtils.selectedAndNonSelectedText(
                                      context,
                                      state.themeMode == mode,
                                    ),
                                  ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        )
      ],
    );
  }
}
