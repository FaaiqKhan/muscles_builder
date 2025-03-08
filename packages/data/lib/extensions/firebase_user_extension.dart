import 'package:data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserExtension on User {
  Future<UserModel> toUserModel(String accessToken, bool isNewUser) async {
    return UserModel(
      uId: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoURL,
      phoneNumber: phoneNumber,
      isAnonymous: isAnonymous,
      isEmailVerified: emailVerified,
      providerId: providerData.first.providerId,
      refreshToken: refreshToken,
      creationTimestamp: metadata.creationTime?.millisecondsSinceEpoch,
      lastSignInTimestamp:
          metadata.lastSignInTime?.millisecondsSinceEpoch,
      isNewUser: isNewUser,
      accessToken: accessToken,
    );
  }
}