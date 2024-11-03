import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:muscles_builder/components/player_component.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/inputs/joystick.dart';

class MusclesBuilderGame extends FlameGame {
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
  }
}