// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get warmingUp => 'Aquecendo...';

  @override
  String get musclesBuilderTitle => 'Construtor\nde músculos';

  @override
  String get startWorkout => 'Iniciar treino';

  @override
  String get about => 'Sobre';

  @override
  String appVersion(String version) {
    return 'Versão do app $version';
  }

  @override
  String get contributors => 'Colaboradores';

  @override
  String get icons => 'Ícones';

  @override
  String get gameOver => 'Fim de jogo';

  @override
  String get scoreTitle => 'Pontuação: ';

  @override
  String proteinBonus(int bonus) {
    return 'Bônus de proteína: $bonus';
  }

  @override
  String get again => 'De novo';

  @override
  String get imTired => 'Estou cansado';

  @override
  String get backToGym => 'Voltar para a academia';

  @override
  String get gamePaused => 'Jogo\npausado';

  @override
  String get settings => 'Configurações';

  @override
  String get reset => 'Redefinir';

  @override
  String get beHappyStayHealthy => 'Seja feliz\nMantenha-se saudável';

  @override
  String get applicationTheme => 'Tema do aplicativo';

  @override
  String get exerciseTime => 'Tempo de treino';

  @override
  String get difficultyLevel => 'Nível de dificuldade';

  @override
  String get easy => 'Fácil';

  @override
  String get medium => 'Médio';

  @override
  String get hard => 'Difícil';

  @override
  String get gameSound => 'Som do jogo';

  @override
  String get joystickPosition => 'Posição do joystick';

  @override
  String get timeTitle => 'TEMPO: ';

  @override
  String get warmupTitle => 'AQUECIMENTO: ';
}
