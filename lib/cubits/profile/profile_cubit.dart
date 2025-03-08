import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserProfileUsecase _userProfileUsecase;

  ProfileCubit(
    this._userProfileUsecase,
  ) : super(const ProfileInitial(false));

  void toggleEditing() {
    emit(
      EditProfile(
        !state.isEditing,
      ),
    );
  }

  void updateProfile({
    required String name,
    required String email,
    required String phoneNumber,
  }) {
    _userProfileUsecase.updateProfile(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
