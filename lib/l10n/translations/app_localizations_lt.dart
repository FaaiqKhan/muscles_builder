// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get warmingUp => 'Apšilimas...';

  @override
  String get musclesBuilderTitle => 'Raumenų\nkūrėjas';

  @override
  String get startWorkout => 'Pradėti treniruotę';

  @override
  String get about => 'Apie';

  @override
  String appVersion(String version) {
    return 'Programos versija \$$version';
  }

  @override
  String get contributors => 'Prisidėję';

  @override
  String get icons => 'Piktogramos';

  @override
  String get gameOver => 'Žaidimas baigtas';

  @override
  String score(int score) {
    return 'Taškai: \$$score';
  }

  @override
  String proteinBonus(int bonus) {
    return 'Baltymų premija: \$$bonus';
  }

  @override
  String get again => 'Dar kartą';

  @override
  String get imTired => 'Aš pavargau';

  @override
  String get backToGym => 'Grįžti į sporto salę';

  @override
  String get gamePaused => 'Žaidimas\npristabdytas';

  @override
  String get settings => 'Nustatymai';

  @override
  String get reset => 'Atstatyti';

  @override
  String get beHappyStayHealthy => 'Būk laimingas\nIšlik sveikas';

  @override
  String get applicationTheme => 'Programos tema';

  @override
  String get exerciseTime => 'Treniruotės laikas';

  @override
  String get difficultyLevel => 'Sunkumo lygis';

  @override
  String get easy => 'Lengvas';

  @override
  String get medium => 'Vidutinis';

  @override
  String get hard => 'Sunkus';

  @override
  String get gameSound => 'Žaidimo garsas';

  @override
  String get joystickPosition => 'Valdiklio padėtis';
}
