import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/utils/ui_utils.dart';

class JoystickPositionWidget extends StatelessWidget {
  const JoystickPositionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Joystick position",
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
            builder: (context, state) {
              return Row(
                children: JoystickPosition.values
                    .map(
                      (controller) => TextButton(
                        onPressed: () => context
                            .read<SettingsCubit>()
                            .updatePlayerControllerType(controller),
                        child: Text(
                          controller.name,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: UiUtils.selectedAndNonSelectedText(
                                      context,
                                      state.joystickPosition == controller,
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
