import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muscles_builder/constants/key_value_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState()) {
    _init();
  }

  void _init() {
    SharedPreferences.getInstance().then((instance) {
      emit(
        state.copyWith(
          gameSoundSwitch:
              instance.getBool(KeyValueStorageKeys.gameSound) ?? true,
        ),
      );
    });
  }

  void updateGameSoundSwitch(bool value) {
    SharedPreferences.getInstance().then((instance) {
      instance.setBool(KeyValueStorageKeys.gameSound, value);
    });
    emit(
      state.copyWith(
        gameSoundSwitch: value,
      ),
    );
  }
}
