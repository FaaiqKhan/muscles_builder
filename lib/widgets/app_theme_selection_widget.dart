import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/theme/theme_cubit.dart';

class AppThemeSelectionWidget extends StatelessWidget {
  const AppThemeSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Application theme",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: state.themeMode == mode
                                    ? Colors.amber
                                    : Theme.of(context).colorScheme.tertiary,
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
