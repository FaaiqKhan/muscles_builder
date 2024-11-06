import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';

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
        const Padding(
          padding: EdgeInsets.only(
            left: Spacings.contentSpacingOf12,
          ),
          child: Row(
            children: [
              Text("Joystick"),
              SizedBox(width: Spacings.contentSpacingOf12),
              Text("Drag")
            ],
          ),
        ),
      ],
    );
  }
}
