import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String accessToken;

  const UserEntity(
    this.name,
    this.email,
    this.accessToken,
  );

  @override
  List<Object?> get props => [
        name,
        email,
        accessToken,
      ];
}
