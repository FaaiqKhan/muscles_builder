import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/widgets/difficulty_level.dart';

// TODO: Open settings screen
/// Settings screen should include the following settings
/// 1. Sound on/off
/// 2. Application version
/// 3. Difficulties [Easy, Medium, and Hard]
/// 4. Change background color
/// 5. Change time of game
/// 6. Change gesture [Joystick or Drag]

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
              DifficultyLevel(),
            ],
          ),
        ),
      ),
    );
  }
}
