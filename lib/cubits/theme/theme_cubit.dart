import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeModeSystem());

  void setThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        emit(
          const ThemeModeSystem(),
        );
        break;
      case ThemeMode.light:
        emit(
          const ThemeModeLight(),
        );
        break;
      case ThemeMode.dark:
        emit(
          const ThemeModeDark(),
        );
        break;
    }
  }
}
