part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {
  final String email;
  final String password;
  final bool obscureText;
  final AutovalidateMode autoValidateMode;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const SignInState({
    this.email = '',
    this.password = '',
    this.obscureText = true,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? obscureText,
    AutovalidateMode? autoValidateMode,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  });
}

class SignInStateUpdate extends SignInState {
  const SignInStateUpdate({
    super.email,
    super.password,
    super.obscureText,
    super.autoValidateMode,
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
  });

  @override
  SignInStateUpdate copyWith({
    String? email,
    String? password,
    bool? obscureText,
    AutovalidateMode? autoValidateMode,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return SignInStateUpdate(
      email: email ?? this.email,
      password: password ?? this.password,
      obscureText: obscureText ?? this.obscureText,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
