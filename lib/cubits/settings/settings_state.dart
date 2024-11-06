part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.gameSoundSwitch = true,
    this.gameDifficultyLevel = GameDifficultyLevel.easy,
    this.exerciseTime = ExerciseTime.threeMinutes,
  });

  final bool gameSoundSwitch;
  final GameDifficultyLevel gameDifficultyLevel;
  final ExerciseTime exerciseTime;

  SettingsState copyWith({
    bool? gameSoundSwitch,
    GameDifficultyLevel? gameDifficultyLevel,
    ExerciseTime? exerciseTime,
  }) {
    return SettingsState(
      gameSoundSwitch: gameSoundSwitch ?? this.gameSoundSwitch,
      gameDifficultyLevel: gameDifficultyLevel ?? this.gameDifficultyLevel,
      exerciseTime: exerciseTime ?? this.exerciseTime,
    );
  }

  @override
  List<Object?> get props => [
        gameSoundSwitch,
        gameDifficultyLevel,
        exerciseTime,
      ];
}
