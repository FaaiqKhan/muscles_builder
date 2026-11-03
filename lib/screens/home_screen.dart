import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muscles_builder/constants/quotes.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_cubit.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_state.dart';
import 'package:muscles_builder/cubits/hud_game_status/hud_game_status_cubit.dart';
import 'package:muscles_builder/dependencyInjection/application_di.dart';
import 'package:muscles_builder/domain/repositories/game_settings_repository.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';
import 'package:muscles_builder/screens/muscles_builder_game_screen.dart';
import 'package:muscles_builder/screens/settings_screen.dart';
import 'package:muscles_builder/utils/data_utils.dart';
import 'package:muscles_builder/utils/utils.dart';
import 'package:muscles_builder/widgets/app_drawer_widget.dart';
import 'package:muscles_builder/widgets/screen_title_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<GoogleAdsCubit>().loadBannerAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Utils.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    Utils.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Returned to the home screen from a pushed route (e.g. the game
    // screen) - load a fresh banner ad instead of leaving the old one up.
    context.read<GoogleAdsCubit>().loadBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.musclesBuilderTheme.background,
      appBar: AppBar(
        backgroundColor: context.musclesBuilderTheme.background,
        iconTheme: IconThemeData(
          color: context.musclesBuilderTheme.primaryText,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
            icon: Icon(
              Icons.settings_outlined,
              color: context.musclesBuilderTheme.primaryText,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ScreenTitleWidget(
                  title: AppLocalizations.of(context).musclesBuilderTitle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacings.contentSpacingOf32,
                    vertical: Spacings.contentSpacingOf32,
                  ),
                  child: Text(
                    Quotes.quotes[Random().nextInt(Quotes.quotes.length)],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: context.musclesBuilderTheme.tertiaryText,
                      fontSize: 16,
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final settingsRepo = serviceLocator
                        .get<GameSettingsRepository>();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        maintainState: false,
                        builder: (_) => BlocProvider(
                          create: (_) => HudGameStatusCubit(
                            warmupTime: DataUtils.warmupTime(
                              settingsRepo.getWarmupTime(),
                            ),
                            exerciseTime: DataUtils.gameTime(
                              settingsRepo.getGameExerciseTime(),
                            ),
                          ),
                          child: const MusclesBuilderGameScreen(),
                        ),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context).startWorkout),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<GoogleAdsCubit, GoogleAdsState>(
        builder: (context, state) {
          if (state is GoogleAdsLoaded) {
            return SafeArea(
              top: false,
              child: _BannerAdView(
                key: ObjectKey(state.bannerAd),
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

/// Holds a single [AdWidget] per ad instance so rebuilds of the parent (e.g.
/// opening the drawer) never mount a second AdWidget for the same ad.
class _BannerAdView extends StatefulWidget {
  const _BannerAdView({super.key, required this.ad});

  final BannerAd ad;

  @override
  State<_BannerAdView> createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<_BannerAdView> {
  late final AdWidget _adWidget = AdWidget(ad: widget.ad);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.ad.size.width.toDouble(),
      height: widget.ad.size.height.toDouble(),
      child: _adWidget,
    );
  }
}
