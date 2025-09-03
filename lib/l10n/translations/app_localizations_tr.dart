// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get warmingUp => 'Isınma...';

  @override
  String get musclesBuilderTitle => 'Kas\nYapıcı';

  @override
  String get startWorkout => 'Antrenmana başla';

  @override
  String get about => 'Hakkında';

  @override
  String appVersion(String version) {
    return 'Uygulama sürümü \$$version';
  }

  @override
  String get contributors => 'Katkıda bulunanlar';

  @override
  String get icons => 'Simgeler';

  @override
  String get gameOver => 'Oyun bitti';

  @override
  String score(int score) {
    return 'Skor: \$$score';
  }

  @override
  String proteinBonus(int bonus) {
    return 'Protein bonusu: \$$bonus';
  }

  @override
  String get again => 'Tekrar';

  @override
  String get imTired => 'Yoruldum';

  @override
  String get backToGym => 'Spor salonuna dön';

  @override
  String get gamePaused => 'Oyun\nduraklatıldı';

  @override
  String get settings => 'Ayarlar';

  @override
  String get reset => 'Sıfırla';

  @override
  String get beHappyStayHealthy => 'Mutlu ol\nSağlıklı kal';

  @override
  String get applicationTheme => 'Uygulama teması';

  @override
  String get exerciseTime => 'Egzersiz süresi';

  @override
  String get difficultyLevel => 'Zorluk seviyesi';

  @override
  String get easy => 'Kolay';

  @override
  String get medium => 'Orta';

  @override
  String get hard => 'Zor';

  @override
  String get gameSound => 'Oyun sesi';

  @override
  String get joystickPosition => 'Joystick konumu';
}
