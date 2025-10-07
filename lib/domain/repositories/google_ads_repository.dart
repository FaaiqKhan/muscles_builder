import 'package:muscles_builder/data/datasource/local_storage_datasource.dart';

abstract class GoogleAdsRepository {
  Future<void> updateInterstitialAdTime(DateTime dateTime);

  DateTime getInterstitialAdTime();
}

class GoogleAdsRepositoryImpl implements GoogleAdsRepository {
  final LocalStorageDatasource datasource;

  GoogleAdsRepositoryImpl(this.datasource);

  @override
  DateTime getInterstitialAdTime() {
    return datasource.getInterstitialAdInterval() ?? DateTime.now();
  }

  @override
  Future<void> updateInterstitialAdTime(DateTime dateTime) async {
    await datasource.setInterstitialAdInterval(dateTime);
  }
}
