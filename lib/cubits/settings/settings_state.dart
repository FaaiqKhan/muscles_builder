part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.gameSoundSwitch = true,
    this.gameDifficultyLevel = GameDifficultyLevel.easy,
    this.exerciseTime = ExerciseTime.thirtySeconds,
    this.playerControllerType = PlayerControllerType.joystick,
  });

  final bool gameSoundSwitch;
  final GameDifficultyLevel gameDifficultyLevel;
  final ExerciseTime exerciseTime;
  final PlayerControllerType playerControllerType;

  SettingsState copyWith({
    bool? gameSoundSwitch,
    GameDifficultyLevel? gameDifficultyLevel,
    ExerciseTime? exerciseTime,
    PlayerControllerType? playerControllerType,
  }) {
    return SettingsState(
      gameSoundSwitch: gameSoundSwitch ?? this.gameSoundSwitch,
      gameDifficultyLevel: gameDifficultyLevel ?? this.gameDifficultyLevel,
      exerciseTime: exerciseTime ?? this.exerciseTime,
      playerControllerType: playerControllerType ?? this.playerControllerType,
    );
  }

  @override
  List<Object?> get props => [
        gameSoundSwitch,
        gameDifficultyLevel,
        exerciseTime,
        playerControllerType
      ];
}
