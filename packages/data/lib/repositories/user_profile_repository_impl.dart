import 'package:domain/repositories/user_profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  @override
  Future<bool> updateEmail(String email) async {
    try {
      await FirebaseAuth.instance.currentUser?.verifyBeforeUpdateEmail(email);
      return true;
    } catch (_) {}
    return false;
  }

  @override
  Future<bool> updateName(String name) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      return true;
    } catch (_) {}
    return false;
  }

  @override
  Future<bool> updatePhoneNumber(String phoneNumber) async {
    return false;
  }

  @override
  Future<bool> updateProfilePicture(String imagePath) async {
    return false;
  }
}
