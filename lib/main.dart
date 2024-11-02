import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/quotes.dart';
import 'package:muscles_builder/constants/spacings.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final int _randomNumber = Random().nextInt(Quotes.quotes.length);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'BonaNovaSC',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          headlineSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      home: Scaffold(
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
                  const SizedBox(height: Spacings.contentSpacingOf12),
                  Text(
                    Quotes.quotes[_randomNumber],
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Spacings.contentSpacingOf32),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Start game
                    },
                    child: const Text("Exercise"),
                  ),
                  const SizedBox(height: Spacings.contentSpacingOf12),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Open settings screen
                      /// Settings screen should include the following settings
                      /// 1. Sound on/off
                      /// 2. Application version
                    },
                    child: const Text("Settings"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
