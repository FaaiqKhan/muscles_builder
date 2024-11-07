import 'package:flame/components.dart';
import 'package:flame/palette.dart';

JoystickComponent joystick = JoystickComponent(
  knob: CircleComponent(
    radius: 30,
    paint: BasicPalette.red.withAlpha(200).paint(),
  ),
  background: CircleComponent(
    radius: 80,
    paint: BasicPalette.gray.withAlpha(100).paint(),
  ),
);
