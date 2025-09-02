import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  final AuthService authService = AuthService();

  Future<void> signOut() async {
    emit(SettingsSignOutLoading());
    try {
      await authService.signOut();
      emit(SettingsSignOutSuccess('Logged Out Successfully'));
    } catch (e) {
      emit(SettingsSignOutError('Failed To Log Out'));
    }
  }
}
