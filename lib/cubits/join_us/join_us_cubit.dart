import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'join_us_state.dart';

class JoinUsCubit extends Cubit<JoinUsState> {
  JoinUsCubit() : super(const JoinUsUpdate());

  void initForm({
    String name = '',
    String email = '',
    String password = '',
    String confirmPassword = '',
  }) {
    emit(
      state.copyWith(
        name: name,
        email: email,
        password: password,
        confirmPassword: password,
      ),
    );
  }

  void updateName(String? name) {
    emit(state.copyWith(name: name));
  }

  void updateEmail(String? email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String? password) {
    emit(state.copyWith(password: password));
  }

  void updateConfirmPassword(String? confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void updateAutoValidateMode(AutovalidateMode? autoValidateMode) {
    emit(state.copyWith(autoValidateMode: autoValidateMode));
  }

  void toggleObscureText() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void reset() {
    emit(const JoinUsUpdate());
  }
}
