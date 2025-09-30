import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<bool> init(BuildContext context) async {
    /// Using delay to show splash screen for 1 seconds
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.musclesBuilderTheme.background,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: init(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /// Adding Widget post frame callback because when the status of
            /// future builder changes the flutter engine re-render the UI
            /// which causes error due on navigation when UI is rendering so,
            /// using this function to navigate when frames are rendered.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(),
                ),
              );
            });
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                scale: 0.7,
                Globals.splashScreenLoadingGIF,
              ),
              const SizedBox(height: Spacings.contentSpacingOf12),
              Text(
                AppLocalizations.of(context).warmingUp,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: context.musclesBuilderTheme.primaryText),
              ),
            ],
          );
        },
      ),
    );
  }
}
