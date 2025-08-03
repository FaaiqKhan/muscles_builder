import 'package:bloc/bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_state.dart';

class GoogleAdsCubit extends Cubit<GoogleAdsState> {
  GoogleAdsCubit() : super(GoogleAdsInitial()) {
    initBannerAds();
  }

  late BannerAd _bannerAd;

  void initBannerAds() async {
    await MobileAds.instance.initialize();
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: const String.fromEnvironment(
        "ca-app-pub-1555928518606225/8073529817",
      ),
      listener: BannerAdListener(
        onAdLoaded: _onAdLoaded,
        onAdFailedToLoad: _onAdFailedToLoad,
      ),
      request: const AdRequest(),
    );
    await _bannerAd.load();
  }

  @override
  Future<void> close() async {
    await _bannerAd.dispose();
    return super.close();
  }

  void _onAdLoaded(Ad ad) {
    emit(
      GoogleAdsLoaded(
        _bannerAd,
      ),
    );
  }

  void _onAdFailedToLoad(Ad ad, LoadAdError error) {}
}
