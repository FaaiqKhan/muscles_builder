// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get warmingUp => 'Värmer upp...';

  @override
  String get musclesBuilderTitle => 'Muskel-\nbyggare';

  @override
  String get startWorkout => 'Starta träning';

  @override
  String get about => 'Om';

  @override
  String appVersion(String version) {
    return 'Appversion \$$version';
  }

  @override
  String get contributors => 'Bidragsgivare';

  @override
  String get icons => 'Ikoner';

  @override
  String get gameOver => 'Spelet över';

  @override
  String get scoreTitle => 'Poäng: ';

  @override
  String proteinBonus(int bonus) {
    return 'Proteinbonus: \$$bonus';
  }

  @override
  String get again => 'Igen';

  @override
  String get imTired => 'Jag är trött';

  @override
  String get backToGym => 'Tillbaka till gymmet';

  @override
  String get gamePaused => 'Spelet\npausat';

  @override
  String get settings => 'Inställningar';

  @override
  String get reset => 'Återställ';

  @override
  String get beHappyStayHealthy => 'Var glad\nHåll dig frisk';

  @override
  String get applicationTheme => 'Appens tema';

  @override
  String get exerciseTime => 'Träningstid';

  @override
  String get difficultyLevel => 'Svårighetsnivå';

  @override
  String get easy => 'Lätt';

  @override
  String get medium => 'Medel';

  @override
  String get hard => 'Svår';

  @override
  String get gameSound => 'Spelljud';

  @override
  String get joystickPosition => 'Joystick-position';

  @override
  String get timeTitle => 'TID: ';

  @override
  String get warmupTitle => 'UPPVÄRMNING: ';
}
