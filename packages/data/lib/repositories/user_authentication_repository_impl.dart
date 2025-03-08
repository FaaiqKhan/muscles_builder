import 'dart:async';

import 'package:data/constants/constants.dart';
import 'package:data/extensions/firebase_user_extension.dart';
import 'package:data/models/user_model.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthenticationRepositoryImpl implements UserAuthenticationRepository {
  UserAuthenticationRepositoryImpl();

  @override
  FutureOr<UserModel> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final String accessToken = (await userCredential.user!.getIdToken())!;

      return await userCredential.user!.toUserModel(
        accessToken,
        userCredential.additionalUserInfo?.isNewUser ?? true,
      );
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
      throw GeneralException();
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
      final String accessToken = (await userCredential.user!.getIdToken())!;
      return userCredential.user!.toUserModel(
        accessToken,
        userCredential.additionalUserInfo?.isNewUser ?? true,
      );
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
      throw GeneralException();
    }
  }

  @override
  FutureOr<bool> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (_) {}
    return false;
  }

  @override
  Future<UserModel?> getUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    String accessToken = (await user.getIdToken())!;
    return user.toUserModel(accessToken, false);
  }
}
