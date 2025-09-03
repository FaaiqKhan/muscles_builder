// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get warmingUp => 'Warming up...';

  @override
  String get musclesBuilderTitle => 'Muscles\nBuilder';

  @override
  String get startWorkout => 'Start workout';

  @override
  String get about => 'About';

  @override
  String appVersion(String version) {
    return 'App version \$$version';
  }

  @override
  String get contributors => 'Contributors';

  @override
  String get icons => 'Icons';

  @override
  String get gameOver => 'Game Over';

  @override
  String score(int score) {
    return 'Score: \$$score';
  }

  @override
  String proteinBonus(int bonus) {
    return 'Protein Bonus: \$$bonus';
  }

  @override
  String get again => 'Again';

  @override
  String get imTired => 'I\'m tired';

  @override
  String get backToGym => 'Back to Gym';

  @override
  String get gamePaused => 'Game\nPaused';

  @override
  String get settings => 'Settings';

  @override
  String get reset => 'Reset';

  @override
  String get beHappyStayHealthy => 'Be Happy\nStay Healthy';

  @override
  String get applicationTheme => 'Application theme';

  @override
  String get exerciseTime => 'Exercise time';

  @override
  String get difficultyLevel => 'Difficulty level';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get gameSound => 'Game sound';

  @override
  String get joystickPosition => 'Joystick position';
}
