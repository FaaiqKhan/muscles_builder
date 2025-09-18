import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_cubit.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/cubits/theme/theme_cubit.dart';
import 'package:muscles_builder/screens/splash_screen.dart';
import 'package:muscles_builder/theme/muscles_builder_theme.dart';
import 'package:muscles_builder/theme/theme.dart';

import 'l10n/translations/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: ThemeCubit(),
        ),
        BlocProvider.value(
          value: SettingsCubit(),
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
