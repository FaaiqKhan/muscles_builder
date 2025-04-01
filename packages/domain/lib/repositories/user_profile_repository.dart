import 'package:data/repositories/user_profile_repository_impl.dart';

abstract interface class UserProfileRepository {
  factory UserProfileRepository() => UserProfileRepositoryImpl();

  Future<bool> updateName(String name);

  Future<bool> updateEmail(String email);

  Future<bool> updatePhoneNumber(String phoneNumber);

  Future<void> updateProfilePicture(String imagePath);
}
