import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mix_cafe_app/data/model/user_model.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final AuthService _authService = AuthService();

  Future<void> signUp(String email, String password, String name) async {
    emit(SignUpLoading());
    try {
      await _authService.createUserWithEmailAndPassword(
        email.trim(),
        password.trim(),
      );

      final uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(
            UserModel(
              name: name.trim(),
              email: email.trim(),
              userRole: 'customer',
            ).toJson(),
          );

      try {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        emit(
          SignUpSuccess(
            'تم إنشاء الحساب بنجاح. يرجى التحقق من بريدك الإلكتروني.',
          ),
        );
      } catch (e) {
        emit(
          SignUpError(
            'تم إنشاء الحساب بنجاح، ولكن لم يتم إرسال رابط التحقق. يرجى التحقق من بريدك الإلكتروني.',
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(SignUpInvalidEmail('البريد الإلكتروني غير صالح'));
      } else if (e.code == 'weak-password') {
        emit(SignUpWeakPassword('كلمة المرور ضعيفة جداً'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpEmailAlreadyInUse('البريد الإلكتروني مستخدم بالفعل'));
      } else if (e.code == 'too-many-requests') {
        emit(
          SignUpError(
            'تم إرسال رابط التحقق مسبقاً. يرجى الانتظار قبل المحاولة مرة أخرى.',
          ),
        );
      } else if (e.code == 'operation-not-allowed') {
        emit(
          SignUpError(
            'العملية غير مسموح بها. يرجى التحقق من إعدادات Firebase.',
          ),
        );
      } else if (e.code == 'network-request-failed') {
        emit(
          SignUpNoInternet(
            'لا يوجد اتصال بالإنترنت. يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.',
          ),
        );
      } else if (e.code == 'user-disabled') {
        emit(SignUpUserDisabled('تم تعطيل الحساب. يرجى الاتصال بالدعم الفني.'));
      } else if (e.code == 'unknown') {
        emit(SignUpError('حدث خطأ غير معروف. يرجى المحاولة مرة أخرى لاحقاً.'));
      } else {
        emit(
          SignUpError(
            'حدث خطأ أثناء إرسال رابط التحقق. يرجى المحاولة مرة أخرى لاحقاً.',
          ),
        );
      }
    } catch (e) {
      emit(
        SignUpError(
          'حدث خطأ أثناء إنشاء الحساب. يرجى المحاولة مرة أخرى لاحقاً.',
        ),
      );
    }
  }
}
