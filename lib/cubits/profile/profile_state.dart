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
  const ProfileLoading(super.isEditing);

  @override
  List<Object> get props => [];
}

final class EditProfile extends ProfileState {
  final bool editProfile;

  const EditProfile(this.editProfile): super(editProfile);

  @override
  List<Object?> get props => [editProfile];
}