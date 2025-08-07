import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/quotes.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_cubit.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_state.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/screens/muscles_builder_game_screen.dart';
import 'package:muscles_builder/screens/settings_screen.dart';
import 'package:muscles_builder/widgets/app_drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: context.musclesBuilderTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  icon: Icon(
                    Icons.menu,
                    color: context.musclesBuilderTheme.button,
                  ),
                ),
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
                    color: context.musclesBuilderTheme.button,
                  ),
                ),
              ],
            ),
            Column(
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
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: context.musclesBuilderTheme.primaryText),
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
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ),
              ],
            ),
          ],
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
      drawer: AppDrawerWidget(),
    );
  }
}
