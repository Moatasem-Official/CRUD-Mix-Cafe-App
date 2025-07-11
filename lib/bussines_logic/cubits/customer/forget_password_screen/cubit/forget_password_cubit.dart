import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final AuthService _authService = AuthService();

  Future<void> sendResetLink(String email) async {
    emit(ForgetPasswordLoading());
    try {
      await _authService.sendPasswordResetEmail(email.trim());

      emit(
        ForgetPasswordSuccess(
          "تم إرسال رابط إعادة تعيين كلمة المرور إلى $email",
        ),
      );
      await Future.delayed(Duration(seconds: 2));
      emit(ForgetPasswordInitial());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(ForgetPasswordInvalidEmail("البريد الإلكتروني غير صالح"));
        await Future.delayed(Duration(seconds: 2));
        emit(ForgetPasswordInitial());
      } else if (e.code == 'user-not-found') {
        emit(ForgetPasswordError("لا يوجد مستخدم مرتبط بهذا البريد"));
        await Future.delayed(Duration(seconds: 2));
        emit(ForgetPasswordInitial());
      } else {
        emit(ForgetPasswordError("حدث خطأ: ${e.message}"));
        await Future.delayed(Duration(seconds: 2));
        emit(ForgetPasswordInitial());
      }
    } on SocketException {
      emit(ForgetPasswordNoInternet("لا يوجد اتصال بالإنترنت"));
      await Future.delayed(Duration(seconds: 2));
      emit(ForgetPasswordInitial());
    } on TimeoutException {
      emit(ForgetPasswordError("انتهت مهلة الطلب. حاول مرة أخرى لاحقًا."));
      await Future.delayed(Duration(seconds: 2));
      emit(ForgetPasswordInitial());
    } catch (e) {
      emit(ForgetPasswordError("حدث خطأ غير متوقع: ${e.toString()}"));
      await Future.delayed(Duration(seconds: 2));
      emit(ForgetPasswordInitial());
    }
  }
}
