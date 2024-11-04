import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/spacings.dart';

class DifficultyLevel extends StatefulWidget {
  const DifficultyLevel({super.key});

  @override
  State<StatefulWidget> createState() => _DifficultyLevelState();
}

class _DifficultyLevelState extends State<DifficultyLevel> {
  GameDifficultyLevel gameDifficultyLevel = GameDifficultyLevel.hard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Difficulty level",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: Spacings.contentSpacingOf12,
          ),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    gameDifficultyLevel = GameDifficultyLevel.easy;
                  });
                },
                child: Text(
                  "Easy",
                  style: TextStyle(
                    color: gameDifficultyLevel == GameDifficultyLevel.easy
                        ? Colors.amber
                        : Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    gameDifficultyLevel = GameDifficultyLevel.medium;
                  });
                },
                child: Text(
                  "Medium",
                  style: TextStyle(
                    color: gameDifficultyLevel == GameDifficultyLevel.medium
                        ? Colors.amber
                        : Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    gameDifficultyLevel = GameDifficultyLevel.hard;
                  });
                },
                child: Text(
                  "Hard",
                  style: TextStyle(
                    color: gameDifficultyLevel == GameDifficultyLevel.hard
                        ? Colors.amber
                        : Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
