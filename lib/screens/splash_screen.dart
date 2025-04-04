import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muscles_builder/blocs/user_authentication/user_authentication_bloc.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/globals.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/google_ads/google_ads_cubit.dart';
import 'package:muscles_builder/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<bool> init(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    final gameSound = instance.getBool(KeyValueStorageKeys.gameSound);
    if (gameSound == null) {
      await instance.setBool(
        KeyValueStorageKeys.gameSound,
        true,
      );
    }
    final gameDifficultyLevel = instance.getString(
      KeyValueStorageKeys.gameDifficultyLevel,
    );
    if (gameDifficultyLevel == null) {
      await instance.setString(
        KeyValueStorageKeys.gameDifficultyLevel,
        GameDifficultyLevel.easy.name,
      );
    }
    final exerciseTime = instance.getString(
      KeyValueStorageKeys.exerciseTime,
    );
    if (exerciseTime == null) {
      await instance.setString(
        KeyValueStorageKeys.exerciseTime,
        ExerciseTime.thirtySeconds.name,
      );
    }
    final joystickPosition = instance.getString(
      KeyValueStorageKeys.joystickPosition,
    );
    if (joystickPosition == null) {
      await instance.setString(
        KeyValueStorageKeys.joystickPosition,
        JoystickPosition.left.name,
      );
    }

    UserEntity? userEntity =
        await GetIt.I.get<UserAuthenticationUseCase>().getUser();
    if (context.mounted) {
      if (userEntity != null) {
        context.read<UserAuthenticationBloc>().add(
              UserAuthorized(
                userEntity,
              ),
            );
      } else {
        context.read<UserAuthenticationBloc>().add(
              UserUnauthorized(),
            );
      }
    }

    /// Shared preferences are so fast that splash screen comes for
    /// less then a second that's way using delay to show splash screen for 2
    /// seconds event after the data has been loaded.
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: init(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /// Adding Widget post frame callback because when the status of
            /// future builder changes the flutter engine re-render the UI
            /// which causes error due on navigation when UI is rendering so,
            /// using this function to navigate when frames are rendered.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<GoogleAdsCubit>().initBannerAds();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
              );
            });
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                scale: 0.7,
                Globals.splashScreenLoadingGIF,
              ),
              const SizedBox(height: Spacings.contentSpacingOf12),
              Text(
                "Warming up...",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}
