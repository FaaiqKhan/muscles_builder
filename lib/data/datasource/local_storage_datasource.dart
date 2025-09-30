import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDatasource {
  LocalStorageDatasource(this.preferences);

  SharedPreferences preferences;

  Future<void> setGameSound(bool value) async {
    await preferences.setBool(KeyValueStorageKey.gameSound, value);
  }

  bool? getGameSoundState() {
    return preferences.getBool(KeyValueStorageKey.gameSound);
  }

  Future<void> setGameDifficulty(GameDifficulty difficulty) async {
    await preferences.setString(
      KeyValueStorageKey.gameDifficultyLevel,
      difficulty.name,
    );
  }

  GameDifficulty? getGameDifficulty() {
    String? difficultyLevel = preferences.getString(
      KeyValueStorageKey.gameDifficultyLevel,
    );
    return difficultyLevel == null
        ? null
        : GameDifficulty.values.byName(difficultyLevel);
  }

  Future<void> setGameExerciseTime(GameExerciseTime exerciseTime) async {
    await preferences.setString(
      KeyValueStorageKey.exerciseTime,
      exerciseTime.name,
    );
  }

  GameExerciseTime? getGameExerciseTime() {
    String? exerciseTime = preferences.getString(
      KeyValueStorageKey.exerciseTime,
    );
    return exerciseTime == null
        ? null
        : GameExerciseTime.values.byName(exerciseTime);
  }

  Future<void> setJoystickPosition(JoystickPosition position) async {
    await preferences.setString(
      KeyValueStorageKey.joystickPosition,
      position.name,
    );
  }

  JoystickPosition? getJoystickPosition() {
    String? joystickPosition = preferences.getString(
      KeyValueStorageKey.joystickPosition,
    );
    return joystickPosition == null
        ? null
        : JoystickPosition.values.byName(joystickPosition);
  }

  Future<void> setInterstitialAdInterval(DateTime dateTime) async {
    await preferences.setString(
      KeyValueStorageKey.interstitialAdInterval,
      dateTime.toIso8601String(),
    );
  }

  DateTime? getInterstitialAdInterval() {
    String? dateTimeInIsoFormat = preferences.getString(
      KeyValueStorageKey.interstitialAdInterval,
    );
    return dateTimeInIsoFormat == null
        ? null
        : DateTime.parse(dateTimeInIsoFormat);
  }
}
