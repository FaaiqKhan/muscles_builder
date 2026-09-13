part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.gameSoundSwitch = true,
    this.gameDifficultyLevel = GameDifficulty.easy,
    this.exerciseTime = GameExerciseTime.thirtySeconds,
    this.joystickPosition = JoystickPosition.left,
    this.warmupTime = WarmupTime.fiveSeconds,
  });

  final bool gameSoundSwitch;
  final GameDifficulty gameDifficultyLevel;
  final GameExerciseTime exerciseTime;
  final JoystickPosition joystickPosition;
  final WarmupTime warmupTime;

  SettingsState copyWith({
    bool? gameSoundSwitch,
    GameDifficulty? gameDifficultyLevel,
    GameExerciseTime? exerciseTime,
    JoystickPosition? joystickPosition,
    WarmupTime? warmupTime,
  }) {
    return SettingsState(
      gameSoundSwitch: gameSoundSwitch ?? this.gameSoundSwitch,
      gameDifficultyLevel: gameDifficultyLevel ?? this.gameDifficultyLevel,
      exerciseTime: exerciseTime ?? this.exerciseTime,
      joystickPosition: joystickPosition ?? this.joystickPosition,
      warmupTime: warmupTime ?? this.warmupTime,
    );
  }

  @override
  List<Object?> get props => [
        gameSoundSwitch,
        gameDifficultyLevel,
        exerciseTime,
        joystickPosition,
        warmupTime,
      ];
}
