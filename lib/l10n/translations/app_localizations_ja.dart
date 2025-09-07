// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get warmingUp => 'ウォームアップ中...';

  @override
  String get musclesBuilderTitle => '筋肉\nビルダー';

  @override
  String get startWorkout => 'ワークアウト開始';

  @override
  String get about => 'アプリについて';

  @override
  String appVersion(String version) {
    return 'アプリバージョン $version';
  }

  @override
  String get contributors => '貢献者';

  @override
  String get icons => 'アイコン';

  @override
  String get gameOver => 'ゲームオーバー';

  @override
  String get scoreTitle => 'スコア: ';

  @override
  String proteinBonus(int bonus) {
    return 'プロテインボーナス: $bonus';
  }

  @override
  String get again => 'もう一度';

  @override
  String get imTired => '疲れた';

  @override
  String get backToGym => 'ジムに戻る';

  @override
  String get gamePaused => 'ゲーム\n一時停止';

  @override
  String get settings => '設定';

  @override
  String get reset => 'リセット';

  @override
  String get beHappyStayHealthy => '幸せに\n健康でいて';

  @override
  String get applicationTheme => 'アプリテーマ';

  @override
  String get exerciseTime => '運動時間';

  @override
  String get difficultyLevel => '難易度';

  @override
  String get easy => '簡単';

  @override
  String get medium => '普通';

  @override
  String get hard => '難しい';

  @override
  String get gameSound => 'ゲームサウンド';

  @override
  String get joystickPosition => 'ジョイスティックの位置';

  @override
  String get timeTitle => '時間: ';

  @override
  String get warmupTitle => 'ウォームアップ: ';
}
