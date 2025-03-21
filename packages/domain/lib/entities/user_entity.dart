import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.uId,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.phoneNumber,
    required this.isAnonymous,
    required this.isEmailVerified,
    required this.providerId,
    required this.refreshToken,
    required this.creationTimestamp,
    required this.lastSignInTimestamp,
    required this.isNewUser,
    required this.accessToken,
  });

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
