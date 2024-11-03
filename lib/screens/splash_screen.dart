import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Using delay to mimic loading data
    /// Will update this code in future after User details loading
    /// feature implementation.
    Future.delayed(
      const Duration(
        seconds: 2,
      ),
    ).then(
      (_) {
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        }
      },
    );
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Globals.splashScreenLoadingGIF,
              scale: 0.7,
            ),
            const SizedBox(
              height: Spacings.contentSpacingOf32,
            ),
            Text(
              "Warming up ...",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
