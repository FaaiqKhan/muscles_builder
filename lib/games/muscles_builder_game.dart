import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muscles_builder/components/dumbbell_component.dart';
import 'package:muscles_builder/components/game_status_panel_component.dart';
import 'package:muscles_builder/components/player_component.dart';
import 'package:muscles_builder/components/protein_component.dart';
import 'package:muscles_builder/components/vaccine_component.dart';
import 'package:muscles_builder/components/virus_component.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:muscles_builder/screens/game_over_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusclesBuilderGame extends FlameGame with HasCollisionDetection {
  late PlayerComponent playerComponent;

  late GameStatusPanelComponent gameStatusPanelComponent;
  late JoystickComponent joystick;

  late bool isGameSoundOn;
  late GameDifficultyLevel gameDifficultyLevel;

  final Random random = Random();

  final List<String> dumbbells = [
    Globals.dumbbellLightSprite,
    Globals.dumbbellMediumSprite,
    Globals.dumbbellHeavySprite,
  ];

  // Keep track of any bonus
  int proteinBonus = 0;

  late double warmupTime;
  late double exerciseTime;

  late int proteinSpawnCount;
  late int vaccinationSpawnCount;

  double statusBarHeight = 60.0;

  // Application theme instance because FlameGame cannot access buildContext
  final ThemeData themeData;

  MusclesBuilderGame({required this.themeData});

  Vector2 moveSprite(double speed) {
    // Generate a random angle in radius
    final randomAngle = random.nextDouble() * 2 * pi;
    // Calculate the sine and cosine of the angle
    final sinAngle = sin(randomAngle);
    final cosAngle = cos(randomAngle);

    final double vx = cosAngle * speed;
    final double vy = sinAngle * speed;

    return Vector2(vx, vy);
  }

  Vector2 generateRandomPosition(Vector2 size) {
    final x = random.nextInt(size.x.toInt()).toDouble();
    final y = random.nextInt(size.y.toInt()).toDouble();
    return Vector2(x, y);
  }

  void _init(SharedPreferences preferences) {
    String? key = preferences.getString(
      KeyValueStorageKeys.exerciseTime,
    );
    if (key == null) {
      exerciseTime = 20.0;
      proteinSpawnCount = 0;
      vaccinationSpawnCount = 0;
    } else {
      switch (ExerciseTime.values.byName(key)) {
        case ExerciseTime.thirtySeconds:
          exerciseTime = 30.0;
          proteinSpawnCount = 2;
          vaccinationSpawnCount = 1;
          break;
        case ExerciseTime.fortyFiveSeconds:
          exerciseTime = 45.0;
          proteinSpawnCount = 3;
          vaccinationSpawnCount = 2;
          break;
        case ExerciseTime.oneMinute:
          exerciseTime = 60.0;
          proteinSpawnCount = 4;
          vaccinationSpawnCount = 3;
          break;
      }
    }
    _setupWarmupTime(preferences);
  }

  void _setupWarmupTime(SharedPreferences preferences) {
    String? key = preferences.getString(
      KeyValueStorageKeys.warmupTime,
    );
    if (key == null) {
      warmupTime = 5.0;
    } else {
      switch (WarmupTime.values.byName(key)) {
        case WarmupTime.fiveSeconds:
          warmupTime = 5.0;
          break;
        case WarmupTime.threeSeconds:
          warmupTime = 3.0;
          break;
        case WarmupTime.zeroSeconds:
          warmupTime = 0.0;
          break;
      }
    }
  }

  @override
  FutureOr<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
    final sharedPreferences = await SharedPreferences.getInstance();
    _init(sharedPreferences);
    isGameSoundOn = sharedPreferences.getBool(
      KeyValueStorageKeys.gameSound,
    )!;
    // Load all the required audio in cache
    if (isGameSoundOn) {
      FlameAudio.audioCache.loadAll(
        [
          Globals.virusSound,
          Globals.vaccineSound,
          Globals.proteinSound,
          Globals.dumbbellSound,
        ],
      );
    }

    gameDifficultyLevel = GameDifficultyLevel.values.byName(
      sharedPreferences.getString(
        KeyValueStorageKeys.gameDifficultyLevel,
      )!,
    );

    final String position = sharedPreferences.getString(
          KeyValueStorageKeys.joystickPosition,
        ) ??
        JoystickPosition.left.name;

    joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 30,
        paint: BasicPalette.red.withAlpha(200).paint(),
      ),
      background: CircleComponent(
        radius: 80,
        paint: BasicPalette.gray.withAlpha(100).paint(),
      ),
    );

    switch (JoystickPosition.values.byName(position)) {
      case JoystickPosition.left:
        joystick.position = Vector2(
          size.x * 0.25,
          size.y - (size.y * 0.12),
        );
        break;
      case JoystickPosition.right:
        joystick.position = Vector2(
          size.x - size.x * 0.25,
          size.y - size.y * 0.12,
        );
        break;
    }

    playerComponent = PlayerComponent(joystick: joystick);

    add(DumbbellComponent());

    if (gameDifficultyLevel == GameDifficultyLevel.hard) {
      add(
        VirusComponent(
          startPosition: Vector2(
            random.nextInt(size.x.toInt()).toDouble(),
            random.nextInt(size.y.toInt()).toDouble(),
          ),
        ),
      );
    }
    add(
      VirusComponent(
        startPosition: Vector2(
          size.x / 4,
          size.y / 2,
        ),
      ),
    );
    add(
      VirusComponent(
        startPosition: Vector2(
          size.x / 3,
          size.y / 3,
        ),
      ),
    );

    // Any collision on the bounds of the view port
    add(ScreenHitbox());

    gameStatusPanelComponent = GameStatusPanelComponent(
      gameTime: exerciseTime,
      warmupTime: warmupTime,
      titleTextStyle: themeData.textTheme.titleSmall!.copyWith(
        color: themeData.colorScheme.onPrimaryFixed,
      ),
      valueTextStyle: themeData.textTheme.titleSmall!.copyWith(
        color: themeData.colorScheme.onPrimary,
      ),
      onGameTimeComplete: () {
        pauseEngine();
        overlays.add(GameOverScreen.id);
      },
    );

    addAll(
      [
        joystick,
        playerComponent,
        gameStatusPanelComponent,
        SpawnComponent.periodRange(
          minPeriod: 5.0,
          maxPeriod: exerciseTime - 5.0,
          spawnCount: vaccinationSpawnCount,
          multiFactory: (_) {
            return [
              VaccineComponent(
                startPosition: generateRandomPosition(size),
              ),
            ];
          },
        ),
        SpawnComponent.periodRange(
          minPeriod: 8.0,
          maxPeriod: exerciseTime - 8.0,
          spawnCount: proteinSpawnCount,
          multiFactory: (_) {
            return [
              ProteinComponent(
                startPosition: generateRandomPosition(size),
              )
            ];
          },
        ),
      ],
    );

    super.onLoad();
  }

  @override
  Color backgroundColor() {
    if (buildContext != null) {
      return Theme.of(buildContext!).colorScheme.primary;
    }
    return Colors.white;
  }

  void reset() async {
    playerComponent.sprite = await loadSprite(Globals.playerSkinnySprite);
    gameStatusPanelComponent.reset(
      gameTime: exerciseTime,
      warmupTime: warmupTime,
    );
  }

  @override
  void onRemove() {
    if (isGameSoundOn) {
      FlameAudio.audioCache.clearAll();
    }
    reset();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.onRemove();
  }

  void playAgain() {
    reset();
    overlays.remove(GameOverScreen.id);
    resumeEngine();
  }

  void exitGame() {
    reset();
    detach();
    overlays.remove(GameOverScreen.id);
  }
}
