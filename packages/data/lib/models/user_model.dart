class UserModel {
  const UserModel({
    this.uId,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.isAnonymous,
    this.isEmailVerified,
    this.providerId,
    this.refreshToken,
    this.creationTimestamp,
    this.lastSignInTimestamp,
    this.isNewUser,
    this.accessToken,
  });

  final String? uId;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final bool? isAnonymous;
  final bool? isEmailVerified;
  final String? providerId;
  final String? refreshToken;
  final int? creationTimestamp;
  final int? lastSignInTimestamp;
  final bool? isNewUser;
  final String? accessToken;
}
