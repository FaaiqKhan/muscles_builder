// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get warmingUp => '热身中...';

  @override
  String get musclesBuilderTitle => '肌肉\n锻造者';

  @override
  String get startWorkout => '开始锻炼';

  @override
  String get about => '关于';

  @override
  String appVersion(String version) {
    return '应用版本 $version';
  }

  @override
  String get contributors => '贡献者';

  @override
  String get icons => '图标';

  @override
  String get gameOver => '游戏结束';

  @override
  String get scoreTitle => '得分: ';

  @override
  String proteinBonus(int bonus) {
    return '蛋白质奖励: $bonus';
  }

  @override
  String get again => '再来一次';

  @override
  String get imTired => '我累了';

  @override
  String get backToGym => '返回健身房';

  @override
  String get gamePaused => '游戏\n已暂停';

  @override
  String get settings => '设置';

  @override
  String get reset => '重置';

  @override
  String get beHappyStayHealthy => '保持快乐\n保持健康';

  @override
  String get applicationTheme => '应用主题';

  @override
  String get exerciseTime => '锻炼时间';

  @override
  String get difficultyLevel => '难度等级';

  @override
  String get easy => '简单';

  @override
  String get medium => '中等';

  @override
  String get hard => '困难';

  @override
  String get gameSound => '游戏音效';

  @override
  String get joystickPosition => '操纵杆位置';

  @override
  String get timeTitle => '时间: ';

  @override
  String get warmupTitle => '热身: ';
}
