import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class ErrorsHandler {
  static void showSignUpError(BuildContext context, String error) {
    String message;
    switch (error) {
      case 'weak-password':
        message = 'كلمة المرور ضعيفة جدًا';
        break;
      case 'email-already-in-use':
        message = 'يوجد حساب مسجل بهذا البريد بالفعل';
        break;
      case 'invalid-email':
        message = 'البريد الإلكتروني غير صالح';
        break;
      case 'operation-not-allowed':
        message = 'لا يُسمح بهذه العملية';
        break;
      case 'user-disabled':
        message = 'تم تعطيل هذا المستخدم';
        break;
      case 'user-not-found':
        message = 'لم يتم العثور على المستخدم';
        break;
      default:
        message = 'حدث خطأ ما. حاول مرة أخرى لاحقًا';
    }

    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'خطأ في التسجيل',
        message: message, // Use the localized message here
        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSignInError(BuildContext context, String error) {
    String message;
    switch (error) {
      case 'invalid-email':
        message = 'البريد الإلكتروني غير صالح';
        break;
      case 'user-disabled':
        message = 'تم تعطيل هذا المستخدم';
        break;
      case 'user-not-found':
        message = 'لم يتم العثور على المستخدم';
        break;
      case 'wrong-password':
        message = 'كلمة المرور غير صحيحة';
        break;
      case 'operation-not-allowed':
        message = 'لا يُسمح بهذه العملية';
        break;
      default:
        message = 'حدث خطأ ما. حاول مرة أخرى لاحقًا';
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
