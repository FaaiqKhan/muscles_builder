part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.gameSoundSwitch = true,
    this.gameDifficultyLevel = GameDifficultyLevel.easy,
    this.exerciseTime = ExerciseTime.thirtySeconds,
    this.joystickPosition = JoystickPosition.left,
  });

  final bool gameSoundSwitch;
  final GameDifficultyLevel gameDifficultyLevel;
  final ExerciseTime exerciseTime;
  final JoystickPosition joystickPosition;

  SettingsState copyWith({
    bool? gameSoundSwitch,
    GameDifficultyLevel? gameDifficultyLevel,
    ExerciseTime? exerciseTime,
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
