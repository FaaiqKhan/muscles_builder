import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/components/pause_button_component.dart';
import 'package:muscles_builder/components/score_panel_background_component.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class GameStatusPanelComponent extends PositionComponent
    with HasGameReference<MusclesBuilderGame> {
  late TextComponent timeText;
  late TextComponent scoreText;
  late TextComponent warmupText;
  late PauseButtonComponent pauseButton;

  int _score = 0;
  double _timeLeft;
  double _warmupTimeLeft;

  VoidCallback onGameTimeComplete;

  GameStatusPanelComponent({
    required int gameTime,
    required int warmupTime,
    required this.onGameTimeComplete,
  })  : _timeLeft = gameTime.toDouble(),
        _warmupTimeLeft = warmupTime.toDouble(),
        super();

  @override
  void onLoad() {
    super.onLoad();
    final width = game.size.x / 1.2;
    final height = game.size.y * 0.09;
    final screenCenter = game.size.x / 2;

    priority = 100;
    anchor = Anchor.topCenter;
    size = Vector2(width, height);
    position = Vector2(screenCenter, 20);

    add(
      ScorePanelBackground(
        size: size,
        borderColor: game.themeData.colorScheme.onPrimaryFixed,
        fillColor: game.themeData.colorScheme.secondary.withAlpha(125),
      ),
    );

    final textSpacingDividend = size.y / 3.25;

    // TIME Text
    timeText = TextComponent(
      text: "TIME: 30",
      position: Vector2(
        Spacings.contentSpacingOf12,
        size.y - textSpacingDividend * 3,
      ),
      textRenderer: TextPaint(
        style: game.themeData.textTheme.titleSmall?.copyWith(
          color: game.themeData.colorScheme.onPrimaryFixed,
        ),
      ),
    );

    // SCORE Text
    scoreText = TextComponent(
      text: "SCORE: 0",
      position: Vector2(
        Spacings.contentSpacingOf12,
        size.y - textSpacingDividend * 2,
      ),
      textRenderer: TextPaint(
        style: game.themeData.textTheme.titleSmall?.copyWith(
          color: game.themeData.colorScheme.onPrimaryFixed,
        ),
      ),
    );

    // WARMUP TIME Text
    warmupText = TextComponent(
      text: "WARMUP: 5",
      position: Vector2(
        Spacings.contentSpacingOf12,
        size.y - textSpacingDividend,
      ),
      textRenderer: TextPaint(
        style: game.themeData.textTheme.titleSmall?.copyWith(
          color: game.themeData.colorScheme.onPrimaryFixed,
        ),
      ),
    );

    // Pause Button
    pauseButton = PauseButtonComponent(
      radius: 25,
      position: Vector2(
        size.x - Spacings.contentSpacingOf12 - 25,
        size.y / 2,
      ),
      iconColor: game.themeData.colorScheme.onPrimary,
      borderColor: game.themeData.colorScheme.onPrimaryFixed,
      backgroundColor: game.themeData.colorScheme.secondary,
    );

    addAll([scoreText, timeText, warmupText, pauseButton]);
  }

  @override
  void update(double dt) {
    if (_warmupTimeLeft >= 0) {
      warmupText.text = "WARMUP: ${_warmupTimeLeft.toInt()}";
      _warmupTimeLeft -= dt;
    }
    if (_warmupTimeLeft < 0) {
      _timeLeft -= dt;
    }
    if (_timeLeft <= 0 && !game.paused) {
      onGameTimeComplete();
      return;
    }
    scoreText.text = "SCORE: $_score";
    timeText.text = "TIME: ${_timeLeft.clamp(0, 100).toInt()}";
    super.update(dt);
  }

  void increaseScoreBy(int points) {
    _score += points;
  }

  void decreaseScoreBy(int points) {
    _score -= points;
  }

  void reset({required int gameTime, required int warmupTime}) {
    _score = 0;
    _timeLeft = gameTime.toDouble();
    _warmupTimeLeft = warmupTime.toDouble();
  }

  int getScore() => _score;

  int getGameTime() => _timeLeft.toInt();

  int getWarmupTime() => _warmupTimeLeft.toInt();
}
