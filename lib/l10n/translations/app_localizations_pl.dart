// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get warmingUp => 'Rozgrzewka...';

  @override
  String get musclesBuilderTitle => 'Budowniczy\nmięśni';

  @override
  String get startWorkout => 'Rozpocznij trening';

  @override
  String get about => 'O aplikacji';

  @override
  String appVersion(String version) {
    return 'Wersja aplikacji $version';
  }

  @override
  String get contributors => 'Współtwórcy';

  @override
  String get icons => 'Ikony';

  @override
  String get gameOver => 'Koniec gry';

  @override
  String get scoreTitle => 'Wynik: ';

  @override
  String proteinBonus(int bonus) {
    return 'Premia białkowa: $bonus';
  }

  @override
  String get again => 'Jeszcze raz';

  @override
  String get imTired => 'Jestem zmęczony';

  @override
  String get backToGym => 'Wróć na siłownię';

  @override
  String get gamePaused => 'Gra\nwstrzymana';

  @override
  String get settings => 'Ustawienia';

  @override
  String get reset => 'Resetuj';

  @override
  String get beHappyStayHealthy => 'Bądź szczęśliwy\nPozostań zdrowy';

  @override
  String get applicationTheme => 'Motyw aplikacji';

  @override
  String get exerciseTime => 'Czas ćwiczeń';

  @override
  String get difficultyLevel => 'Poziom trudności';

  @override
  String get easy => 'Łatwy';

  @override
  String get medium => 'Średni';

  @override
  String get hard => 'Trudny';

  @override
  String get gameSound => 'Dźwięk gry';

  @override
  String get joystickPosition => 'Pozycja joysticka';

  @override
  String get timeTitle => 'CZAS: ';

  @override
  String get warmupTitle => 'ROZGRZEWKA: ';

  @override
  String get total => 'Łącznie';
}
