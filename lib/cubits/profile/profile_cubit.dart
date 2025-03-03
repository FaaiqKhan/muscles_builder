import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial(false));

  void enableEditing() {
    emit(
      const EditProfile(true),
    );
  }

  void disableEditing() {
    emit(
      const EditProfile(false),
    );
  }
}
