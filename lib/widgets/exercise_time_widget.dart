import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';

class ExerciseTimeWidget extends StatefulWidget {
  const ExerciseTimeWidget({super.key});

  @override
  State<ExerciseTimeWidget> createState() => _ExerciseTimeWidgetState();
}

class _ExerciseTimeWidgetState extends State<ExerciseTimeWidget> {
  final Map<String, int> exerciseTime = {
    "3 minutes": 3,
    "5 minutes": 5,
    "8 minutes": 8,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Exercise time",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: Spacings.contentSpacingOf12,
          ),
          child: Row(
            children: exerciseTime.keys
                .map(
                  (key) => TextButton(
                    onPressed: () {},
                    child: Text(key),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
