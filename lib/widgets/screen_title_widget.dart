import 'package:flutter/material.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';

class ScreenTitleWidget extends StatelessWidget {
  const ScreenTitleWidget({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                title,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = context.musclesBuilderTheme.primaryText,
                    ),
              ),
              // Solid text as fill.
              Text(
                title,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: context.musclesBuilderTheme.accentText,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
