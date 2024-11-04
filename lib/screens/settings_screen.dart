import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/widgets/difficulty_level.dart';

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
