import 'dart:async';

abstract class UserAuthenticationRepository {
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
