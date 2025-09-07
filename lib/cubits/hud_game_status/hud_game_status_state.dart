part of 'hud_game_status_cubit.dart';

class HudGameStatusState {
  final int score;
  final int proteinBonus;

  final double warmupTime;
  final double exerciseTime;

  const HudGameStatusState({
    this.score = 0,
    this.proteinBonus = 0,
    required this.warmupTime,
    required this.exerciseTime,
  });

  HudGameStatusState copyWith({
    int? score,
    int? proteinBonus,
    double? exerciseTime,
    double? warmupTime,
  }) {
    return HudGameStatusState(
      score: score ?? this.score,
      proteinBonus: proteinBonus ?? this.proteinBonus,
      warmupTime: warmupTime ?? this.warmupTime,
      exerciseTime: exerciseTime ?? this.exerciseTime,
    );
  }
}
