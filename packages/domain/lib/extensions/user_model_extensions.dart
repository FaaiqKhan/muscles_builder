import 'package:data/models/user_model.dart';
import 'package:domain/domain.dart';

extension UserModelExtensions on UserModel {
  UserEntity toUserEntity() {
    final DateTime creationTimestamp;
    if (this.creationTimestamp == null) {
      creationTimestamp = DateTime.now();
    } else {
      creationTimestamp = DateTime.fromMillisecondsSinceEpoch(
        this.creationTimestamp!,
      );
    }
    final DateTime lastSignInTimestamp;
    if (this.lastSignInTimestamp == null) {
      lastSignInTimestamp = DateTime.now();
    } else {
      lastSignInTimestamp = DateTime.fromMillisecondsSinceEpoch(
        this.lastSignInTimestamp!,
      );
    }
    return UserEntity(
      uId: uId!,
      name: displayName ?? "",
      email: email!,
      photoUrl: photoUrl ?? "",
      phoneNumber: phoneNumber ?? "",
      isAnonymous: isAnonymous ?? true,
      isEmailVerified: isEmailVerified ?? false,
      providerId: providerId ?? "",
      refreshToken: refreshToken ?? "",
      creationTimestamp: creationTimestamp,
      lastSignInTimestamp: lastSignInTimestamp,
      isNewUser: isNewUser ?? true,
      accessToken: accessToken ?? "",
    );
  }
}
