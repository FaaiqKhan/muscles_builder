import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/quotes.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/screens/muscles_builder_game_screen.dart';
import 'package:muscles_builder/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int randomNumber = Random().nextInt(Quotes.quotes.length);
  late BannerAd _bannerAd;
  bool _isBannerAdLoaded = false;

  @override
  void initState() {
    _initBannerAds();
    super.initState();
  }

  void _initBannerAds() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: const String.fromEnvironment("ad-unit-id"),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print(error);
        },
      ),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Muscles Builder"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
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
                    Quotes.quotes[randomNumber],
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      maintainState: false,
                      builder: (_) => const MusclesBuilderGameScreen(),
                    ),
                  ),
                  child: const Text("Start Exercise"),
                ),
                const SizedBox(height: Spacings.contentSpacingOf12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ),
                  ),
                  child: const Text("Settings"),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _isBannerAdLoaded
          ? SizedBox(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : const SizedBox.shrink(),
    );
  }
}
