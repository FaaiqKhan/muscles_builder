import 'dart:async';

import 'package:data/models/user_model.dart';
import 'package:domain/repositories/user_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthenticationRepositoryImpl extends UserAuthenticationRepository {
  UserAuthenticationRepositoryImpl();

  @override
  FutureOr<UserModel> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.toUserModel();
    } catch (exception) {
      rethrow;
    }
  }

  @override
  FutureOr<UserModel> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.toUserModel();
    } catch (exception) {
      rethrow;
    }
  }
}
