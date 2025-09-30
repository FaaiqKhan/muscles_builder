enum GameDifficulty { easy, medium, hard }

enum GameExerciseTime {
  thirtySeconds("30 Secs"),
  fortyFiveSeconds("45 Secs"),
  oneMinute("1 Min");

  final String value;

  const GameExerciseTime(this.value);
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
