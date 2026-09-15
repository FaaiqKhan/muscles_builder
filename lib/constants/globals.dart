import 'package:flutter/foundation.dart';

class Globals {
  // Making constructor private to restrict instantiation of class object
  Globals._();

  // Audio for Flame
  // Flame package has default assets path in the widgets
  static const String virusSound = "virus_sound.mp3";
  static const String vaccineSound = "vaccine_sound.wav";
  static const String proteinSound = "protein_sound.mp3";
  static const String dumbbellSound = "dumbbell_sound.mp3";

  // Images for Flame
  // Flame package has default assets path in the widgets
  static const String vaccineSprite = "vaccine.png";
  static const String proteinSprite = "protein_shake.png";
  static const String dumbbellLightSprite = "dumbbell_light.png";
  static const String dumbbellHeavySprite = "dumbbell_heavy.png";
  static const String dumbbellMediumSprite = "dumbbell_medium.png";
  static const String playerHelix = "player/helix_full_sheet.png";

  // Image Code
  static const String virusLowSprite = "viruses/virus_low/virus_low_";
  static const String virusMediumSprite = "viruses/virus_medium/virus_medium_";
  static const String virusHighSprite = "viruses/virus_high/virus_high_";
  static const String virusExtremeSprite =
      "viruses/virus_extreme/virus_extreme_";

  // Gifs
  static const String splashScreenLoadingGIF = "assets/gifs/loading.gif";

  // Virus speed according to their type
  static const double virusSpeedLow = 200.0;
  static const double virusSpeedMedium = 250.0;
  static const double virusSpeedHigh = 275.0;
  static const double virusSpeedExtreme = 300.0;

  // Google's official test ad unit IDs are used in debug builds so ads are
  // guaranteed to fill during development. Real ad units don't reliably
  // serve to unverified development devices, so testing with the
  // production IDs here would show a blank banner.
  static String get bannerAdUnitId => kDebugMode
      ? "ca-app-pub-3940256099942544/6300978111"
      : "ca-app-pub-1555928518606225/8073529817";

  static String get interstitialAdUnitId => kDebugMode
      ? "ca-app-pub-3940256099942544/1033173712"
      : "ca-app-pub-1555928518606225/1855875944";
}
