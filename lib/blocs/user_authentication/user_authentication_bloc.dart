import 'dart:async';

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

    _userSubscription =
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

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  final UserAuthenticationUseCase _userAuthenticationUseCase;
  StreamSubscription<UserEntity?>? _userSubscription;

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
