part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  final bool isEditing;

  const ProfileState(this.isEditing);
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial(super.isEditing);

  @override
  List<Object> get props => [];
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading() : super(false);

  @override
  List<Object> get props => [];
}

final class ProfileLoaded extends ProfileState {
  final UserEntity userEntity;

  const ProfileLoaded(this.userEntity) : super(false);

  @override
  List<Object> get props => [
        userEntity,
      ];
}

final class EditProfile extends ProfileState {
  final bool editProfile;

  const EditProfile(this.editProfile) : super(editProfile);

  @override
  List<Object?> get props => [editProfile];
}

final class ProfileError extends ProfileState {
  final String errorMessage;

  const ProfileError(this.errorMessage) : super(false);

  @override
  List<Object?> get props => [errorMessage];
}
