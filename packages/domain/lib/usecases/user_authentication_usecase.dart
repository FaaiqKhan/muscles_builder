import 'dart:async';

import '../repositories/user_authentication_repository.dart';

abstract class UserAuthenticationUseCase {
  FutureOr<void> signUpUser({
    required String name,
    required String email,
    required String password,
  });

  FutureOr<void> signInUser({
    required String email,
    required String password,
  });
}

class UserAuthenticationUseCaseImpl implements UserAuthenticationUseCase {
  final UserAuthenticationRepository userAuthenticationRepository;

  UserAuthenticationUseCaseImpl(this.userAuthenticationRepository);

  @override
  FutureOr<void> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      await userAuthenticationRepository.signInUser(
        email: email,
        password: password,
      );
    } catch (exception) {
      rethrow;
    }
  }

  @override
  FutureOr<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    await userAuthenticationRepository.signUpUser(
      name: name,
      email: email,
      password: password,
    );
  }
}
