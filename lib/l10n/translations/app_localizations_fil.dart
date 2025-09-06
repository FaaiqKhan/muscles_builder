// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get warmingUp => 'Nag-iinit...';

  @override
  String get musclesBuilderTitle => 'Tagapagtayo\nng kalamnan';

  @override
  String get startWorkout => 'Simulan ang workout';

  @override
  String get about => 'Tungkol';

  @override
  String appVersion(String version) {
    return 'Bersyon ng app \$$version';
  }

  @override
  String get contributors => 'Mga nag-ambag';

  @override
  String get icons => 'Mga icon';

  @override
  String get gameOver => 'Tapos na ang laro';

  @override
  String scoreTitle(int value) {
    return 'Iskor: \$$value';
  }

  @override
  String proteinBonus(int bonus) {
    return 'Protein bonus: \$$bonus';
  }

  @override
  String get again => 'Muli';

  @override
  String get imTired => 'Pagod na ako';

  @override
  String get backToGym => 'Bumalik sa gym';

  @override
  String get gamePaused => 'Laro\nnakapahinga';

  @override
  String get settings => 'Mga setting';

  @override
  String get reset => 'I-reset';

  @override
  String get beHappyStayHealthy => 'Maging masaya\nManatiling malusog';

  @override
  String get applicationTheme => 'Tema ng app';

  @override
  String get exerciseTime => 'Oras ng ehersisyo';

  @override
  String get difficultyLevel => 'Antas ng hirap';

  @override
  String get easy => 'Madali';

  @override
  String get medium => 'Katamtaman';

  @override
  String get hard => 'Mahirap';

  @override
  String get gameSound => 'Tunog ng laro';

  @override
  String get joystickPosition => 'Posisyon ng joystick';

  @override
  String timeTitle(String value) {
    return 'TIME: \$$value';
  }

  @override
  String warmupTitle(String value) {
    return 'WARMUP: \$$value';
  }
}
