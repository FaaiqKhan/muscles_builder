// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get warmingUp => 'Échauffement...';

  @override
  String get musclesBuilderTitle => 'Constructeur\nde muscles';

  @override
  String get startWorkout => 'Commencer l\'entraînement';

  @override
  String get about => 'À propos';

  @override
  String appVersion(String version) {
    return 'Version de l\'application \$$version';
  }

  @override
  String get contributors => 'Contributeurs';

  @override
  String get icons => 'Icônes';

  @override
  String get gameOver => 'Jeu terminé';

  @override
  String get scoreTitle => 'Score: ';

  @override
  String proteinBonus(int bonus) {
    return 'Bonus de protéines: \$$bonus';
  }

  @override
  String get again => 'Encore';

  @override
  String get imTired => 'Je suis fatigué';

  @override
  String get backToGym => 'Retour à la salle';

  @override
  String get gamePaused => 'Jeu\nen pause';

  @override
  String get settings => 'Paramètres';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get beHappyStayHealthy => 'Sois heureux\nReste en bonne santé';

  @override
  String get applicationTheme => 'Thème de l\'application';

  @override
  String get exerciseTime => 'Temps d\'exercice';

  @override
  String get difficultyLevel => 'Niveau de difficulté';

  @override
  String get easy => 'Facile';

  @override
  String get medium => 'Moyen';

  @override
  String get hard => 'Difficile';

  @override
  String get gameSound => 'Son du jeu';

  @override
  String get joystickPosition => 'Position du joystick';

  @override
  String get timeTitle => 'TEMPS: ';

  @override
  String get warmupTitle => 'ÉCHAUFFEMENT: ';
}
