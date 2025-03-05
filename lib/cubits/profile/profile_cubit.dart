import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial(false));

  void toggleEditing() {
    print(state.isEditing);
    emit(
      EditProfile(!state.isEditing)
    );
  }
}
