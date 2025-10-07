import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_state.dart';
import 'package:muscles_builder/domain/repositories/google_ads_repository.dart';

class GoogleAdsCubit extends Cubit<GoogleAdsState> {
  GoogleAdsCubit(this.googleAdsRepository) : super(GoogleAdsInitial());

  final GoogleAdsRepository googleAdsRepository;
  BannerAd? _bannerAd;

  void loadBannerAd() async {
    BannerAd(
      size: AdSize.banner,
      adUnitId: Globals.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _bannerAd = ad as BannerAd;
          emit(GoogleAdsLoaded(ad));
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          _bannerAd = null;
          emit(GoogleAdsInitial());
        },
      ),
      request: const AdRequest(),
    ).load();
  }

  void loadInterstitialAd(VoidCallback onAction) {
    // Check whether 30 minutes passed from last ad or not
    // if passed then show the ad.
    if (googleAdsRepository.getInterstitialAdTime().isAfter(DateTime.now())) {
      onAction();
      return;
    }
    emit(GoogleInterstitialAdLoading());
    InterstitialAd.load(
      request: const AdRequest(),
      adUnitId: Globals.interstitialAdUnitId,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: (ad, _) {
              emit(GoogleAdsInitial());
              ad.dispose();
              onAction();
            },
            onAdDismissedFullScreenContent: (ad) {
              // After showing ad set the time ahead of 30 minutes
              // to show the ad in every 30 minutes.
              googleAdsRepository.updateInterstitialAdTime(
                DateTime.now().add(
                  const Duration(minutes: 30),
                ),
              );
              emit(GoogleAdsInitial());
              ad.dispose();
              onAction();
            },
          );
          ad.show();
        },
        onAdFailedToLoad: (_) => emit(GoogleAdsInitial()),
      ),
    ).catchError((_) => emit(GoogleAdsInitial()));
  }

  @override
  Future<void> close() async {
    await _bannerAd?.dispose();
    _bannerAd = null;
    return super.close();
  }
}
