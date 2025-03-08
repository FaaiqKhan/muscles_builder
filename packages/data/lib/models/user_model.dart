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
