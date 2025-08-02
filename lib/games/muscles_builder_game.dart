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
  late PlayerComponent _player;
  late JoystickComponent _joystick;
  late GameStatusPanelComponent _gameStatusPanelComponent;

  late bool isGameSoundOn;

  final Random random = Random();

  final List<String> dumbbells = [
    Globals.dumbbellLightSprite,
    Globals.dumbbellMediumSprite,
    Globals.dumbbellHeavySprite,
  ];

  int gameScore = 0;
  int proteinBonus = 0;

  late Sprite _virusSprite;
  late Sprite _vaccineSprite;
  late Sprite _proteinSprite;

  late double virusSpeed;
  late double warmupTime;
  late double exerciseTime;

  late int proteinSpawnCount;
  late int vaccinationSpawnCount;

  late SharedPreferences _sharedPreferences;

  double statusBarHeight = 60.0;

  // Application theme instance because FlameGame cannot access buildContext
  final ThemeData themeData;

  void increaseScoreBy(int value) => gameScore += value;

  void decreaseScoreBy(int value) {
    if (gameScore == 0) return;
    gameScore -= value;
  }

  String get warmupTimeInString => warmupTime.toInt().toString();

  String get exerciseTimeInString => exerciseTime.toInt().toString();

  bool get isWarmupCompleted => warmupTime <= 0.0;

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

  void _setupGameTimeAndScore(SharedPreferences preferences) {
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
  }

  void _setupWarmupTime(SharedPreferences preferences) {
    String? key = preferences.getString(
      KeyValueStorageKeys.warmupTime,
    );
    if (key == null) {
      warmupTime = 5.0;
      return;
    }
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

  void _setupGameDifficultyLevel(SharedPreferences preferences, Sprite virus) {
    String? key = _sharedPreferences.getString(
      KeyValueStorageKeys.gameDifficultyLevel,
    );
    if (key == null) {
      virusSpeed = 100.0;
      return;
    }
    switch (GameDifficultyLevel.values.byName(key)) {
      case GameDifficultyLevel.easy:
        virusSpeed = 200.0;
        break;
      case GameDifficultyLevel.medium:
        virusSpeed = 250.0;
        break;
      case GameDifficultyLevel.hard:
        virusSpeed = 300.0;
        VirusComponent(
          screenSize: size,
          startPosition: Vector2(
            random.nextInt(size.x.toInt()).toDouble(),
            random.nextInt(size.y.toInt()).toDouble(),
          ),
          velocity: moveSprite(virusSpeed),
          sprite: virus,
        );
        break;
    }
  }

  void _setupGameSound(SharedPreferences preferences) {
    isGameSoundOn = preferences.getBool(
          KeyValueStorageKeys.gameSound,
        ) ??
        true;
    if (isGameSoundOn) {
      // Setup game sounds
      FlameAudio.audioCache.loadAll(
        [
          Globals.virusSound,
          Globals.vaccineSound,
          Globals.proteinSound,
          Globals.dumbbellSound,
        ],
      );
    }
  }

  JoystickDirection get joystickDirection => _joystick.direction;

  Vector2 get joystickRelativeDelta => _joystick.relativeDelta;

  @override
  FutureOr<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
    _sharedPreferences = await SharedPreferences.getInstance();

    _virusSprite = await loadSprite(Globals.virusSprite);
    _vaccineSprite = await loadSprite(Globals.vaccineSprite);
    _proteinSprite = await loadSprite(Globals.proteinSprite);

    _setupGameSound(_sharedPreferences);
    _setupWarmupTime(_sharedPreferences);
    _setupGameTimeAndScore(_sharedPreferences);
    _setupGameDifficultyLevel(_sharedPreferences, _virusSprite);

    final String position = _sharedPreferences.getString(
          KeyValueStorageKeys.joystickPosition,
        ) ??
        JoystickPosition.left.name;

    _joystick = JoystickComponent(
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
        _joystick.position = Vector2(
          size.x * 0.25,
          size.y - (size.y * 0.12),
        );
        break;
      case JoystickPosition.right:
        _joystick.position = Vector2(
          size.x - size.x * 0.25,
          size.y - size.y * 0.12,
        );
        break;
    }

    _player = PlayerComponent(
      isGameSoundOn: isGameSoundOn,
    );

    _gameStatusPanelComponent = GameStatusPanelComponent(
      score: 0,
      warmupTime: warmupTimeInString,
      exerciseTime: exerciseTimeInString,
      titleTextStyle: themeData.textTheme.titleSmall!.copyWith(
        color: themeData.colorScheme.onPrimaryFixed,
      ),
      valueTextStyle: themeData.textTheme.titleSmall!.copyWith(
        color: themeData.colorScheme.onPrimary,
      ),
    );

    addAll(
      [
        _joystick,
        _player,
        _gameStatusPanelComponent,
        // Any collision on the bounds of the view port
        ScreenHitbox(),
        DumbbellComponent(),
        VirusComponent(
          screenSize: size,
          sprite: _virusSprite,
          startPosition: Vector2(
            size.x / 4,
            size.y / 2,
          ),
          velocity: moveSprite(virusSpeed),
        ),
        VirusComponent(
          screenSize: size,
          sprite: _virusSprite,
          startPosition: Vector2(
            size.x / 3,
            size.y / 3,
          ),
          velocity: moveSprite(virusSpeed),
        ),
        SpawnComponent.periodRange(
          minPeriod: 5.0,
          maxPeriod: exerciseTime,
          spawnCount: vaccinationSpawnCount,
          multiFactory: (_) {
            return [
              VaccineComponent(
                screenSize: size,
                sprite: _vaccineSprite,
                startPosition: generateRandomPosition(size),
              ),
            ];
          },
        ),
        SpawnComponent.periodRange(
          minPeriod: 8.0,
          maxPeriod: exerciseTime,
          spawnCount: proteinSpawnCount,
          multiFactory: (_) {
            return [
              ProteinComponent(
                screenSize: size,
                sprite: _proteinSprite,
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
  void update(double dt) {
    super.update(dt);
    if (warmupTime > 0.0) {
      warmupTime -= dt;
    } else {
      exerciseTime -= dt;
      if (exerciseTime <= 0.0 && !paused) {
        pauseEngine();
        overlays.add(GameOverScreen.id);
      }
    }
  }

  @override
  Color backgroundColor() {
    if (buildContext != null) {
      return Theme.of(buildContext!).colorScheme.primary;
    }
    return Colors.white;
  }

  void reset() {
    gameScore = 0;
    _player.reset();
    _gameStatusPanelComponent.reset();
    _setupGameTimeAndScore(_sharedPreferences);
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

  static void bounceBack({
    required Vector2 screenSize,
    required Vector2 objectSize,
    required Vector2 collisionPoint,
    required Vector2 originalVelocity,
  }) {
    final bool hitLeft = collisionPoint.x <= 0;
    final bool hitRight = collisionPoint.x >= screenSize.x - objectSize.x;
    final bool hitTop = collisionPoint.y <= 0;
    final bool hitBottom = collisionPoint.y >= screenSize.y - objectSize.y;

    if (hitLeft) {
      originalVelocity.x = originalVelocity.x.abs(); // bounce right
    }

    if (hitRight) {
      originalVelocity.x = -originalVelocity.x.abs(); // bounce left
    }

    if (hitTop) {
      originalVelocity.y = originalVelocity.y.abs(); // bounce down
    }

    if (hitBottom) {
      originalVelocity.y = -originalVelocity.y.abs(); // bounce up
    }
  }
}
