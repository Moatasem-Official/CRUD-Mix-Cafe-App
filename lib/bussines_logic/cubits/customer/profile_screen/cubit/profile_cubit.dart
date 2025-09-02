import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final AuthService authService = AuthService();

  Future<void> signOut() async {
    emit(ProfileSignOutLoading());
    try {
      await authService.signOut();
      emit(ProfileSignOutSuccess('Logged Out Successfully'));
    } catch (e) {
      emit(ProfileSignOutError('Failed To Log Out'));
    }
  }
}
