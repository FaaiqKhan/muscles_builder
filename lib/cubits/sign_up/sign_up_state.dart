part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {
  final AutovalidateMode autoValidateMode;
  final String email;
  final String password;
  final String confirmPassword;
  final bool obscureText;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const SignUpState({
    this.autoValidateMode = AutovalidateMode.disabled,
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.obscureText = true,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  SignUpState copyWith({
    AutovalidateMode? autoValidateMode,
    String? email,
    String? password,
    String? confirmPassword,
    bool? obscureText,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  });
}

class SignUpStateUpdate extends SignUpState {

  const SignUpStateUpdate({
    super.autoValidateMode,
    super.email,
    super.password,
    super.confirmPassword,
    super.obscureText,
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
  });

  @override
  SignUpStateUpdate copyWith({
    AutovalidateMode? autoValidateMode,
    String? email,
    String? password,
    String? confirmPassword,
    bool? obscureText,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return SignUpStateUpdate(
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      email: email ?? this.email,
      password: password ?? this.password,
      obscureText: obscureText ?? this.obscureText,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
