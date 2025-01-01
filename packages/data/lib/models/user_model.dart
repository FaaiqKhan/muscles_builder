import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  const UserModel({
    required this.uId,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    required this.isAnonymous,
    required this.isEmailVerified,
    this.providerId,
    this.refreshToken,
    required this.creationTimestamp,
    required this.lastSignInTimestamp,
    required this.isNewUser,
  });

  final String uId;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final bool isAnonymous;
  final bool isEmailVerified;
  final String? providerId;
  final String? refreshToken;
  final int? creationTimestamp;
  final int? lastSignInTimestamp;
  final bool isNewUser;
}

extension UserModelParser on UserCredential {
  UserModel toUserModel() {
    return UserModel(
      uId: user!.uid,
      email: user!.email,
      displayName: user!.displayName,
      photoUrl: user!.photoURL,
      phoneNumber: user!.phoneNumber,
      isAnonymous: user!.isAnonymous,
      isEmailVerified: user!.emailVerified,
      providerId: user!.providerData.first.providerId,
      refreshToken: user!.refreshToken,
      creationTimestamp: user!.metadata.creationTime?.millisecondsSinceEpoch,
      lastSignInTimestamp:
          user!.metadata.lastSignInTime?.millisecondsSinceEpoch,
      isNewUser: additionalUserInfo!.isNewUser,
    );
  }
}
