import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key, required this.title, this.topPadding});

  final String title;
  final double? topPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Spacings.contentSpacingOf12,
        top: MediaQuery.of(context).size.height * (topPadding ?? 0.0),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}
