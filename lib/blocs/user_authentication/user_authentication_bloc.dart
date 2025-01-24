import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'user_authentication_event.dart';
part 'user_authentication_state.dart';

class UserAuthenticationBloc
    extends Bloc<UserAuthenticationEvent, UserAuthenticationState> {
  UserAuthenticationBloc(this._userAuthenticationUseCase)
      : super(const UserUnauthorizedState()) {
    on<UserAuthorized>(_onUserAuthorized);
    on<UserUnauthorized>(_onUserUnauthorized);

    _userAuthenticationUseCase.getUser().stream.listen((user) {
      if (user == null) {
        add(
          UserUnauthorized(),
        );
      } else {
        add(
          UserAuthorized(
            user,
          ),
        );
      }
    });
  }

  final UserAuthenticationUseCase _userAuthenticationUseCase;

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
