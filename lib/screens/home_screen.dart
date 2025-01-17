import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/quotes.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_cubit.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_state.dart';
import 'package:muscles_builder/screens/muscles_builder_game_screen.dart';
import 'package:muscles_builder/screens/settings_screen.dart';
import 'package:muscles_builder/screens/sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Muscles Builder",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacings.contentSpacingOf12,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        width: MediaQuery.of(context).size.width * 0.5,
                        image: const AssetImage(Globals.homeScreenLogo),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacings.contentSpacingOf32,
                          vertical: Spacings.contentSpacingOf32,
                        ),
                        child: Text(
                          Quotes.quotes[Random().nextInt(Quotes.quotes.length)],
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            maintainState: false,
                            builder: (_) => const MusclesBuilderGameScreen(),
                          ),
                        ),
                        child: Text(
                          "Start workout",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                      const SizedBox(height: Spacings.contentSpacingOf12),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SignInScreen(),
                          ),
                        ),
                        child: Text(
                          "SignIn",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<GoogleAdsCubit, GoogleAdsState>(
        builder: (context, state) {
          if (state is GoogleAdsLoaded) {
            return SizedBox(
              width: state.bannerAd.size.width.toDouble(),
              height: state.bannerAd.size.height.toDouble(),
              child: AdWidget(
                ad: state.bannerAd,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
