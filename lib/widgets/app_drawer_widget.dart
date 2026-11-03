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
            Container(
              margin: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF6949FF), Color(0xFF876DFF)],
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -18,
                    right: -6,
                    child: Icon(
                      Icons.star_rounded,
                      size: 22,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 22,
                    child: Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(context).beHappyStayHealthy,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 24,
                        letterSpacing: -0.48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: Text(
                AppLocalizations.of(context).about,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(color: context.musclesBuilderTheme.primaryText),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: context.musclesBuilderTheme.primaryText,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const AboutScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
