// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get warmingUp => 'Bemelegítés...';

  @override
  String get musclesBuilderTitle => 'Izom-\népítő';

  @override
  String get startWorkout => 'Edzés indítása';

  @override
  String get about => 'Névjegy';

  @override
  String appVersion(String version) {
    return 'Alkalmazás verzió \$$version';
  }

  @override
  String get contributors => 'Közreműködők';

  @override
  String get icons => 'Ikonok';

  @override
  String get gameOver => 'Játék vége';

  @override
  String scoreTitle(int value) {
    return 'Pontszám: \$$value';
  }

  @override
  String proteinBonus(int bonus) {
    return 'Fehérje bónusz: \$$bonus';
  }

  @override
  String get again => 'Újra';

  @override
  String get imTired => 'Elfáradtam';

  @override
  String get backToGym => 'Vissza az edzőterembe';

  @override
  String get gamePaused => 'Játék\nszüneteltetve';

  @override
  String get settings => 'Beállítások';

  @override
  String get reset => 'Visszaállítás';

  @override
  String get beHappyStayHealthy => 'Légy boldog\nMaradj egészséges';

  @override
  String get applicationTheme => 'Alkalmazás témája';

  @override
  String get exerciseTime => 'Edzésidő';

  @override
  String get difficultyLevel => 'Nehézségi szint';

  @override
  String get easy => 'Könnyű';

  @override
  String get medium => 'Közepes';

  @override
  String get hard => 'Nehéz';

  @override
  String get gameSound => 'Játék hangja';

  @override
  String get joystickPosition => 'Joystick pozíció';

  @override
  String timeTitle(String value) {
    return 'TIME: \$$value';
  }

  @override
  String warmupTitle(String value) {
    return 'WARMUP: \$$value';
  }
}
