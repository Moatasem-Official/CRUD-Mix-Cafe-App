import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';

part 'log_in_cubit_state.dart';

class LogInCubitCubit extends Cubit<LogInCubitState> {
  LogInCubitCubit() : super(LogInCubitInitial());

  void logIn({required String email, required String password}) async {
    emit(LogInCubitLoading());

    try {
      final authService = AuthService();

      // تسجيل الدخول بالبريد والباسورد
      await authService.signInWithEmailAndPassword(email, password);

      final user = authService.currentUser;

      if (user == null) {
        throw FirebaseAuthException(code: 'user-not-found');
      }

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        await authService.signOut();
        throw FirebaseAuthException(code: 'user-not-found');
      }

      final role = doc.data()?['userRole'];

      if (role != 'admin') {
        await authService.signOut();
        throw FirebaseAuthException(code: 'invalid-credential');
      }

      emit(LogInCubitSuccess('تم تسجيل الدخول بنجاح كمسؤول'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed' || e.code == 'no-internet') {
        emit(LogInCubitNoInternet('لا يوجد اتصال بالإنترنت'));
      } else if (e.code == 'user-not-found') {
        emit(LogInCubitError('المستخدم غير موجود'));
      } else if (e.code == 'invalid-credential' || e.code == 'wrong-password') {
        emit(
          LogInCubitWrongEmailOrPassword(
            'البريد الإلكتروني أو كلمة المرور غير صحيحة',
          ),
        );
      } else {
        emit(
          LogInCubitError('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى لاحقًا'),
        );
      }
    } catch (_) {
      emit(LogInCubitError('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى لاحقًا'));
    }
  }
}
