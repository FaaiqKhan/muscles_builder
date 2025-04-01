import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState()) {
    _init();
  }

  String appVersion = "Version ";
  String appBuildNumber = "";

  String getAppVersion() => appVersion;
  String getAppBuildNumber() => appBuildNumber;

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
          instance.getString(KeyValueStorageKeys.joystickPosition) ??
              JoystickPosition.left.name;
      emit(
        state.copyWith(
          gameSoundSwitch: gameSound,
          gameDifficultyLevel: GameDifficultyLevel.values.byName(
            gameDifficultyLevel,
          ),
          exerciseTime: ExerciseTime.values.byName(
            exerciseTime,
          ),
          joystickPosition: JoystickPosition.values.byName(
            playerControllerType,
          ),
        ),
      );
    });
    PackageInfo.fromPlatform().then((info) {
      appVersion += info.version;
      appBuildNumber += info.buildNumber;
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

  void updatePlayerControllerType(JoystickPosition position) {
    SharedPreferences.getInstance().then((instance) {
      instance.setString(
        KeyValueStorageKeys.joystickPosition,
        position.name,
      );
    });
    emit(
      state.copyWith(
        joystickPosition: position,
      ),
    );
  }

  void resetSettings() {
    SharedPreferences.getInstance().then((instance) {
      instance.setBool(
        KeyValueStorageKeys.gameSound,
        true,
      );
      instance.setString(
        KeyValueStorageKeys.gameDifficultyLevel,
        GameDifficultyLevel.easy.name,
      );
      instance.setString(
        KeyValueStorageKeys.exerciseTime,
        ExerciseTime.thirtySeconds.name,
      );
      instance.setString(
        KeyValueStorageKeys.joystickPosition,
        JoystickPosition.left.name,
      );
    });
    emit(
      state.copyWith(
        gameSoundSwitch: true,
        gameDifficultyLevel: GameDifficultyLevel.easy,
        exerciseTime: ExerciseTime.thirtySeconds,
        joystickPosition: JoystickPosition.left,
      ),
    );
  }
}
