import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../bussines_logic/cubits/admin/login_screen/cubit/log_in_cubit_cubit.dart';
import '../../../data/helpers/custom_snack_bar.dart';
import '../../widgets/admin/Login_Screen/admin_login_screen_content.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: BlocConsumer<LogInCubitCubit, LogInCubitState>(
            listener: (context, state) {
              if (state is LogInCubitLoading) {
                setState(() {
                  isLoading = true;
                });
              } else {
                setState(() {
                  isLoading = false;
                });
              }

              if (state is LogInCubitSuccess) {
                final successSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'نجاح تسجيل الدخول',
                  contentType: ContentType.success,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(successSnackBar);
                Navigator.pushReplacementNamed(context, '/adminHomeScreen');
              } else if (state is LogInCubitError) {
                final failureSnackBar = CustomSnackBar(
                  message: state.error,
                  title: 'خطأ في تسجيل الدخول',
                  contentType: ContentType.failure,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(failureSnackBar);
              } else if (state is LogInCubitNoInternet) {
                final noInternetSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'لا يوجد اتصال بالإنترنت',
                  contentType: ContentType.warning,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(noInternetSnackBar);
              } else if (state is LogInCubitWrongEmailOrPassword) {
                final emailOrPasswordFailureSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'خطأ في البريد الإلكتروني أو كلمة المرور',
                  contentType: ContentType.failure,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(emailOrPasswordFailureSnackBar);
              } else if (state is LogInCubitWrongEmailAndPassword) {
                final emailAndPasswordFailureSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'خطأ في البريد الإلكتروني وكلمة المرور',
                  contentType: ContentType.failure,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(emailAndPasswordFailureSnackBar);
              }
            },
            builder: (context, state) {
              return AdminLoginScreenContent(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
                onLogin: () {
                  if (formKey.currentState!.validate()) {
                    context.read<LogInCubitCubit>().logIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  }
                },
              );
            },
          ),
        ),
        if (isLoading)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: Center(
                  child: Lottie.asset(
                    'assets/animations/Animation - 1751639954708.json',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
