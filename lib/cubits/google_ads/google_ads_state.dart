import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

sealed class GoogleAdsState extends Equatable {
  const GoogleAdsState();
}

final class GoogleAdsInitial extends GoogleAdsState {
  @override
  List<Object> get props => [];
}

final class GoogleInterstitialAdLoading extends GoogleAdsState {
  const GoogleInterstitialAdLoading();

  @override
  List<Object?> get props => [];
}

final class GoogleAdsLoaded extends GoogleAdsState {
  final BannerAd bannerAd;

  const GoogleAdsLoaded(this.bannerAd);

  @override
  List<Object?> get props => [
        bannerAd,
      ];
}
