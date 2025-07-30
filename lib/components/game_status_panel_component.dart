import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:muscles_builder/components/pause_button_component.dart';
import 'package:muscles_builder/components/rich_text_component.dart';
import 'package:muscles_builder/components/score_panel_background_component.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/games/muscles_builder_game.dart';

class GameStatusPanelComponent extends PositionComponent
    with HasGameReference<MusclesBuilderGame> {
  late RichTextComponent timeText;
  late RichTextComponent scoreText;
  late RichTextComponent warmupText;
  late PauseButtonComponent pauseButton;

  final TextStyle titleTextStyle;
  final TextStyle valueTextStyle;

  int _score = 0;
  double _timeLeft;
  double _warmupTimeLeft;

  bool get isWarmupTimeCompleted => _warmupTimeLeft <= 0;

  VoidCallback onGameTimeComplete;

  GameStatusPanelComponent({
    required int gameTime,
    required int warmupTime,
    required this.titleTextStyle,
    required this.valueTextStyle,
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
    timeText = RichTextComponent(
      span: TextSpan(
        children: [
          TextSpan(
            text: "TIME: ",
            style: titleTextStyle,
          ),
          TextSpan(
            text: _timeLeft.toInt().toString(),
            style: valueTextStyle,
          ),
        ],
      ),
    )..position = Vector2(
        Spacings.contentSpacingOf12,
        size.y - textSpacingDividend * 3,
      );

    // SCORE Text
    scoreText = RichTextComponent(
      position: Vector2(16, 16),
      span: TextSpan(
        children: [
          TextSpan(
            text: "SCORE: ",
            style: titleTextStyle,
          ),
          TextSpan(
            text: _score.toString(),
            style: valueTextStyle,
          ),
        ],
      ),
    )..position = Vector2(
        Spacings.contentSpacingOf12,
        size.y - textSpacingDividend * 2,
      );

    // WARMUP TIME Text
    warmupText = RichTextComponent(
      span: TextSpan(
        children: [
          TextSpan(
            text: "WARMUP: ",
            style: titleTextStyle,
          ),
          TextSpan(
            text: _warmupTimeLeft.toString(),
            style: valueTextStyle,
          ),
        ],
      ),
    )..position = Vector2(
        Spacings.contentSpacingOf12,
        size.y - textSpacingDividend,
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
      _warmupTimeLeft -= dt;
      warmupText.updateText(
        TextSpan(
          children: [
            TextSpan(
              text: "WARMUP: ",
              style: titleTextStyle,
            ),
            TextSpan(
              text: "${_warmupTimeLeft.toInt()}",
              style: valueTextStyle,
            ),
          ],
        ),
      );
    }
    if (_warmupTimeLeft < 0) {
      _timeLeft -= dt;
      timeText.updateText(
        TextSpan(
          children: [
            TextSpan(
              text: "TIME: ",
              style: titleTextStyle,
            ),
            TextSpan(
              text: "${_timeLeft.clamp(0, 60).toInt()}",
              style: valueTextStyle,
            ),
          ],
        ),
      );
    }
    if (_timeLeft <= 0 && !game.paused) {
      onGameTimeComplete();
      return;
    }
    scoreText.updateText(
      TextSpan(
        children: [
          TextSpan(
            text: "SCORE: ",
            style: titleTextStyle,
          ),
          TextSpan(
            text: _score.toString(),
            style: valueTextStyle,
          ),
        ],
      ),
    );
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
}
