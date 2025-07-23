import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../data/model/user_model.dart';
import '../../../../../data/services/auth/auth_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final AuthService _authService = AuthService();

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required bool isNotificationsEnabled,
    required String address,
    required String image,
  }) async {
    emit(SignUpLoading());

    try {
      // إنشاء المستخدم الجديد باستخدام AuthService
      final UserCredential userCredential = await _authService
          .createUserWithEmailAndPassword(email.trim(), password.trim());

      final User? user = userCredential.user;

      if (user == null) {
        emit(
          SignUpError('حدث خطأ أثناء إنشاء الحساب. يرجى المحاولة مرة أخرى.'),
        );
        return;
      }

      // حفظ بيانات المستخدم في Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(
            UserModel(
              name: name.trim(),
              email: email.trim(),
              userRole: 'customer',
              isNotificationsEnabled: isNotificationsEnabled,
              address: address.trim(),
              imageUrl: image.trim(),
            ).toJson(),
          );

      // إرسال رابط التحقق عبر البريد
      try {
        await user.sendEmailVerification();
        emit(
          SignUpSuccess(
            'تم إنشاء الحساب بنجاح. يرجى التحقق من بريدك الإلكتروني.',
          ),
        );
      } catch (_) {
        emit(
          SignUpError(
            'تم إنشاء الحساب، ولكن فشل إرسال رابط التحقق. يرجى المحاولة لاحقاً.',
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
            'تم إرسال العديد من الطلبات. يرجى الانتظار قبل المحاولة مجددًا.',
          ),
        );
      } else if (e.code == 'operation-not-allowed') {
        emit(SignUpError('العملية غير مسموح بها. تحقق من إعدادات Firebase.'));
      } else if (e.code == 'network-request-failed') {
        emit(
          SignUpNoInternet('لا يوجد اتصال بالإنترنت. يرجى المحاولة لاحقاً.'),
        );
      } else if (e.code == 'user-disabled') {
        emit(
          SignUpUserDisabled('تم تعطيل الحساب. يرجى التواصل مع الدعم الفني.'),
        );
      } else {
        emit(SignUpError('حدث خطأ غير معروف من Firebase. حاول لاحقاً.'));
      }
    } catch (e) {
      emit(SignUpError('حدث خطأ أثناء إنشاء الحساب. يرجى المحاولة لاحقاً.'));
    }
  }
}
