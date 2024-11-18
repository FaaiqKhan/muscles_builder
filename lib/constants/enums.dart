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
