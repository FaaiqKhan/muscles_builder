import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity(
    this.uId,
    this.name,
    this.email,
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
  );

  final String uId;
  final String email;
  final String name;
  final String photoUrl;
  final String phoneNumber;
  final bool isAnonymous;
  final bool isEmailVerified;
  final String providerId;
  final String refreshToken;
  final DateTime creationTimestamp;
  final DateTime lastSignInTimestamp;
  final bool isNewUser;
  final String accessToken;

  @override
  List<Object?> get props => [
        uId,
        name,
        email,
        photoUrl,
        phoneNumber,
        isAnonymous,
        isEmailVerified,
        providerId,
        refreshToken,
        creationTimestamp,
        lastSignInTimestamp,
        isNewUser,
        accessToken,
      ];
}
