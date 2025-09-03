// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get warmingUp => 'Calentando...';

  @override
  String get musclesBuilderTitle => 'Constructor\nde músculos';

  @override
  String get startWorkout => 'Iniciar entrenamiento';

  @override
  String get about => 'Acerca de';

  @override
  String appVersion(String version) {
    return 'Versión de la app \$$version';
  }

  @override
  String get contributors => 'Colaboradores';

  @override
  String get icons => 'Iconos';

  @override
  String get gameOver => 'Juego terminado';

  @override
  String score(int score) {
    return 'Puntuación: \$$score';
  }

  @override
  String proteinBonus(int bonus) {
    return 'Bono de proteína: \$$bonus';
  }

  @override
  String get again => 'Otra vez';

  @override
  String get imTired => 'Estoy cansado';

  @override
  String get backToGym => 'Volver al gimnasio';

  @override
  String get gamePaused => 'Juego\npausado';

  @override
  String get settings => 'Configuración';

  @override
  String get reset => 'Restablecer';

  @override
  String get beHappyStayHealthy => 'Sé feliz\nMantente sano';

  @override
  String get applicationTheme => 'Tema de la aplicación';

  @override
  String get exerciseTime => 'Tiempo de ejercicio';

  @override
  String get difficultyLevel => 'Nivel de dificultad';

  @override
  String get easy => 'Fácil';

  @override
  String get medium => 'Medio';

  @override
  String get hard => 'Difícil';

  @override
  String get gameSound => 'Sonido del juego';

  @override
  String get joystickPosition => 'Posición del joystick';
}
