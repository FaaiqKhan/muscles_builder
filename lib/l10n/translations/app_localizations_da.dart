// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get warmingUp => 'Opvarmning...';

  @override
  String get musclesBuilderTitle => 'Muskel-\nbygger';

  @override
  String get startWorkout => 'Start træning';

  @override
  String get about => 'Om';

  @override
  String appVersion(String version) {
    return 'Applikationsversion \$$version';
  }

  @override
  String get contributors => 'Bidragydere';

  @override
  String get icons => 'Ikoner';

  @override
  String get gameOver => 'Spillet er slut';

  @override
  String get scoreTitle => 'Score: ';

  @override
  String proteinBonus(int bonus) {
    return 'Proteinbonus: \$$bonus';
  }

  @override
  String get again => 'Igen';

  @override
  String get imTired => 'Jeg er træt';

  @override
  String get backToGym => 'Tilbage til fitness';

  @override
  String get gamePaused => 'Spil\npauset';

  @override
  String get settings => 'Indstillinger';

  @override
  String get reset => 'Nulstil';

  @override
  String get beHappyStayHealthy => 'Vær glad\nBliv sund';

  @override
  String get applicationTheme => 'App-tema';

  @override
  String get exerciseTime => 'Træningstid';

  @override
  String get difficultyLevel => 'Sværhedsgrad';

  @override
  String get easy => 'Let';

  @override
  String get medium => 'Mellem';

  @override
  String get hard => 'Svær';

  @override
  String get gameSound => 'Spillyd';

  @override
  String get joystickPosition => 'Joystick-position';

  @override
  String get timeTitle => 'TID: ';

  @override
  String get warmupTitle => 'OPVARMNING: ';
}
