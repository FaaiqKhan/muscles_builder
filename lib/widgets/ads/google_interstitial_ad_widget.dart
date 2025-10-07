import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_cubit.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_state.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';

class GoogleInterstitialAdWidget extends StatelessWidget {
  const GoogleInterstitialAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleAdsCubit, GoogleAdsState>(
      builder: (context, state) {
        if (state is GoogleInterstitialAdLoading) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: context.musclesBuilderTheme.unselected.withAlpha(200),
            child: Center(
              child: CircularProgressIndicator(
                color: context.musclesBuilderTheme.damageBar,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}