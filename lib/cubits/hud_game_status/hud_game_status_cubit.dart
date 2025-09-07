import 'package:bloc/bloc.dart';

part 'hud_game_status_state.dart';

class HudGameStatusCubit extends Cubit<HudGameStatusState> {
  HudGameStatusCubit({
    required double warmupTime,
    required double exerciseTime,
  }) : super(
          HudGameStatusState(
            warmupTime: warmupTime,
            exerciseTime: exerciseTime,
          ),
        );

  bool get isWarmupTimeCompleted => state.warmupTime <= 0.0;

  bool get isExerciseTimeCompleted => state.exerciseTime <= 0.0;

  void decreaseExerciseTimeBy(double dt) {
    emit(
      state.copyWith(
        exerciseTime: (state.exerciseTime - dt).clamp(0, 60.0),
      ),
    );
  }

  void decreaseWarmupTimeBy(double dt) {
    emit(
      state.copyWith(
        warmupTime: (state.warmupTime - dt).clamp(0, 5.0),
      ),
    );
  }

  void updateScore(int value) {
    emit(
      state.copyWith(
        score: value,
      ),
    );
  }

  void updateProteinBonus(int value) {
    emit(
      state.copyWith(
        proteinBonus: value,
      ),
    );
  }

  void reset({
    required double warmupTime,
    required double exerciseTime,
  }) {
    emit(
      HudGameStatusState(
        warmupTime: warmupTime,
        exerciseTime: exerciseTime,
      ),
    );
  }
}
