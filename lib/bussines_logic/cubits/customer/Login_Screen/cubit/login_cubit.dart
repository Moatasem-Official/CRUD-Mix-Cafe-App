import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final _authService = AuthService();

  void login(String email, String password) async {
    try {
      emit(LoginLoading());
      await _authService.signInWithEmailAndPassword(
        email.trim(),
        password.trim(),
      );

      await FirebaseAuth.instance.currentUser!.reload();
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw FirebaseAuthException(code: 'user-not-found');
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final role = userDoc.data()?['userRole'];

      if (!userDoc.exists || role != 'customer') {
        await FirebaseAuth.instance.signOut();
        throw FirebaseAuthException(code: 'invalid-credential');
      }

      if (!user.emailVerified) {
        await FirebaseAuth.instance.signOut();
        emit(LoginUserNotVerified('يرجى التحقق من بريدك الإلكتروني'));

        // إعادة إرسال التفعيل
        await user.sendEmailVerification();

        return;
      }

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginNoUser('لم يتم العثور على المستخدم'));
      } else if (e.code == 'invalid-credential') {
        emit(LoginError('البريد الإلكتروني أو كلمة المرور غير صحيحة'));
      } else if (e.code == 'user-disabled') {
        emit(LoginError('حسابك محظور. يرجى التواصل مع المسئول'));
      } else if (e.code == 'too-many-requests') {
        emit(LoginError('تم الحظر من الدخول بسبب الحاجة للتحقق'));
      } else if (e.code == 'email-already-in-use') {
        emit(LoginError('البريد الألكتروني مستخدم بالفعل'));
      } else if (e.code == 'invalid-email') {
        emit(LoginError('البريد الألكتروني غير صحيح'));
      } else if (e.code == 'operation-not-allowed') {
        emit(LoginError('البريد الألكتروني غير صحيح'));
      } else if (e.code == 'network-request-failed') {
        emit(LoginError('تحقق من اتصالك بالانترنت'));
      } else if (e.code == 'user-already-exists') {
        emit(LoginError('المستخدم موجود بالفعل'));
      } else if (e.code == 'invalid-credential' || e.code == 'wrong-password') {
        emit(
          LoginWrongEmailOrPassword(
            'البريد الإلكتروني أو كلمة المرور غير صحيحة',
          ),
        );
      } else {
        emit(LoginUnknownError('حدث خطأ غير معروف. يرجى المحاولة لاحقًا'));
      }
    } catch (_) {
      emit(LoginError('حدث خطاء ما. يرجى المحاولة لاحقًا'));
    }
  }
}
