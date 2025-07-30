enum GameDifficultyLevel { easy, medium, hard }

enum ExerciseTime {
  thirtySeconds("30 Secs"),
  fortyFiveSeconds("45 Secs"),
  oneMinute("1 Min");

  final String value;

  const ExerciseTime(this.value);
}

enum JoystickPosition {
  left,
  right,
}

enum WarmupTime {
  fiveSeconds("5 Secs"),
  threeSeconds("3 Secs"),
  zeroSeconds("No warmup");

  final String value;

  const WarmupTime(this.value);
}
