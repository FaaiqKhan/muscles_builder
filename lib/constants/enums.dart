enum GameDifficultyLevel { easy, medium, hard }

enum ExerciseTime {
  threeMinutes("3 Minutes"),
  fiveMinutes("5 Minutes"),
  eightMinutes("8 Minutes");

  final String value;

  const ExerciseTime(this.value);
}
