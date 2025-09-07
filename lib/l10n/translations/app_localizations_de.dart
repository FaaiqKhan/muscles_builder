// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get warmingUp => 'Aufwärmen...';

  @override
  String get musclesBuilderTitle => 'Muskel-\nTrainer';

  @override
  String get startWorkout => 'Training starten';

  @override
  String get about => 'Über';

  @override
  String appVersion(String version) {
    return 'Anwendungsversion $version';
  }

  @override
  String get contributors => 'Mitwirkende';

  @override
  String get icons => 'Symbole';

  @override
  String get gameOver => 'Spiel vorbei';

  @override
  String get scoreTitle => 'Punkte: ';

  @override
  String proteinBonus(int bonus) {
    return 'Protein-Bonus: $bonus';
  }

  @override
  String get again => 'Nochmal';

  @override
  String get imTired => 'Ich bin müde';

  @override
  String get backToGym => 'Zurück ins Fitnessstudio';

  @override
  String get gamePaused => 'Spiel\npausiert';

  @override
  String get settings => 'Einstellungen';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get beHappyStayHealthy => 'Sei glücklich\nBleib gesund';

  @override
  String get applicationTheme => 'App-Design';

  @override
  String get exerciseTime => 'Trainingszeit';

  @override
  String get difficultyLevel => 'Schwierigkeitsgrad';

  @override
  String get easy => 'Einfach';

  @override
  String get medium => 'Mittel';

  @override
  String get hard => 'Schwer';

  @override
  String get gameSound => 'Spiel-Sound';

  @override
  String get joystickPosition => 'Joystick-Position';

  @override
  String get timeTitle => 'ZEIT: ';

  @override
  String get warmupTitle => 'AUFWÄRMEN: ';
}
