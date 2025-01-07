import 'dart:async';

import 'package:data/constants/constants.dart';
import 'package:data/models/user_model.dart';
import 'package:domain/domain.dart';
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
    } on FirebaseAuthException catch (authException) {
      switch (authException.code) {
        case AuthExceptions.userNotFound:
          throw UserNotFoundException();
        case AuthExceptions.wrongPassword:
          throw WrongPasswordException();
        default:
          throw GeneralException();
      }
    } catch (exception) {
      throw GeneralException(); // TODO: throw general exception and log using firebase analytics
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
    } on FirebaseAuthException catch (authException) {
      switch (authException.code) {
        case AuthExceptions.emailAlreadyInUse:
          throw EmailAlreadyExistException();
        case AuthExceptions.weekPassword:
          throw WeekPasswordException();
        case AuthExceptions.userTokenExpired:
          throw UserTokenExpiredException();
        case AuthExceptions.networkRequestFailed:
          throw NetworkRequestFailedException();
        default:
          throw GeneralException();
      }
    } catch (exception) {
      throw GeneralException(); // TODO: throw general exception and log using firebase analytics
    }
  }
}
