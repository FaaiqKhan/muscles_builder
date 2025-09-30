import 'package:muscles_builder/constants/enums.dart';

class DataUtils {
  DataUtils._();

  static double gameTime(GameExerciseTime time) {
    switch (time) {
      case GameExerciseTime.thirtySeconds:
        return 30.0;
      case GameExerciseTime.fortyFiveSeconds:
        return 45.0;
      case GameExerciseTime.oneMinute:
        return 60.0;
    }
  }

  static double warmupTime(WarmupTime time) {
    switch (time) {
      case WarmupTime.fiveSeconds:
        return 5.0;
      case WarmupTime.threeSeconds:
        return 3.0;
      case WarmupTime.zeroSeconds:
        return 0.0;
    }
  }
}
