import 'package:domain/domain.dart';
import 'package:domain/repositories/user_profile_repository.dart';

abstract interface class UserProfileUsecase {
  factory UserProfileUsecase(UserProfileRepository userProfileRepository) =>
      _UserProfileUsecaseImpl(userProfileRepository);

  Future<UserEntity> getUser();

  Future<bool> updateProfile({
    required String name,
    required String email,
    required String phoneNumber,
  });
}

class _UserProfileUsecaseImpl implements UserProfileUsecase {
  final UserProfileRepository _userProfileRepository;

  _UserProfileUsecaseImpl(this._userProfileRepository);

  @override
  Future<bool> updateProfile({
    required String name,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      await _userProfileRepository.updateName(name);
      return true;
    } catch (_) {}
    return false;
  }

  @override
  Future<UserEntity> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
