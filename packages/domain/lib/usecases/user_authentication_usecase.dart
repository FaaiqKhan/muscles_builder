import 'dart:async';

import 'package:domain/domain.dart';

import '../repositories/user_authentication_repository.dart';

abstract interface class UserAuthenticationUseCase {
  factory UserAuthenticationUseCase(
    UserAuthenticationRepository userAuthenticationRepository,
  ) =>
      _UserAuthenticationUseCaseImpl(userAuthenticationRepository);

  FutureOr<void> signUpUser({
    required String email,
    required String password,
  });

  FutureOr<void> signInUser({
    required String email,
    required String password,
  });

  StreamController<UserEntity?> getUser();
}

class _UserAuthenticationUseCaseImpl implements UserAuthenticationUseCase {
  final UserAuthenticationRepository _userAuthenticationRepository;

  _UserAuthenticationUseCaseImpl(this._userAuthenticationRepository);

  @override
  FutureOr<void> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      await _userAuthenticationRepository.signInUser(
        email: email,
        password: password,
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  FutureOr<void> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      await _userAuthenticationRepository.signUpUser(
        email: email,
        password: password,
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  StreamController<UserEntity?> getUser() =>
      _userAuthenticationRepository.getUser();
}
