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
  static const String playerFitSprite = "player_fit.png";
  static const String proteinSprite = "protein_shake.png";
  static const String backgroundSprite = "background.jpg";
  static const String playerFeverSprite = "player_fever.png";
  static const String playerSkinnySprite = "player_skinny.png";
  static const String dumbbellLightSprite = "dumbbell_light.png";
  static const String dumbbellHeavySprite = "dumbbell_heavy.png";
  static const String dumbbellMediumSprite = "dumbbell_medium.png";
  static const String playerMuscularSprite = "player_muscular.png";

  // Image Code
  static const String virusLowSprite = "viruses/virus_low/virus_low_";
  static const String virusMediumSprite = "viruses/virus_medium/virus_medium_";
  static const String virusHighSprite = "viruses/virus_high/virus_high_";
  static const String virusExtremeSprite =
      "viruses/virus_extreme/virus_extreme_";

  // Gifs
  static const String splashScreenLoadingGIF = "assets/gifs/loading.gif";
  static const String splashScreenLoading2GIF = "assets/gifs/loading2.gif";
  static const String splashScreenLoading3GIF = "assets/gifs/loading3.gif";
  static const String splashScreenLoading4GIF = "assets/gifs/loading4.gif";
  static const String splashScreenLoading5GIF = "assets/gifs/loading5.gif";
  static const String splashScreenLoading6GIF = "assets/gifs/loading6.gif";
  static const String splashScreenLoading7GIF = "assets/gifs/loading7.gif";
  static const String splashScreenLoading8GIF = "assets/gifs/loading8.gif";
  static const String splashScreenLoading9GIF = "assets/gifs/loading9.gif";

  // Virus speed according to their type
  static const double virusSpeedLow = 200.0;
  static const double virusSpeedMedium = 250.0;
  static const double virusSpeedHigh = 275.0;
  static const double virusSpeedExtreme = 300.0;

  static String get bannerAdUnitId => "ca-app-pub-1555928518606225/8073529817";

  static String get interstitialAdUnitId =>
      "ca-app-pub-1555928518606225/1855875944";
}
