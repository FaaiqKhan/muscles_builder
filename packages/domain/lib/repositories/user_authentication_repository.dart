import 'dart:async';

import 'package:domain/domain.dart';

abstract class UserAuthenticationRepository {
  FutureOr<void> signUpUser({
    required String email,
    required String password,
  });

  FutureOr<void> signInUser({
    required String email,
    required String password,
  });

  FutureOr<void> signOutUser();

  StreamController<UserEntity?> getUser();
}
