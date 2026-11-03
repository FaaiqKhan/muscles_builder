import 'package:flutter/material.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';

class ScreenTitleWidget extends StatelessWidget {
  const ScreenTitleWidget({required this.title, this.style, super.key});

  final String title;

  /// Optional override of the default [TextTheme.displayLarge] style.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: (style ?? Theme.of(context).textTheme.displayLarge)?.copyWith(
          color: context.musclesBuilderTheme.primaryText,
        ),
      ),
    );
  }
}
