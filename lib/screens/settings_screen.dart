import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/screens/profile_screen.dart';
import 'package:muscles_builder/widgets/app_theme_selection_widget.dart';
import 'package:muscles_builder/widgets/exercise_time_widget.dart';
import 'package:muscles_builder/widgets/game_difficulty_level.dart';
import 'package:muscles_builder/widgets/game_sound_widget.dart';
import 'package:muscles_builder/widgets/joystick_position_widget.dart';

// TODO: Open settings screen
/// Settings screen should include the following settings
/// 1. Sound on/off
/// 2. Difficulties [Easy, Medium, and Hard]
/// 3. Change time of game
/// 4. Joystick position

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacings.contentSpacingOf12),
          child: Column(
            children: [
              const GameSoundWidget(),
              const GameDifficultyLevelWidget(),
              const ExerciseTimeWidget(),
              const JoystickPositionWidget(),
              const AppThemeSelectionWidget(),
              const Spacer(),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => ProfileScreen(),
              //       ),
              //     );
              //   },
              //   child: const Text("Update profile"),
              // ),
              const SizedBox(height: Spacings.contentSpacingOf32),
              ElevatedButton(
                onPressed: () => context.read<SettingsCubit>().resetSettings(),
                child: Text(
                  "Reset",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
