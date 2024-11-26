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
import 'package:muscles_builder/components/pause_button_component.dart';
import 'package:muscles_builder/components/player_component.dart';
import 'package:muscles_builder/components/protein_component.dart';
import 'package:muscles_builder/components/vaccine_component.dart';
import 'package:muscles_builder/components/virus_component.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/screens/game_over_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusclesBuilderGame extends FlameGame with HasCollisionDetection {
  late Timer timer;
  late TextComponent _scoreText;
  late TextComponent _timerText;
  late PlayerComponent playerComponent;
  late SharedPreferences sharedPreferences;
  late PauseButtonComponent _pauseButtonComponent;
  late JoystickComponent joystick;

  int score = 0;
  late int _remainingTime;
  late bool isGameSoundOn;
  late GameDifficultyLevel gameDifficultyLevel;

  final Random random = Random();

  final List<String> dumbbells = [
    Globals.dumbbellLightSprite,
    Globals.dumbbellMediumSprite,
    Globals.dumbbellHeavySprite,
  ];

  // Vaccine components
  late VaccineComponent vaccineComponent;

  // Vaccine will give immunity only for 4 seconds
  int _vaccineImmunityTimer = 4;

  // Timer object
  late Timer vaccineTimer;

  // Random time for the vaccine to appear
  late int _vaccineTimerAppearance;

  // Protein components
  late ProteinComponent _proteinComponent;

  // Protein will automatically disappear after 4 seconds
  int _proteinTimerLeft = 4;

  // Timer object
  late Timer proteinTimer;

  // Random time for the protein to appear
  late int _proteinTimerAppearance;

  // Keep track of any bonus
  int proteinBonus = 0;

  double statusBarHeight = 60;

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

  int getExerciseTime() {
    final String exerciseTimeName =
        sharedPreferences.getString(KeyValueStorageKeys.exerciseTime) ??
            ExerciseTime.thirtySeconds.name;
    switch (ExerciseTime.values.byName(exerciseTimeName)) {
      case ExerciseTime.thirtySeconds:
        return 30;
      case ExerciseTime.fortyFiveSeconds:
        return 45;
      case ExerciseTime.oneMinute:
        return 60;
    }
  }

  @override
  void onGameResize(Vector2 size) {
    vaccineComponent = VaccineComponent(
      startPosition: generateRandomPosition(size),
    );
    _proteinComponent = ProteinComponent(
      startPosition: generateRandomPosition(size),
    );
    super.onGameResize(size);
  }

  @override
  FutureOr<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
    sharedPreferences = await SharedPreferences.getInstance();
    _remainingTime = getExerciseTime();
    // Generate random number between 0 to 20
    _vaccineTimerAppearance = random.nextInt(_remainingTime - 20) + 20;

    // Time should be grater then 5 seconds and less then 10 seconds
    _proteinTimerAppearance = random.nextInt(_remainingTime - 5) + 5;

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
        sharedPreferences.getString(KeyValueStorageKeys.gameDifficultyLevel)!);

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
    add(joystick);

    playerComponent = PlayerComponent(joystick: joystick);
    add(playerComponent);

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

    timer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (_remainingTime == 0) {
          pauseEngine();
          overlays.add(GameOverScreen.id);
        } else if (_remainingTime == _vaccineTimerAppearance) {
          add(vaccineComponent);
        } else if (_remainingTime == _proteinTimerAppearance) {
          add(_proteinComponent);
          proteinTimer.start();
        }
        _remainingTime -= 1;
      },
    );
    timer.start();

    vaccineTimer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (_vaccineImmunityTimer == 0) {
          playerComponent.removeVaccine(); // Call to remove vaccine function
          _vaccineImmunityTimer = 4; // Again set the immunity time to 4
          _vaccineTimerAppearance = 0;
          vaccineTimer.stop();
        } else {
          _vaccineImmunityTimer -= 1;
        }
      },
    );

    proteinTimer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (_proteinTimerLeft == 0) {
          remove(_proteinComponent);
          _proteinTimerLeft = 4;
          proteinTimer.stop();
        } else {
          _proteinTimerLeft -= 1;
        }
      },
    );

    _scoreText = TextComponent(
      text: "Score: $score",
      anchor: Anchor.topLeft,
      position: Vector2(
        Spacings.contentSpacingOf12,
        size.y * 0.01,
      ),
    );
    add(_scoreText);

    _timerText = TextComponent(
      text: "Time: $_remainingTime secs",
      anchor: Anchor.topLeft,
      position: Vector2(
        Spacings.contentSpacingOf12,
        size.y * 0.04,
      ),
    );
    add(_timerText);

    _pauseButtonComponent = PauseButtonComponent();
    add(_pauseButtonComponent);
    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
    _scoreText.text = "Score:$score";
    _timerText.text = "Time:$_remainingTime";
    if (playerComponent.isVaccinated) {
      vaccineTimer.update(dt);
    } else if (_vaccineTimerAppearance == 0 && _remainingTime > 3) {
      // New vaccine appearance time
      _vaccineTimerAppearance = random.nextInt(_remainingTime - 3) + 3;
    }
    if (_proteinComponent.isLoaded) {
      proteinTimer.update(dt);
    }
  }

  @override
  void onAttach() {
    final context = buildContext!;
    _scoreText.textRenderer = TextPaint(
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
    );
    _timerText.textRenderer = TextPaint(
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
    );
    super.onAttach();
  }

  @override
  Color backgroundColor() {
    if (buildContext != null) {
      return Theme.of(buildContext!).colorScheme.primary;
    }
    return Colors.white;
  }

  void reset() async {
    score = 0;
    _remainingTime = getExerciseTime();
    _vaccineImmunityTimer = 4;
    vaccineComponent.removeFromParent();
    _proteinTimerLeft = 4;
    _proteinComponent.removeFromParent();
    _proteinTimerAppearance = random.nextInt(_remainingTime - 5) + 5;
    playerComponent.sprite = await loadSprite(Globals.playerSkinnySprite);
    playerComponent.removeVaccine();
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
}
