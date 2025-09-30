import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/data/datasource/local_storage_datasource.dart';

abstract class GameSettingsRepository {
  Future<void> setGameSoundState(bool state);

  bool getGameSoundState();

  Future<void> setGameDifficulty(GameDifficulty difficulty);

  GameDifficulty getGameDifficulty();

  Future<void> setGameExerciseTime(GameExerciseTime exerciseTime);

  GameExerciseTime getGameExerciseTime();

  Future<void> setGameJoystickPosition(JoystickPosition position);

  JoystickPosition getGameJoystickPosition();

  Future<void> resetSettings();
}

class GameSettingsRepositoryImpl implements GameSettingsRepository {
  final LocalStorageDatasource localStorageDatasource;

  GameSettingsRepositoryImpl(this.localStorageDatasource);

  @override
  GameDifficulty getGameDifficulty() {
    return localStorageDatasource.getGameDifficulty() ?? GameDifficulty.easy;
  }

  @override
  GameExerciseTime getGameExerciseTime() {
    return localStorageDatasource.getGameExerciseTime() ??
        GameExerciseTime.thirtySeconds;
  }

  @override
  JoystickPosition getGameJoystickPosition() {
    return localStorageDatasource.getJoystickPosition() ??
        JoystickPosition.left;
  }

  @override
  bool getGameSoundState() {
    return localStorageDatasource.getGameSoundState() ?? true;
  }

  @override
  Future<void> setGameDifficulty(GameDifficulty difficulty) async {
    await localStorageDatasource.setGameDifficulty(difficulty);
  }

  @override
  Future<void> setGameExerciseTime(GameExerciseTime exerciseTime) async {
    await localStorageDatasource.setGameExerciseTime(exerciseTime);
  }

  @override
  Future<void> setGameJoystickPosition(JoystickPosition position) async {
    await localStorageDatasource.setJoystickPosition(position);
  }

  @override
  Future<void> setGameSoundState(bool state) async {
    await localStorageDatasource.setGameSound(state);
  }

  @override
  Future<void> resetSettings() async {
    localStorageDatasource.setGameSound(true);
    localStorageDatasource.setGameDifficulty(GameDifficulty.easy);
    localStorageDatasource.setJoystickPosition(JoystickPosition.left);
    localStorageDatasource.setGameExerciseTime(GameExerciseTime.thirtySeconds);
  }
}
