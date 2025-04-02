part of 'user_authentication_bloc.dart';

sealed class UserAuthenticationEvent extends Equatable {
  const UserAuthenticationEvent();
}

class UserAuthorized extends UserAuthenticationEvent {
  final UserEntity user;

  const UserAuthorized(this.user);

  @override
  List<Object?> get props => [
        user,
      ];
}

class UserUnauthorized extends UserAuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SignOut extends UserAuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SignIn extends UserAuthenticationEvent {
  final String email;
  final String password;

  const SignIn(this.email, this.password);

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
