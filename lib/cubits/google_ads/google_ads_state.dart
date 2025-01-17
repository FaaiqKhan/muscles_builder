part of 'google_ads_cubit.dart';

sealed class GoogleAdsState extends Equatable {
  const GoogleAdsState();
}

final class GoogleAdsInitial extends GoogleAdsState {
  @override
  List<Object> get props => [];
}
