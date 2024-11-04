import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO: Set properties of games according to game difficulty

class DifficultyLevel extends StatefulWidget {
  const DifficultyLevel({super.key});

  @override
  State<StatefulWidget> createState() => _DifficultyLevelState();
}

class _DifficultyLevelState extends State<DifficultyLevel> {
  GameDifficultyLevel gameDifficultyLevel = GameDifficultyLevel.easy;

  @override
  void initState() {
    SharedPreferences.getInstance().then(
      (instance) {
        setState(() {
          final level = instance.getString(
            KeyValueStorageKeys.gameDifficultyLevel,
          )!;
          gameDifficultyLevel = GameDifficultyLevel.values.byName(level);
        });
      },
    );
    super.initState();
  }

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
                  SharedPreferences.getInstance().then(
                    (instance) {
                      instance.setString(
                        KeyValueStorageKeys.gameDifficultyLevel,
                        GameDifficultyLevel.easy.name,
                      );
                    },
                  );
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
                  SharedPreferences.getInstance().then(
                    (instance) {
                      instance.setString(
                        KeyValueStorageKeys.gameDifficultyLevel,
                        GameDifficultyLevel.medium.name,
                      );
                    },
                  );
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
                  SharedPreferences.getInstance().then(
                    (instance) {
                      instance.setString(
                        KeyValueStorageKeys.gameDifficultyLevel,
                        GameDifficultyLevel.hard.name,
                      );
                    },
                  );
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
