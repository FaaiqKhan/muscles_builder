import 'dart:async';

import 'package:data/constants/constants.dart';
import 'package:data/extensions/firebase_user_credential_extension.dart';
import 'package:data/extensions/firebase_user_to_user_entity.dart';
import 'package:data/models/user_model.dart';
import 'package:domain/domain.dart';
import 'package:domain/repositories/user_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthenticationRepositoryImpl implements UserAuthenticationRepository {
  UserAuthenticationRepositoryImpl();

  StreamSubscription<User?>? userSubscription;
  StreamController<UserEntity?> userController =
      StreamController<UserEntity?>();

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

  @override
  FutureOr<void> signOutUser() async {
    await userSubscription?.cancel();
    await FirebaseAuth.instance.signOut();
  }

  @override
  StreamController<UserEntity?> getUser() {
    userSubscription?.cancel();
    userSubscription = FirebaseAuth.instance.authStateChanges().listen(
      (user) async {
        if (user == null) {
          userController.sink;
        } else {
          final token = await user.getIdToken();
          if (token == null) {
            userController.sink;
          } else {
            userController.sink.addStream(
              Stream.value(
                user.toUserEntity(token),
              ),
            );
          }
        }
      },
    );
    return userController;
  }
}
