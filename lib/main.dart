import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_cubit.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/cubits/theme/theme_cubit.dart';
import 'package:muscles_builder/dependencyInjection/application_di.dart';
import 'package:muscles_builder/domain/repositories/game_settings_repository.dart';
import 'package:muscles_builder/screens/splash_screen.dart';
import 'package:muscles_builder/theme/muscles_builder_theme.dart';
import 'package:muscles_builder/theme/theme.dart';
import 'package:muscles_builder/utils/utils.dart';

import 'l10n/translations/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  Utils.licenseRegistrySetup();
  await ApplicationDI.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: ThemeCubit(),
        ),
        BlocProvider.value(
          value: SettingsCubit(
            GetIt.instance.get<GameSettingsRepository>(),
          ),
        ),
        BlocProvider.value(
          value: GoogleAdsCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: PlatformDispatcher.instance.locale,
          theme: musclesBuilderThemeData,
          darkTheme: musclesBuilderThemeData.copyWith(
            extensions: <ThemeExtension<MusclesBuilderTheme>>[
              MusclesBuilderTheme.dark,
            ],
          ),
          themeMode: state.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
