import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/domain/repositories/game_settings_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.gameSettingsRepository) : super(const SettingsState()) {
    _init();
  }

  String _appVersion = "";

  String get appVersion => _appVersion;

  final GameSettingsRepository gameSettingsRepository;

  void _init() {
    emit(
      state.copyWith(
        exerciseTime: gameSettingsRepository.getGameExerciseTime(),
        gameSoundSwitch: gameSettingsRepository.getGameSoundState(),
        gameDifficultyLevel: gameSettingsRepository.getGameDifficulty(),
        joystickPosition: gameSettingsRepository.getGameJoystickPosition(),
      ),
    );
    PackageInfo.fromPlatform().then((info) {
      _appVersion = "${info.version}-${info.buildNumber}";
    });
  }

  void updateGameSoundSwitch(bool value) {
    gameSettingsRepository.setGameSoundState(value);
    emit(
      state.copyWith(
        gameSoundSwitch: value,
      ),
    );
  }

  void updateGameDifficultyLevel(GameDifficulty difficulty) {
    gameSettingsRepository.setGameDifficulty(difficulty);
    emit(
      state.copyWith(
        gameDifficultyLevel: difficulty,
      ),
    );
  }

  void updateExerciseTime(GameExerciseTime exerciseTime) {
    gameSettingsRepository.setGameExerciseTime(exerciseTime);
    emit(
      state.copyWith(
        exerciseTime: exerciseTime,
      ),
    );
  }

  void updatePlayerControllerType(JoystickPosition position) {
    gameSettingsRepository.setGameJoystickPosition(position);
    emit(
      state.copyWith(
        joystickPosition: position,
      ),
    );
  }

  void resetSettings() {
    gameSettingsRepository.resetSettings();
    emit(
      state.copyWith(
        gameSoundSwitch: true,
        joystickPosition: JoystickPosition.left,
        gameDifficultyLevel: GameDifficulty.easy,
        exerciseTime: GameExerciseTime.thirtySeconds,
      ),
    );
  }
}
