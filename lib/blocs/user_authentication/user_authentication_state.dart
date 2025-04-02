part of 'user_authentication_bloc.dart';

sealed class UserAuthenticationState extends Equatable {
  const UserAuthenticationState();
}

final class UserUnauthorizedState extends UserAuthenticationState {
  const UserUnauthorizedState();

  @override
  List<Object> get props => [];
}

final class UserAuthorizedState extends UserAuthenticationState {
  final UserEntity user;

  const UserAuthorizedState(this.user);

  @override
  List<Object?> get props => [
        user,
      ];
}

final class LoadingState extends UserAuthenticationState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}
