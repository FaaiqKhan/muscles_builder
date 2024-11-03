import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:muscles_builder/components/player_component.dart';
import 'package:muscles_builder/components/virus_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/inputs/joystick.dart';

class MusclesBuilderGame extends FlameGame
    with DragCallbacks, HasCollisionDetection {
  late PlayerComponent playerComponent;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

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
  }
}
