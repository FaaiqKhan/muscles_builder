// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get warmingUp => 'Разминка...';

  @override
  String get musclesBuilderTitle => 'Строитель\nмышц';

  @override
  String get startWorkout => 'Начать тренировку';

  @override
  String get about => 'О программе';

  @override
  String appVersion(String version) {
    return 'Версия приложения \$$version';
  }

  @override
  String get contributors => 'Участники';

  @override
  String get icons => 'Иконки';

  @override
  String get gameOver => 'Игра окончена';

  @override
  String score(int score) {
    return 'Счёт: \$$score';
  }

  @override
  String proteinBonus(int bonus) {
    return 'Бонус белка: \$$bonus';
  }

  @override
  String get again => 'Снова';

  @override
  String get imTired => 'Я устал';

  @override
  String get backToGym => 'Вернуться в зал';

  @override
  String get gamePaused => 'Игра\nприостановлена';

  @override
  String get settings => 'Настройки';

  @override
  String get reset => 'Сброс';

  @override
  String get beHappyStayHealthy => 'Будь счастлив\nБудь здоров';

  @override
  String get applicationTheme => 'Тема приложения';

  @override
  String get exerciseTime => 'Время тренировки';

  @override
  String get difficultyLevel => 'Уровень сложности';

  @override
  String get easy => 'Лёгкий';

  @override
  String get medium => 'Средний';

  @override
  String get hard => 'Тяжёлый';

  @override
  String get gameSound => 'Звук игры';

  @override
  String get joystickPosition => 'Позиция джойстика';
}
