// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get warmingUp => 'Riscaldamento...';

  @override
  String get musclesBuilderTitle => 'Costruttore\ndi muscoli';

  @override
  String get startWorkout => 'Inizia allenamento';

  @override
  String get about => 'Informazioni';

  @override
  String appVersion(String version) {
    return 'Versione app $version';
  }

  @override
  String get contributors => 'Collaboratori';

  @override
  String get icons => 'Icone';

  @override
  String get gameOver => 'Gioco finito';

  @override
  String get scoreTitle => 'Punteggio: ';

  @override
  String proteinBonus(int bonus) {
    return 'Bonus proteine: $bonus';
  }

  @override
  String get again => 'Ancora';

  @override
  String get imTired => 'Sono stanco';

  @override
  String get backToGym => 'Torna in palestra';

  @override
  String get gamePaused => 'Gioco\nin pausa';

  @override
  String get settings => 'Impostazioni';

  @override
  String get reset => 'Reimposta';

  @override
  String get beHappyStayHealthy => 'Sii felice\nRimani in salute';

  @override
  String get applicationTheme => 'Tema dell\'app';

  @override
  String get exerciseTime => 'Tempo di allenamento';

  @override
  String get difficultyLevel => 'Livello di difficoltà';

  @override
  String get easy => 'Facile';

  @override
  String get medium => 'Medio';

  @override
  String get hard => 'Difficile';

  @override
  String get gameSound => 'Suono del gioco';

  @override
  String get joystickPosition => 'Posizione del joystick';

  @override
  String get timeTitle => 'TEMPO: ';

  @override
  String get warmupTitle => 'RISCALDAMENTO: ';

  @override
  String get total => 'Totale';
}
