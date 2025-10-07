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
import 'package:muscles_builder/widgets/app_drawer_widget.dart';
import 'package:muscles_builder/widgets/screen_title_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.musclesBuilderTheme.background,
      appBar: AppBar(
        backgroundColor: context.musclesBuilderTheme.background,
        iconTheme: IconThemeData(
          color: context.musclesBuilderTheme.button,
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
              color: context.musclesBuilderTheme.button,
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
                        color: context.musclesBuilderTheme.primaryText),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final settingsRepo =
                        serviceLocator.get<GameSettingsRepository>();
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
                  child: Text(
                    AppLocalizations.of(context).startWorkout,
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
                key: UniqueKey(),
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
