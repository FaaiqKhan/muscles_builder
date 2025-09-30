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
import 'package:muscles_builder/components/player_component.dart';
import 'package:muscles_builder/components/protein_component.dart';
import 'package:muscles_builder/components/vaccine_component.dart';
import 'package:muscles_builder/components/virus_animated_component.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:muscles_builder/cubits/hud_game_status/hud_game_status_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/screens/game_over_screen.dart';
import 'package:muscles_builder/screens/game_pause_screen.dart';
import 'package:muscles_builder/theme/muscles_builder_theme.dart';
import 'package:muscles_builder/utils/data_utils.dart';
import 'package:muscles_builder/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusclesBuilderGame extends FlameGame with HasCollisionDetection {
  MusclesBuilderGame({
    required this.themeData,
    required this.gameTheme,
    required this.hudGameStatusCubit,
  });

  final HudGameStatusCubit hudGameStatusCubit;
  final double vaccineTime = 5.0;

  late PlayerComponent _player;
  late JoystickComponent _joystick;

  late bool isGameSoundOn;

  final Random random = Random();

  final List<String> dumbbells = [
    Globals.dumbbellLightSprite,
    Globals.dumbbellMediumSprite,
    Globals.dumbbellHeavySprite,
  ];

  double _timeAccumulator = 0;

  late Sprite _vaccineSprite;
  late Sprite _proteinSprite;

  late int proteinSpawnCount;
  late int vaccinationSpawnCount;

  late SharedPreferences _sharedPreferences;

  // Application theme instance because FlameGame cannot access buildContext
  final ThemeData themeData;
  final MusclesBuilderTheme gameTheme;

  int get gameScore => hudGameStatusCubit.state.score;

  void increaseScoreBy(int value) {
    hudGameStatusCubit.updateScore(
      hudGameStatusCubit.state.score + value,
    );
  }

  void decreaseScoreBy(int value) {
    if (hudGameStatusCubit.state.score == 0) return;
    hudGameStatusCubit.updateScore(
      hudGameStatusCubit.state.score - value,
    );
  }

  void increaseProteinBonusBy(int value) {
    hudGameStatusCubit.updateProteinBonus(
      hudGameStatusCubit.state.proteinBonus + value,
    );
  }

  bool get isWarmupCompleted => hudGameStatusCubit.isWarmupTimeCompleted;

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
      KeyValueStorageKey.exerciseTime,
    );
    if (key == null) return;
    switch (GameExerciseTime.values.byName(key)) {
      case GameExerciseTime.thirtySeconds:
        proteinSpawnCount = 2;
        vaccinationSpawnCount = 1;
        break;
      case GameExerciseTime.fortyFiveSeconds:
        proteinSpawnCount = 3;
        vaccinationSpawnCount = 2;
        break;
      case GameExerciseTime.oneMinute:
        proteinSpawnCount = 4;
        vaccinationSpawnCount = 3;
        break;
    }
  }

  // Set virus count and their speed according to the difficulty
  Future<List<VirusAnimatedComponent>> _setupGameDifficultyLevel(
    SharedPreferences preferences,
  ) async {
    final List<VirusAnimatedComponent> virusComponents = [];
    String key = _sharedPreferences.getString(
      KeyValueStorageKey.gameDifficultyLevel,
    )!;
    switch (GameDifficulty.values.byName(key)) {
      case GameDifficulty.easy:
        virusComponents.add(
          VirusAnimatedComponent(
            screenSize: size,
            velocity: moveSprite(Globals.virusSpeedLow),
            startPosition: Vector2(
              size.x / 4,
              size.y / 2,
            ),
            sprite: await Future.wait(
              List.generate(
                7,
                (i) => Flame.images.load(
                  "${Globals.virusLowSprite}$i.png",
                ),
              ),
            ),
          ),
        );
        virusComponents.add(
          VirusAnimatedComponent(
            screenSize: size,
            velocity: moveSprite(Globals.virusSpeedMedium),
            startPosition: Vector2(
              size.x / 3,
              size.y / 3,
            ),
            sprite: await Future.wait(
              List.generate(
                7,
                (i) => Flame.images.load(
                  "${Globals.virusMediumSprite}$i.png",
                ),
              ),
            ),
          ),
        );
        break;
      case GameDifficulty.medium:
        virusComponents.add(
          VirusAnimatedComponent(
            screenSize: size,
            velocity: moveSprite(Globals.virusSpeedMedium),
            startPosition: Vector2(
              size.x / 4,
              size.y / 2,
            ),
            sprite: await Future.wait(
              List.generate(
                7,
                (i) => Flame.images.load(
                  "${Globals.virusMediumSprite}$i.png",
                ),
              ),
            ),
          ),
        );
        virusComponents.add(
          VirusAnimatedComponent(
            screenSize: size,
            velocity: moveSprite(Globals.virusSpeedHigh),
            startPosition: Vector2(
              size.x / 3,
              size.y / 3,
            ),
            sprite: await Future.wait(
              List.generate(
                7,
                (i) => Flame.images.load(
                  "${Globals.virusHighSprite}$i.png",
                ),
              ),
            ),
          ),
        );
        break;
      case GameDifficulty.hard:
        virusComponents.add(
          VirusAnimatedComponent(
            screenSize: size,
            velocity: moveSprite(Globals.virusSpeedMedium),
            startPosition: Vector2(
              size.x / 4,
              size.y / 2,
            ),
            sprite: await Future.wait(
              List.generate(
                7,
                (i) => Flame.images.load(
                  "${Globals.virusMediumSprite}$i.png",
                ),
              ),
            ),
          ),
        );
        virusComponents.add(
          VirusAnimatedComponent(
            screenSize: size,
            velocity: moveSprite(Globals.virusSpeedHigh),
            startPosition: Vector2(
              size.x / 3,
              size.y / 3,
            ),
            sprite: await Future.wait(
              List.generate(
                7,
                (i) => Flame.images.load(
                  "${Globals.virusHighSprite}$i.png",
                ),
              ),
            ),
          ),
        );
        virusComponents.add(
          VirusAnimatedComponent(
            screenSize: size,
            velocity: moveSprite(Globals.virusSpeedExtreme),
            startPosition: Vector2(
              size.x / 5,
              size.y / 2,
            ),
            sprite: await Future.wait(
              List.generate(
                7,
                (i) => Flame.images.load(
                  "${Globals.virusExtremeSprite}$i.png",
                ),
              ),
            ),
          ),
        );
        break;
    }
    return virusComponents;
  }

  void _setupGameSound(SharedPreferences preferences) {
    isGameSoundOn = preferences.getBool(
          KeyValueStorageKey.gameSound,
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
    await super.onLoad();
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
    _sharedPreferences = await SharedPreferences.getInstance();

    _vaccineSprite = await loadSprite(Globals.vaccineSprite);
    _proteinSprite = await loadSprite(Globals.proteinSprite);

    _setupGameSound(_sharedPreferences);
    _setupGameTimeAndScore(_sharedPreferences);
    final virus = await _setupGameDifficultyLevel(_sharedPreferences);

    final String position = _sharedPreferences.getString(
          KeyValueStorageKey.joystickPosition,
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

    addAll(
      [
        _joystick,
        _player,
        ...virus,
        // Any collision on the bounds of the view port
        ScreenHitbox(),
        DumbbellComponent(),
        SpawnComponent.periodRange(
          minPeriod: 5.0,
          maxPeriod: hudGameStatusCubit.state.exerciseTime,
          spawnCount: vaccinationSpawnCount,
          multiFactory: (_) {
            return [
              VaccineComponent(
                screenSize: size,
                sprite: _vaccineSprite,
                vaccineTime: vaccineTime,
                startPosition: generateRandomPosition(size),
              ),
            ];
          },
        ),
        SpawnComponent.periodRange(
          minPeriod: 8.0,
          maxPeriod: hudGameStatusCubit.state.exerciseTime,
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
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timeAccumulator += dt;
    if (_timeAccumulator >= 1.0) {
      if (!hudGameStatusCubit.isWarmupTimeCompleted) {
        hudGameStatusCubit.decreaseWarmupTimeBy(1.0);
      } else if (hudGameStatusCubit.isExerciseTimeCompleted && !paused) {
        pauseEngine();
        overlays.add(GameOverScreen.id);
      } else {
        hudGameStatusCubit.decreaseExerciseTimeBy(1.0);
      }
      _timeAccumulator = 0;
    }
  }

  @override
  Color backgroundColor() {
    return buildContext?.musclesBuilderTheme.background ?? Colors.white;
  }

  void reset() {
    hudGameStatusCubit.reset(
      warmupTime: DataUtils.warmupTime(
        WarmupTime.values.byName(
          Utils.getWarmupTimeKey(
            _sharedPreferences,
          ),
        ),
      ),
      exerciseTime: DataUtils.gameTime(
        GameExerciseTime.values.byName(
          Utils.getExerciseTimeKey(
            _sharedPreferences,
          ),
        ),
      ),
    );
    _player.reset();
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

  void pauseGame() {
    pauseEngine();
    overlays.add(GamePauseScreen.id);
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
