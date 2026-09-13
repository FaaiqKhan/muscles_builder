import 'package:flutter/material.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/screens/about_screen.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
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
                          AppLocalizations.of(context).beHappyStayHealthy,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontFamily: "Fraunces",
                                  fontWeight: FontWeight.w800,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = context
                                        .musclesBuilderTheme.primaryText),
                        ),
                        // Solid text as fill.
                        Text(
                          AppLocalizations.of(context).beHappyStayHealthy,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontFamily: "Fraunces",
                                  fontWeight: FontWeight.w800,
                                  color:
                                      context.musclesBuilderTheme.accentText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.book_outlined,
                color: context.musclesBuilderTheme.primaryText,
              ),
              title: Text(
                AppLocalizations.of(context).about,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: context.musclesBuilderTheme.primaryText,
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
      ),
    );
  }
}
