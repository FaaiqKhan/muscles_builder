import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  Utils._();

  static String getExerciseTimeKey(SharedPreferences instance) {
    return instance.getString(KeyValueStorageKeys.exerciseTime) ??
        ExerciseTime.thirtySeconds.name;
  }

  static String getWarmupTimeKey(SharedPreferences instance) {
    return instance.getString(KeyValueStorageKeys.warmupTime) ??
        WarmupTime.fiveSeconds.name;
  }
}
