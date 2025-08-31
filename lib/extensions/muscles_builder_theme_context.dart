import 'package:flutter/material.dart';
import 'package:muscles_builder/theme/muscles_builder_theme.dart';

extension MusclesBuilderThemeContext on BuildContext {
  MusclesBuilderTheme get musclesBuilderTheme =>
      Theme.of(this).extension<MusclesBuilderTheme>()!;
}
