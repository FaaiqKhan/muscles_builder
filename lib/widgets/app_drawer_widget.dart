import 'package:flutter/material.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/screens/about_screen.dart';
import 'package:muscles_builder/screens/contributors_screen.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.musclesBuilderTheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: context.musclesBuilderTheme.background,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        "Be happy",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color =
                                        context.musclesBuilderTheme.primaryText,
                                ),
                      ),
                      // Solid text as fill.
                      Text(
                        "Be happy",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: context.musclesBuilderTheme.accentText,
                                ),
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        "Stay Healthy",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color =
                                        context.musclesBuilderTheme.primaryText,
                                ),
                      ),
                      // Solid text as fill.
                      Text(
                        "Stay Healthy",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: context.musclesBuilderTheme.accentText,
                                ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Contributors",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ContributorsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              "About",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AboutScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
