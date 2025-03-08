import 'dart:async';

import 'package:data/models/user_model.dart';
import 'package:domain/domain.dart';

abstract interface class UserAuthenticationUseCase {
  factory UserAuthenticationUseCase(
    UserAuthenticationRepository userAuthenticationRepository,
  ) =>
      _UserAuthenticationUseCaseImpl(userAuthenticationRepository);

  FutureOr<UserEntity> signUpUser({
    required String email,
    required String password,
  });

  FutureOr<UserEntity> signInUser({
    required String email,
    required String password,
  });

  FutureOr<bool> signOutUser();

  FutureOr<UserEntity?> getUser();
}

class _UserAuthenticationUseCaseImpl implements UserAuthenticationUseCase {
  final UserAuthenticationRepository _userAuthenticationRepository;

  _UserAuthenticationUseCaseImpl(this._userAuthenticationRepository);

  @override
  FutureOr<UserEntity> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      UserModel userModel = await _userAuthenticationRepository.signInUser(
        email: email,
        password: password,
      );
      return userModel.toUserEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  FutureOr<UserEntity> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      UserModel userModel = await _userAuthenticationRepository.signUpUser(
        email: email,
        password: password,
      );
      return userModel.toUserEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  FutureOr<bool> signOutUser() async {
    try {
      return await _userAuthenticationRepository.signOutUser();
    } catch (_) {}
    return false;
  }

  @override
  FutureOr<UserEntity?> getUser() async {
    UserModel? userModel = await _userAuthenticationRepository.getUser();
    return userModel?.toUserEntity();
  }
}
