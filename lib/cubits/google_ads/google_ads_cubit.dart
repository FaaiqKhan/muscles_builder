import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_state.dart';

class GoogleAdsCubit extends Cubit<GoogleAdsState> {
  GoogleAdsCubit() : super(GoogleAdsInitial());

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

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

  void removeBannerAd() async {
    await _bannerAd?.dispose();
    _bannerAd = null;
    emit(GoogleAdsInitial());
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      request: const AdRequest(),
      adUnitId: Globals.interstitialAdUnitId,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
        },
      ),
    );
  }

  void showInterstitialAd(VoidCallback onAction) {
    if (_interstitialAd == null) {
      onAction();
      return;
    }
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdFailedToShowFullScreenContent: (ad, err) {
        onAction();
        _interstitialAd?.dispose();
        _interstitialAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        onAction();
        _interstitialAd?.dispose();
        _interstitialAd = null;
      },
    );
    _interstitialAd?.show();
  }

  @override
  Future<void> close() async {
    await _bannerAd?.dispose();
    await _interstitialAd?.dispose();
    _bannerAd = null;
    _interstitialAd = null;
    await super.close();
  }
}
