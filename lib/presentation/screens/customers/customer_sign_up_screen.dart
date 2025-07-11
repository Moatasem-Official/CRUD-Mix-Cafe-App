import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/SignUp_Screen/cubit/sign_up_cubit.dart';
import 'package:mix_cafe_app/data/helpers/custom_snack_bar.dart';
import 'package:mix_cafe_app/data/helpers/when_loading_widget.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/cusomer_sign_up_screen_content/cusomer_sign_up_screen_content.dart';

class CustomerSignUpScreen extends StatefulWidget {
  const CustomerSignUpScreen({super.key});

  @override
  State<CustomerSignUpScreen> createState() => _CustomerSignUpScreenState();
}

class _CustomerSignUpScreenState extends State<CustomerSignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  var agreementChecked = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpLoading) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is SignUpSuccess) {
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
              } else if (state is SignUpError) {
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
              } else if (state is SignUpNoInternet) {
                setState(() {
                  isLoading = false;
                });
                final noInternetSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'No Internet',
                  contentType: ContentType.warning,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(noInternetSnackBar);
              } else if (state is SignUpEmailAlreadyInUse) {
                setState(() {
                  isLoading = false;
                });
                final emailInUseSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'Email Already In Use',
                  contentType: ContentType.warning,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(emailInUseSnackBar);
              } else if (state is SignUpWeakPassword) {
                setState(() {
                  isLoading = false;
                });
                final weakPasswordSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'Weak Password',
                  contentType: ContentType.warning,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(weakPasswordSnackBar);
              } else if (state is SignUpInvalidEmail) {
                setState(() {
                  isLoading = false;
                });
                final invalidEmailSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'Invalid Email',
                  contentType: ContentType.warning,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(invalidEmailSnackBar);
              } else if (state is SignUpUserDisabled) {
                setState(() {
                  isLoading = false;
                });
                final userDisabledSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'User Disabled',
                  contentType: ContentType.warning,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(userDisabledSnackBar);
              } else if (state is SignUpTooManyRequests) {
                setState(() {
                  isLoading = false;
                });
                final tooManyRequestsSnackBar = CustomSnackBar(
                  message: state.message,
                  title: 'Too Many Requests',
                  contentType: ContentType.warning,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(tooManyRequestsSnackBar);
              }
            },
            builder: (context, state) {
              return CusomerSignUpScreenContent(
                agreementChecked: agreementChecked,
                confirmPasswordController: _confirmPasswordController,
                emailController: _emailController,
                formKey: _formKey,
                nameController: _nameController,
                passwordController: _passwordController,
                onAgreementChanged: (value) {
                  setState(() {
                    agreementChecked = value!;
                  });
                },
                onSignUpPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    _formKey.currentState!.save();

                    if (_passwordController.text ==
                        _confirmPasswordController.text) {
                      if (agreementChecked) {
                        context.read<SignUpCubit>().signUp(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                          _nameController.text.trim(),
                        );
                      } else {
                        const snackBar = SnackBar(
                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'خطأ في التسجيل',
                            message:
                                'يجب عليك الموافقة على الشروط والأحكام للتسجيل',
                            contentType: ContentType.failure,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                        setState(() {
                          isLoading = false;
                        });

                        return;
                      }
                    } else {
                      const snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'خطأ في التسجيل',
                          message:
                              'كلمة المرور وتأكيد كلمة المرور غير متطابقتين. يرجى التحقق من المدخلات الخاصة بك.',
                          contentType: ContentType.failure,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      setState(() {
                        isLoading = false;
                      });
                    }
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
