// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get warmingUp => 'Rozcvička...';

  @override
  String get musclesBuilderTitle => 'Budovatel\nsvalů';

  @override
  String get startWorkout => 'Začít trénink';

  @override
  String get about => 'O aplikaci';

  @override
  String appVersion(String version) {
    return 'Verze aplikace $version';
  }

  @override
  String get contributors => 'Přispěvatelé';

  @override
  String get icons => 'Ikony';

  @override
  String get gameOver => 'Konec hry';

  @override
  String get scoreTitle => 'Skóre: ';

  @override
  String proteinBonus(int bonus) {
    return 'Proteinový bonus: $bonus';
  }

  @override
  String get again => 'Znovu';

  @override
  String get imTired => 'Jsem unavený';

  @override
  String get backToGym => 'Zpět do posilovny';

  @override
  String get gamePaused => 'Hra\npozastavena';

  @override
  String get settings => 'Nastavení';

  @override
  String get reset => 'Obnovit';

  @override
  String get beHappyStayHealthy => 'Buď šťastný\nZůstaň zdravý';

  @override
  String get applicationTheme => 'Téma aplikace';

  @override
  String get exerciseTime => 'Doba cvičení';

  @override
  String get difficultyLevel => 'Úroveň obtížnosti';

  @override
  String get easy => 'Lehká';

  @override
  String get medium => 'Střední';

  @override
  String get hard => 'Těžká';

  @override
  String get gameSound => 'Zvuk hry';

  @override
  String get joystickPosition => 'Poloha joysticku';

  @override
  String get timeTitle => 'ČAS: ';

  @override
  String get warmupTitle => 'ROZCVIČENÍ: ';
}
