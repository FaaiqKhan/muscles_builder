import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInStateUpdate());

  void initForm({
    String email = '',
    String password = '',
  }) {
    emit(
      state.copyWith(
        email: email,
        password: password,
      ),
    );
  }

  void updateEmail(String? email) {
    emit(
      state.copyWith(
        email: email,
      ),
    );
  }

  void updatePassword(String? password) {
    emit(
      state.copyWith(
        password: password,
      ),
    );
  }

  void updateAutoValidationMode(AutovalidateMode autoValidateMode) {
    emit(
      state.copyWith(
        autoValidateMode: autoValidateMode,
      ),
    );
  }

  void toggleObscureText() {
    emit(
      state.copyWith(
        obscureText: !state.obscureText,
      ),
    );
  }

  void reset() {
    emit(
      const SignInStateUpdate(),
    );
  }
}
