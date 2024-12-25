import 'dart:async';

import 'package:domain/repositories/user_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthenticationRepositoryImpl extends UserAuthenticationRepository {
  UserAuthenticationRepositoryImpl();

  @override
  FutureOr<UserCredential> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } catch (exception) {
      rethrow;
    }
  }

  @override
  FutureOr<UserCredential> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (exception) {
      if (exception is FirebaseAuthException) {
        rethrow;
      }
      rethrow;
    }
  }
}
