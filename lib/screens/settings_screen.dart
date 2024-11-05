import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/widgets/difficulty_level.dart';
import 'package:muscles_builder/widgets/game_sound_widget.dart';

// TODO: Open settings screen
/// Settings screen should include the following settings
/// 1. Sound on/off
/// 2. Difficulties [Easy, Medium, and Hard]
/// 3. Change time of game
/// 4. Change gesture [Joystick or Drag]
/// 5. Application version

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacings.contentSpacingOf12,
          ),
          child: Column(
            children: [
              GameSoundWidget(),
              DifficultyLevel(),
            ],
          ),
        ),
      ),
    );
  }
}
