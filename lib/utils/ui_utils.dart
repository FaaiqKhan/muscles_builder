import 'package:flutter/cupertino.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';

class UiUtils {
  UiUtils._();

  static Color selectedAndNonSelectedText(
    BuildContext context,
    bool isSelected,
  ) {
    return isSelected
        ? context.musclesBuilderTheme.accentText
        : context.musclesBuilderTheme.primaryText;
  }
}
