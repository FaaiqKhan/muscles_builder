part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {
  final String email;
  final String password;
  final bool obscureText;
  final AutovalidateMode autoValidateMode;

  const SignInState({
    this.email = '',
    this.password = '',
    this.obscureText = true,
    this.autoValidateMode = AutovalidateMode.disabled,
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? obscureText,
    AutovalidateMode? autoValidateMode,
  });
}

class SignInStateUpdate extends SignInState {
  const SignInStateUpdate({
    super.email,
    super.password,
    super.obscureText,
    super.autoValidateMode,
  });

  @override
  SignInStateUpdate copyWith({
    String? email,
    String? password,
    bool? obscureText,
    AutovalidateMode? autoValidateMode,
  }) {
    return SignInStateUpdate(
      email: email ?? this.email,
      password: password ?? this.password,
      obscureText: obscureText ?? this.obscureText,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }
}
