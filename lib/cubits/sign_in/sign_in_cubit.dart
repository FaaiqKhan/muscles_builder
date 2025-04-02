import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final UserAuthenticationUseCase _userAuthenticationUseCase;

  SignInCubit(this._userAuthenticationUseCase)
      : super(const SignInStateUpdate());

  void initForm({
    String email = '',
    String password = '',
    bool isLoading = false,
    String? errorMessage,
  }) {
    emit(
      state.copyWith(
        email: email,
        password: password,
        isLoading: isLoading,
        errorMessage: errorMessage,
      ),
    );
  }

  void updateEmail(String? email) {
    emit(
      state.copyWith(
        email: email,
        errorMessage: null,
      ),
    );
  }

  void updatePassword(String? password) {
    emit(
      state.copyWith(
        password: password,
        errorMessage: null,
      ),
    );
  }

  void updateAutoValidationMode(AutovalidateMode autoValidateMode) {
    emit(
      state.copyWith(
        autoValidateMode: autoValidateMode,
        errorMessage: null,
      ),
    );
  }

  void toggleObscureText() {
    emit(
      state.copyWith(
        obscureText: !state.obscureText,
        errorMessage: null,
      ),
    );
  }

  void reset() {
    emit(
      const SignInStateUpdate(
        errorMessage: null,
      ),
    );
  }

  void signIn() async {
    bool isSuccess = false;
    UserEntity? userEntity;
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    try {
      userEntity = await _userAuthenticationUseCase.signInUser(
        email: state.email,
        password: state.password,
      );
      isSuccess = true;
    } catch (exception) {
      if (exception is MusclesBuilderExceptions) {
        emit(
          state.copyWith(
            errorMessage: exception.message,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: exception.toString(),
          ),
        );
      }
    } finally {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: isSuccess,
          userEntity: userEntity,
        ),
      );
    }
  }
}
