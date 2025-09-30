import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  Utils._();

  static String getExerciseTimeKey(SharedPreferences instance) {
    return instance.getString(KeyValueStorageKey.exerciseTime) ??
        GameExerciseTime.thirtySeconds.name;
  }

  static String getWarmupTimeKey(SharedPreferences instance) {
    return instance.getString(KeyValueStorageKey.warmupTime) ??
        WarmupTime.fiveSeconds.name;
  }

  static void licenseRegistrySetup() {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
  }
}
