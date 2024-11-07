import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState()) {
    _init();
  }

  void _init() {
    SharedPreferences.getInstance().then((instance) {
      final gameSound = instance.getBool(KeyValueStorageKeys.gameSound) ?? true;
      final gameDifficultyLevel =
          instance.getString(KeyValueStorageKeys.gameDifficultyLevel) ??
              GameDifficultyLevel.easy.name;
      final exerciseTime =
          instance.getString(KeyValueStorageKeys.exerciseTime) ??
              ExerciseTime.thirtySeconds.name;
      final playerControllerType =
          instance.getString(KeyValueStorageKeys.playerControllerType) ??
              PlayerControllerType.joystick.name;
      emit(
        state.copyWith(
          gameSoundSwitch: gameSound,
          gameDifficultyLevel: GameDifficultyLevel.values.byName(
            gameDifficultyLevel,
          ),
          exerciseTime: ExerciseTime.values.byName(
            exerciseTime,
          ),
          playerControllerType: PlayerControllerType.values.byName(
            playerControllerType,
          ),
        ),
      );
    });
  }

  void updateGameSoundSwitch(bool value) {
    SharedPreferences.getInstance().then((instance) {
      instance.setBool(KeyValueStorageKeys.gameSound, value);
    });
    emit(
      state.copyWith(
        gameSoundSwitch: value,
      ),
    );
  }

  void updateGameDifficultyLevel(GameDifficultyLevel difficultyLevel) {
    SharedPreferences.getInstance().then((instance) {
      instance.setString(
        KeyValueStorageKeys.gameDifficultyLevel,
        difficultyLevel.name,
      );
    });
    emit(
      state.copyWith(
        gameDifficultyLevel: difficultyLevel,
      ),
    );
  }

  void updateExerciseTime(ExerciseTime exerciseTime) {
    SharedPreferences.getInstance().then((instance) {
      instance.setString(
        KeyValueStorageKeys.exerciseTime,
        exerciseTime.name,
      );
    });
    emit(
      state.copyWith(
        exerciseTime: exerciseTime,
      ),
    );
  }

  void updatePlayerControllerType(PlayerControllerType controllerType) {
    SharedPreferences.getInstance().then((instance) {
      instance.setString(
        KeyValueStorageKeys.playerControllerType,
        controllerType.name,
      );
    });
    emit(
      state.copyWith(
        playerControllerType: controllerType,
      ),
    );
  }
}
