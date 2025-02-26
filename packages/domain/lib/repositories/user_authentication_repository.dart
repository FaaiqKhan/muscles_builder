import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';

abstract interface class UserAuthenticationRepository {
  factory UserAuthenticationRepository() => UserAuthenticationRepositoryImpl();

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
