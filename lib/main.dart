import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/cubits/theme/theme_cubit.dart';
import 'package:muscles_builder/screens/splash_screen.dart';
import 'package:muscles_builder/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: String.fromEnvironment("firebase-apiKey"),
      appId: String.fromEnvironment("firebase-appId"),
      messagingSenderId: String.fromEnvironment("firebase-messagingSenderId"),
      projectId: String.fromEnvironment("firebase-projectId"),
    ),
  );
  MobileAds.instance.initialize();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: ThemeCubit()),
        BlocProvider.value(value: SettingsCubit()),
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
      builder: (context, state) {
        return MaterialApp(
          theme: lightTheme,
          color: Colors.white,
          darkTheme: darkTheme,
          themeMode: state.themeMode,
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
