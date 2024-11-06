import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';

class PlayerMovementControlWidget extends StatelessWidget {
  const PlayerMovementControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Player movement control",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: Spacings.contentSpacingOf12,
          ),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Row(
                children: PlayerControllerType.values
                    .map(
                      (controller) => TextButton(
                        onPressed: () => context
                            .read<SettingsCubit>()
                            .updatePlayerControllerType(controller),
                        child: Text(
                          controller.name,
                          style: TextStyle(
                            color: state.playerControllerType == controller
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
