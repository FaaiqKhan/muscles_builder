part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.gameSoundSwitch = true,
    this.gameDifficultyLevel = GameDifficultyLevel.easy,
  });

  final bool gameSoundSwitch;
  final GameDifficultyLevel gameDifficultyLevel;

  SettingsState copyWith({
    bool? gameSoundSwitch,
    GameDifficultyLevel? gameDifficultyLevel,
  }) {
    return SettingsState(
      gameSoundSwitch: gameSoundSwitch ?? this.gameSoundSwitch,
      gameDifficultyLevel: gameDifficultyLevel ?? this.gameDifficultyLevel,
    );
  }

  @override
  List<Object?> get props => [
        gameSoundSwitch,
        gameDifficultyLevel,
      ];
}
