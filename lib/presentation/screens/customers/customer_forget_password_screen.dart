import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bussines_logic/cubits/customer/forget_password_screen/cubit/forget_password_cubit.dart';
import '../../../data/helpers/custom_snack_bar.dart';
import '../../../data/helpers/when_loading_widget.dart';
import '../../widgets/customer/customer_forget_password_screen_content/customer_forget_password_screen_content.dart';

class CustomerForgetPasswordScreen extends StatefulWidget {
  const CustomerForgetPasswordScreen({super.key});

  @override
  State<CustomerForgetPasswordScreen> createState() =>
      _CustomerForgetPasswordScreenState();
}

class _CustomerForgetPasswordScreenState
    extends State<CustomerForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            centerTitle: true,
            title: const Text(
              'Forget Password',
              style: TextStyle(
                color: Color(0xFF6F4E37),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordSuccess) {
                setState(() {
                  isLoading = false;
                });
                final successSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'Success',
                  contentType: ContentType.success,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(successSnackBar);
              } else if (state is ForgetPasswordError) {
                setState(() {
                  isLoading = false;
                });
                final errorSnackBar = CustomSnackBar(
                  message: state.error,
                  title: 'Error',
                  contentType: ContentType.failure,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(errorSnackBar);
              } else if (state is ForgetPasswordLoading) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is ForgetPasswordNoInternet) {
                setState(() => isLoading = false);
                final noInternetSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'No Internet',
                  contentType: ContentType.warning,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(noInternetSnackBar);
              } else if (state is ForgetPasswordInvalidEmail) {
                setState(() => isLoading = false);
                final invalidEmailSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'Invalid Email',
                  contentType: ContentType.warning,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(invalidEmailSnackBar);
              } else if (state is ForgetPasswordInitial) {
                setState(() => isLoading = false);
              } else {
                setState(() {
                  isLoading = false;
                });
              }
            },
            builder: (context, state) {
              return CustomerForgetPasswordScreenContent(
                formKey: _formKey,
                emailController: _emailController,
                onSubmit: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    context.read<ForgetPasswordCubit>().sendResetLink(
                      _emailController.text.trim(),
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
