import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:muscles_builder/components/dumbbell_component.dart';
import 'package:muscles_builder/components/player_component.dart';
import 'package:muscles_builder/components/protein_component.dart';
import 'package:muscles_builder/components/vaccine_component.dart';
import 'package:muscles_builder/components/virus_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/inputs/joystick.dart';

class MusclesBuilderGame extends FlameGame
    with DragCallbacks, HasCollisionDetection {
  late Timer _timer;
  late PlayerComponent playerComponent;

  int _remainingTime = 30;

  final Random random = Random();

  final List<String> dumbbells = [
    Globals.dumbbellLightSprite,
    Globals.dumbbellMediumSprite,
    Globals.dumbbellHeavySprite,
  ];

  // Vaccine components
  final VaccineComponent _vaccineComponent = VaccineComponent(
    startPosition: Vector2(200, 200),
  );

  // Vaccine will give immunity only for 4 seconds
  int _vaccineImmunityTimer = 4;

  // Timer object
  late Timer vaccineTimer;

  // Random time for the vaccine to appear
  late int _vaccineTimerAppearance;

  // Protein components
  final ProteinComponent _proteinComponent = ProteinComponent(
    startPosition: Vector2(200, 400),
  );

  // Protein will automatically disappear after 4 seconds
  int _proteinTimerLeft = 4;
  late Timer proteinTimer;

  // Random time for the protein to appear
  late int _proteinTimerAppearance;

  // Keep track of any bonus
  int proteinBonus = 0;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    // Generate random number between 0 to 20
    _vaccineTimerAppearance = random.nextInt(_remainingTime - 20) + 20;

    // Time should be grater then 5 seconds and less then 10 seconds
    _proteinTimerAppearance = random.nextInt(_remainingTime - 5) + 5;

    // Load all the required audio in cache
    FlameAudio.audioCache.loadAll(
      [
        Globals.virusSound,
        Globals.vaccineSound,
        Globals.proteinSound,
        Globals.dumbbellSound,
      ],
    );

    playerComponent = PlayerComponent(joystick: joystick);
    add(playerComponent);
    add(joystick);

    add(DumbbellComponent());

    add(
      VirusComponent(
        startPosition: Vector2(
          100,
          150,
        ),
      ),
    );
    add(
      VirusComponent(
        startPosition: Vector2(
          size.x - 100,
          size.y - 200,
        ),
      ),
    );

    // Any collision on the bounds of the view port
    add(ScreenHitbox());

    _timer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (_remainingTime == 0) {
          pauseEngine();
        } else if (_remainingTime == _vaccineTimerAppearance) {
          add(_vaccineComponent);
        } else if (_remainingTime == _proteinTimerAppearance) {
          add(_proteinComponent);
          proteinTimer.start();
        }
        _remainingTime -= 1;
      },
    );
    _timer.start();

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
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
    if (playerComponent.isVaccinated) {
      vaccineTimer.update(dt);
    } else if (_vaccineTimerAppearance == 0 && _remainingTime > 3) {
      // New vaccine appearance time
      _vaccineTimerAppearance = Random().nextInt(_remainingTime - 3) + 3;
    }
    if (_proteinComponent.isLoaded) {
      proteinTimer.update(dt);
    }
  }
}
