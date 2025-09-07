// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Belarusian (`be`).
class AppLocalizationsBe extends AppLocalizations {
  AppLocalizationsBe([String locale = 'be']) : super(locale);

  @override
  String get warmingUp => 'Разагрэў...';

  @override
  String get musclesBuilderTitle => 'Будаўнік\nцягліц';

  @override
  String get startWorkout => 'Пачаць трэніроўку';

  @override
  String get about => 'Пра праграму';

  @override
  String appVersion(String version) {
    return 'Версія праграмы \$$version';
  }

  @override
  String get contributors => 'Удзельнікі';

  @override
  String get icons => 'Значкі';

  @override
  String get gameOver => 'Гульня скончана';

  @override
  String get scoreTitle => 'Ачкі: ';

  @override
  String proteinBonus(int bonus) {
    return 'Бонус бялку: \$$bonus';
  }

  @override
  String get again => 'Яшчэ раз';

  @override
  String get imTired => 'Я стаміўся';

  @override
  String get backToGym => 'Вярнуцца ў спартзалу';

  @override
  String get gamePaused => 'Гульня\nпрыпынена';

  @override
  String get settings => 'Налады';

  @override
  String get reset => 'Скід';

  @override
  String get beHappyStayHealthy => 'Будзь шчаслівы\nБудзь здаровы';

  @override
  String get applicationTheme => 'Тэма прыкладання';

  @override
  String get exerciseTime => 'Час трэніроўкі';

  @override
  String get difficultyLevel => 'Узровень складанасці';

  @override
  String get easy => 'Лёгка';

  @override
  String get medium => 'Сярэдні';

  @override
  String get hard => 'Цяжкі';

  @override
  String get gameSound => 'Гук гульні';

  @override
  String get joystickPosition => 'Пазіцыя джойсціка';

  @override
  String get timeTitle => 'ЧАС: ';

  @override
  String get warmupTitle => 'РАЗАГРЭЎ: ';
}
