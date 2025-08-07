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
              color: context.musclesBuilderTheme.unselected,
            ),
            child: Center(
              child: Text(
                "Be healthy, stay happy",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: context.musclesBuilderTheme.muscleGrowthBar,
                    shadows: [
                      Shadow(
                        color: context.musclesBuilderTheme.primaryText,
                        offset: Offset(2, 2),
                      )
                    ]),
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