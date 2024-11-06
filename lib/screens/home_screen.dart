import 'dart:math';

import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/quotes.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/screens/muscles_builder_game_screen.dart';
import 'package:muscles_builder/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int randomNumber = Random().nextInt(Quotes.quotes.length);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Muscles Builder"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacings.contentSpacingOf12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  width: MediaQuery.of(context).size.width * 0.5,
                  image: const AssetImage(Globals.homeScreenLogo),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacings.contentSpacingOf32,
                    vertical: Spacings.contentSpacingOf32,
                  ),
                  child: Text(
                    Quotes.quotes[randomNumber],
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      maintainState: false,
                      builder: (_) => const MusclesBuilderGameScreen(),
                    ),
                  ),
                  child: const Text("Start Exercise"),
                ),
                const SizedBox(height: Spacings.contentSpacingOf12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ),
                  ),
                  child: const Text("Settings"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
