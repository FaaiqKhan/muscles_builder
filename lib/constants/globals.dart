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
  static const String virusSprite = "virus.png";
  static const String vaccineSprite = "vaccine.png";
  static const String playerFitSprite = "player_fit.png";
  static const String proteinSprite = "protein_shake.png";
  static const String backgroundSprite = "background.jpg";
  static const String playerFeverSprite = "player_fever.png";
  static const String playerSkinnySprite = "player_skinny.png";
  static const String dumbbellLightSprite = "dumbbell_light.png";
  static const String dumbbellHeavySprite = "dumbbell_light.png";
  static const String dumbbellMediumSprite = "dumbbell_light.png";
  static const String playerMuscularSprite = "player_muscular.png";

  // Images for dart
  // Dart does not know about the assets path
  static const String homeScreenLogo = "assets/images/home_screen_logo.png";

  // Gifs
  static const String splashScreenLoadingGIF = "assets/gifs/loading.gif";
}
