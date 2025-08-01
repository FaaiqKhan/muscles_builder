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

  final TextStyle titleTextStyle;
  final TextStyle valueTextStyle;

  GameStatusPanelComponent({
    required int score,
    required String warmupTime,
    required String exerciseTime,
    required this.titleTextStyle,
    required this.valueTextStyle,
  }) : super() {
    timeText = RichTextComponent(
      span: TextSpan(
        children: [
          TextSpan(
            text: "TIME: ",
            style: titleTextStyle,
          ),
          TextSpan(
            text: exerciseTime,
            style: valueTextStyle,
          ),
        ],
      ),
    );
    scoreText = RichTextComponent(
      position: Vector2(16, 16),
      span: TextSpan(
        children: [
          TextSpan(
            text: "SCORE: ",
            style: titleTextStyle,
          ),
          TextSpan(
            text: score.toString(),
            style: valueTextStyle,
          ),
        ],
      ),
    );
    warmupText = RichTextComponent(
      span: TextSpan(
        children: [
          TextSpan(
            text: "WARMUP: ",
            style: titleTextStyle,
          ),
          TextSpan(
            text: warmupTime,
            style: valueTextStyle,
          ),
        ],
      ),
    );
  }

  void updateWarmupText(String value) {
    warmupText.updateText(
      TextSpan(
        children: [
          TextSpan(
            text: "WARMUP: ",
            style: titleTextStyle,
          ),
          TextSpan(
            text: value,
            style: valueTextStyle,
          ),
        ],
      ),
    );
  }

  void updateGameTimeText(String value) {
    timeText.updateText(
      TextSpan(
        children: [
          TextSpan(
            text: "TIME: ",
            style: titleTextStyle,
          ),
          TextSpan(
            text: value,
            style: valueTextStyle,
          ),
        ],
      ),
    );
  }

  void updateScoreText(int value) {
    scoreText.updateText(
      TextSpan(
        children: [
          TextSpan(
            text: "SCORE: ",
            style: titleTextStyle,
          ),
          TextSpan(
            text: value.toString(),
            style: valueTextStyle,
          ),
        ],
      ),
    );
  }

  @override
  Future<void> onLoad() async {
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
    timeText.position = Vector2(
      Spacings.contentSpacingOf12,
      size.y - textSpacingDividend * 3,
    );

    // SCORE Text
    scoreText.position = Vector2(
      Spacings.contentSpacingOf12,
      size.y - textSpacingDividend * 2,
    );

    // WARMUP TIME Text
    warmupText.position = Vector2(
      Spacings.contentSpacingOf12,
      size.y - textSpacingDividend,
    );

    addAll(
      [
        scoreText,
        timeText,
        warmupText,
        PauseButtonComponent(
          radius: 25,
          position: Vector2(
            size.x - Spacings.contentSpacingOf12 - 25,
            size.y / 2,
          ),
          iconColor: game.themeData.colorScheme.onPrimary,
          borderColor: game.themeData.colorScheme.onPrimaryFixed,
          backgroundColor: game.themeData.colorScheme.secondary,
        ),
      ],
    );
  }

  @override
  void update(double dt) {
    if (game.warmupTime >= 0) {
      updateWarmupText(game.warmupTimeInString);
    }
    if (game.warmupTime < 0) {
      updateGameTimeText(game.exerciseTimeInString);
    }
    updateScoreText(game.gameScore);
    super.update(dt);
  }

  void reset() {
    updateScoreText(0);
    updateWarmupText(game.warmupTimeInString);
    updateGameTimeText(game.exerciseTimeInString);
  }
}
