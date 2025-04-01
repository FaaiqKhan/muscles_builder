import 'dart:async';

import 'package:data/data.dart';
import 'package:data/models/user_model.dart';

abstract interface class UserAuthenticationRepository {
  factory UserAuthenticationRepository() => UserAuthenticationRepositoryImpl();

  FutureOr<UserModel> signUpUser({
    required String email,
    required String password,
  });

  FutureOr<UserModel> signInUser({
    required String email,
    required String password,
  });

  FutureOr<bool> signOutUser();

  Future<UserModel?> getUser();
}
