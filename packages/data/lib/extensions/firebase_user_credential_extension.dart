import 'package:data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserCredentialExtension on UserCredential {
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
