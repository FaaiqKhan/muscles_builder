import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameSoundWidget extends StatefulWidget {
  const GameSoundWidget({super.key});

  @override
  State<GameSoundWidget> createState() => _GameSoundWidgetState();
}

class _GameSoundWidgetState extends State<GameSoundWidget> {
  bool gameSoundValue = true;

  @override
  void initState() {
    SharedPreferences.getInstance().then(
      (instance) {
        setState(() {
          gameSoundValue =
              instance.getBool(KeyValueStorageKeys.gameSound) ?? true;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Game sound",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Switch(
          value: gameSoundValue,
          activeColor: Colors.amber,
          onChanged: (value) async {
            SharedPreferences.getInstance().then((instance) {
              instance.setBool(KeyValueStorageKeys.gameSound, value);
            });
            setState(() {
              gameSoundValue = value;
            });
          },
        )
      ],
    );
  }
}
