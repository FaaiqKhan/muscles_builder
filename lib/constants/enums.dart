enum GameDifficultyLevel { easy, medium, hard }

enum ExerciseTime {
  thirtySeconds("30 Seconds"),
  fortyFiveSeconds("45 Seconds"),
  oneMinute("1 Minute");

  final String value;

  const ExerciseTime(this.value);
}

enum PlayerControllerType {
  joystick,
  drag,
}
