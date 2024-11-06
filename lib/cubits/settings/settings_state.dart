part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({this.gameSoundSwitch = true});

  final bool gameSoundSwitch;

  SettingsState copyWith({bool? gameSoundSwitch}) {
    return SettingsState(
      gameSoundSwitch: gameSoundSwitch ?? this.gameSoundSwitch,
    );
  }

  @override
  List<Object?> get props => [
        gameSoundSwitch,
      ];
}
