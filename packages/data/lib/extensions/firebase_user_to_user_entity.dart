import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserExtensions on User {
  UserEntity toUserEntity(String authToken) {
    return UserEntity(
      uid,
      displayName ?? "Builder",
      email ?? "",
      photoURL ?? "",
      phoneNumber ?? "",
      isAnonymous,
      emailVerified,
      providerData.first.providerId,
      refreshToken ?? "",
      metadata.creationTime ?? DateTime.now(),
      metadata.lastSignInTime ?? DateTime.now(),
      true,
      authToken,
    );
  }
}
