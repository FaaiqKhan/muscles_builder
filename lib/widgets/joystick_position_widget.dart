import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';

class JoystickPositionWidget extends StatelessWidget {
  const JoystickPositionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Joystick position",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
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
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: state.joystickPosition == controller
                                ? Theme.of(context).colorScheme.onPrimaryFixed
                                : Theme.of(context).colorScheme.onPrimary,
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
