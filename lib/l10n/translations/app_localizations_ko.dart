// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get warmingUp => '준비 운동 중...';

  @override
  String get musclesBuilderTitle => '근육\n빌더';

  @override
  String get startWorkout => '운동 시작';

  @override
  String get about => '정보';

  @override
  String appVersion(String version) {
    return '앱 버전 \$$version';
  }

  @override
  String get contributors => '기여자';

  @override
  String get icons => '아이콘';

  @override
  String get gameOver => '게임 오버';

  @override
  String get scoreTitle => '점수: ';

  @override
  String proteinBonus(int bonus) {
    return '단백질 보너스: \$$bonus';
  }

  @override
  String get again => '다시';

  @override
  String get imTired => '피곤해요';

  @override
  String get backToGym => '헬스장으로 돌아가기';

  @override
  String get gamePaused => '게임\n일시정지';

  @override
  String get settings => '설정';

  @override
  String get reset => '초기화';

  @override
  String get beHappyStayHealthy => '행복하세요\n건강하세요';

  @override
  String get applicationTheme => '앱 테마';

  @override
  String get exerciseTime => '운동 시간';

  @override
  String get difficultyLevel => '난이도';

  @override
  String get easy => '쉬움';

  @override
  String get medium => '보통';

  @override
  String get hard => '어려움';

  @override
  String get gameSound => '게임 사운드';

  @override
  String get joystickPosition => '조이스틱 위치';

  @override
  String get timeTitle => '시간: ';

  @override
  String get warmupTitle => '준비 운동: ';
}
