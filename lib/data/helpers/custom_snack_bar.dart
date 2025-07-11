import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
    required String message,
    required String title,
    ContentType contentType = ContentType.success,
  }) : super(
         content: AwesomeSnackbarContent(
           title: title,
           message: message,
           contentType: contentType,
         ),
         behavior: SnackBarBehavior.floating,
         backgroundColor: Colors.transparent,
         elevation: 0,
       );
}
