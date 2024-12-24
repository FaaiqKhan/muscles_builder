part of 'join_us_cubit.dart';

@immutable
abstract class JoinUsState {
  final AutovalidateMode autoValidateMode;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool obscureText;

  const JoinUsState({
    this.autoValidateMode = AutovalidateMode.disabled,
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.obscureText = true,
  });

  JoinUsState copyWith({
    AutovalidateMode? autoValidateMode,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? obscureText,
  });
}

class JoinUsUpdate extends JoinUsState {

  const JoinUsUpdate({
    super.autoValidateMode,
    super.name,
    super.email,
    super.password,
    super.confirmPassword,
    super.obscureText,
  });

  @override
  JoinUsUpdate copyWith({
    AutovalidateMode? autoValidateMode,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? obscureText,
  }) {
    return JoinUsUpdate(
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}
