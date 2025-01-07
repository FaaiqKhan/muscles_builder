import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:flutter/widgets.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final UserAuthenticationUseCase _userAuthenticationUseCase;

  SignUpCubit(this._userAuthenticationUseCase)
      : super(const SignUpStateUpdate());

  void initForm({
    String name = '',
    String email = '',
    String password = '',
    String confirmPassword = '',
    bool isLoading = false,
    String? errorMessage,
    bool isSuccess = false,
  }) {
    emit(
      state.copyWith(
        name: name,
        email: email,
        password: password,
        confirmPassword: password,
        isLoading: false,
        errorMessage: null,
        isSuccess: isSuccess,
      ),
    );
  }

  void updateName(String? name) {
    emit(
      state.copyWith(
        name: name,
        errorMessage: null,
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

  void updateConfirmPassword(String? confirmPassword) {
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        errorMessage: null,
      ),
    );
  }

  void updateAutoValidateMode(AutovalidateMode? autoValidateMode) {
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
      const SignUpStateUpdate(
        errorMessage: null,
      ),
    );
  }

  void signUp() async {
    bool isSuccess = false;
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: isSuccess,
      ),
    );
    try {
      await _userAuthenticationUseCase.signUpUser(
        name: state.name,
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
          errorMessage: null,
          isSuccess: isSuccess,
        ),
      );
    }
  }
}
