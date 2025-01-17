import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'google_ads_state.dart';

class GoogleAdsCubit extends Cubit<GoogleAdsState> {
  GoogleAdsCubit() : super(GoogleAdsInitial());
}
