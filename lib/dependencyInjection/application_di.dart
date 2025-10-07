import 'package:get_it/get_it.dart';
import 'package:muscles_builder/data/datasource/local_storage_datasource.dart';
import 'package:muscles_builder/domain/repositories/game_settings_repository.dart';
import 'package:muscles_builder/domain/repositories/google_ads_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  serviceLocator.registerLazySingleton<LocalStorageDatasource>(
    () => LocalStorageDatasource(preferences),
  );

  serviceLocator.registerLazySingleton<GameSettingsRepository>(
    () => GameSettingsRepositoryImpl(serviceLocator<LocalStorageDatasource>()),
  );

  serviceLocator.registerLazySingleton<GoogleAdsRepository>(
    () => GoogleAdsRepositoryImpl(serviceLocator<LocalStorageDatasource>()),
  );
}
