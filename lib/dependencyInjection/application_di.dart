import 'package:get_it/get_it.dart';
import 'package:muscles_builder/data/datasource/local_storage_datasource.dart';
import 'package:muscles_builder/domain/repositories/game_settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationDI {
  ApplicationDI._();

  static Future<void> init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    LocalStorageDatasource localStorageDatasource = LocalStorageDatasource(
      preferences,
    );
    GetIt.instance.registerSingleton(
      () => GameSettingsRepositoryImpl(localStorageDatasource),
    );
  }
}
