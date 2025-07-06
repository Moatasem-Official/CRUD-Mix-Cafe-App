import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/services/auth/errors_handler.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      ErrorsHandler.showSignInError(context, e.code);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ ما. يرجى المحاولة لاحقًا')),
      );
    }
  }

  Future<void> createUserWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ErrorsHandler.showSignUpError(context, e.code);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ ما. يرجى المحاولة لاحقًا')),
      );
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> sendPasswordResetEmail(
    BuildContext context,
    String email,
  ) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      const snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'تم إرسال رابط إعادة تعيين كلمة المرور',
          message:
              'إذا كان البريد مسجل لدينا، سيتم إرسال رابط إعادة تعيين كلمة المرور',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } catch (e) {
      const snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'خطأ في إرسال رابط إعادة تعيين كلمة المرور',
          message:
              'حدث خطأ أثناء محاولة إرسال رابط إعادة تعيين كلمة المرور. يرجى المحاولة مرة أخرى لاحقًا',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();
    }
  }

  Future<void> updatePassword(String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
    }
  }

  Future<void> updateEmail(String newEmail) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateEmail(newEmail);
    }
  }

  Future<void> updateDisplayName(String newDisplayName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: newDisplayName);
    }
  }

  Future<void> updatePhotoURL(String newPhotoURL) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePhotoURL(newPhotoURL);
    }
  }

  Future<void> reload() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
    }
  }

  User? get currentUser => _auth.currentUser;
}
