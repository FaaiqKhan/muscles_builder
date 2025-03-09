import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserProfileUsecase _userProfileUsecase;
  final UserAuthenticationUseCase _userAuthenticationUseCase;

  ProfileCubit(
    this._userProfileUsecase,
    this._userAuthenticationUseCase,
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

  void loadProfile() async {
    emit(
      const ProfileLoading(),
    );
    final UserEntity? userEntity = await _userAuthenticationUseCase.getUser();
    if (userEntity == null) {
      emit(
        const ProfileError(
          "Failed to load profile.",
        ),
      );
      return;
    }
    emit(
      ProfileLoaded(
        userEntity,
      ),
    );
  }
}
