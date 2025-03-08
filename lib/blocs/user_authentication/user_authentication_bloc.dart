import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'user_authentication_event.dart';
part 'user_authentication_state.dart';

class UserAuthenticationBloc
    extends Bloc<UserAuthenticationEvent, UserAuthenticationState> {
  UserAuthenticationBloc() : super(const UserUnauthorizedState()) {
    on<UserAuthorized>(_onUserAuthorized);
    on<UserUnauthorized>(_onUserUnauthorized);
  }

  void _onUserAuthorized(
    UserAuthorized event,
    Emitter<UserAuthenticationState> emit,
  ) {
    emit(
      UserAuthorizedState(
        event.user,
      ),
    );
  }

  void _onUserUnauthorized(
    UserUnauthorized event,
    Emitter<UserAuthenticationState> emit,
  ) {
    emit(
      const UserUnauthorizedState(),
    );
  }
}
