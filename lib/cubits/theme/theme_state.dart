part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  final ThemeMode themeMode = ThemeMode.system;
}

final class ThemeModeSystem extends ThemeState {
  const ThemeModeSystem();

  @override
  ThemeMode get themeMode => ThemeMode.system;

  @override
  List<Object> get props => [themeMode];
}

final class ThemeModeLight extends ThemeState {
  const ThemeModeLight();

  @override
  ThemeMode get themeMode => ThemeMode.light;

  @override
  List<Object?> get props => [themeMode];
}

final class ThemeModeDark extends ThemeState {
  const ThemeModeDark();

  @override
  ThemeMode get themeMode => ThemeMode.dark;

  @override
  List<Object?> get props => [themeMode];
}
