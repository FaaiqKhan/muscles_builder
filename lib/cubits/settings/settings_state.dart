part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.gameSoundSwitch = true,
    this.gameDifficultyLevel = GameDifficulty.easy,
    this.exerciseTime = GameExerciseTime.thirtySeconds,
    this.joystickPosition = JoystickPosition.left,
  });

  final bool gameSoundSwitch;
  final GameDifficulty gameDifficultyLevel;
  final GameExerciseTime exerciseTime;
  final JoystickPosition joystickPosition;

  SettingsState copyWith({
    bool? gameSoundSwitch,
    GameDifficulty? gameDifficultyLevel,
    GameExerciseTime? exerciseTime,
    JoystickPosition? joystickPosition,
  }) {
    return SettingsState(
      gameSoundSwitch: gameSoundSwitch ?? this.gameSoundSwitch,
      gameDifficultyLevel: gameDifficultyLevel ?? this.gameDifficultyLevel,
      exerciseTime: exerciseTime ?? this.exerciseTime,
      joystickPosition: joystickPosition ?? this.joystickPosition,
    );
  }

  @override
  List<Object?> get props => [
        gameSoundSwitch,
        gameDifficultyLevel,
        exerciseTime,
        joystickPosition
      ];
}
