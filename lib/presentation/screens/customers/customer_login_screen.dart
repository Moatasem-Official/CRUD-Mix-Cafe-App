import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/Login_Screen/cubit/login_cubit.dart';
import 'package:mix_cafe_app/data/helpers/custom_snack_bar.dart';
import 'package:mix_cafe_app/data/helpers/when_loading_widget.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_login_screen_content/customer_login_screen_content.dart';
import '../../../data/services/auth/auth_service.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFFFFCF9),
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFFCF9),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: true,
          ),
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is LoginSuccess) {
                setState(() {
                  isLoading = false;
                });
                final successSnackBar = CustomSnackBar(
                  message: 'Login Successful',
                  title: 'Success',
                  contentType: ContentType.success,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(successSnackBar);
                Navigator.of(
                  context,
                ).pushReplacementNamed('/customerShowProductDetails');
              } else if (state is LoginError) {
                setState(() {
                  isLoading = false;
                });
                final failureSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'Login Error',
                  contentType: ContentType.failure,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(failureSnackBar);
              } else if (state is LoginNoInternet) {
                setState(() {
                  isLoading = false;
                });
                final noInternetSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'No Internet Connection',
                  contentType: ContentType.warning,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(noInternetSnackBar);
              } else if (state is LoginNoUser) {
                setState(() {
                  isLoading = false;
                });
                final noUserSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'User Not Found',
                  contentType: ContentType.failure,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(noUserSnackBar);
              } else if (state is LoginUserNotVerified) {
                setState(() {
                  isLoading = false;
                });
                final userNotVerifiedSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'User Not Verified',
                  contentType: ContentType.warning,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(userNotVerifiedSnackBar);
                // إعادة إرسال رابط التحقق
                _authService.sendEmailVerification();
              } else if (state is LoginWrongEmailOrPassword) {
                setState(() {
                  isLoading = false;
                });
                final wrongPasswordSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'Wrong Email Or Password',
                  contentType: ContentType.failure,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(wrongPasswordSnackBar);
              }
            },
            builder: (context, state) {
              return CustomerLoginScreenContent(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    _formKey.currentState!.save();
                    context.read<LoginCubit>().login(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                  }
                },
              );
            },
          ),
        ),
        if (isLoading) WhenLoadingLogInWidget(),
      ],
    );
  }
}
