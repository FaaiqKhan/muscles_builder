part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {
  final AutovalidateMode autoValidateMode;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool obscureText;

  const SignUpState({
    this.autoValidateMode = AutovalidateMode.disabled,
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.obscureText = true,
  });

  SignUpState copyWith({
    AutovalidateMode? autoValidateMode,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? obscureText,
  });
}

class SignUpStateUpdate extends SignUpState {

  const SignUpStateUpdate({
    super.autoValidateMode,
    super.name,
    super.email,
    super.password,
    super.confirmPassword,
    super.obscureText,
  });

  @override
  SignUpStateUpdate copyWith({
    AutovalidateMode? autoValidateMode,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? obscureText,
  }) {
    return SignUpStateUpdate(
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}
