import 'package:flutter/material.dart';
import '../../../../constants/app_assets.dart';
import '../../admin/custom_button.dart';
import '../../admin/custom_text_field.dart';

class CustomerLoginScreenContent extends StatelessWidget {
  const CustomerLoginScreenContent({
    super.key,
    required this.onPressed,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                Assets.mixCafeImageLogo,
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Welcome Back !',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B4513),
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    hintText: 'Password',
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        overlayColor: Colors.transparent,
                      ),
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/forgetPassword'),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8B4513),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomButton(buttonText: 'LOGIN', onPressed: onPressed),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don’t have an account ?',
                    style: TextStyle(color: Colors.brown, fontSize: 15),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      overlayColor: Colors.transparent,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/customerSignUp'),
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Color(0xFF8B4513),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/adminLogin'),
              child: Text(
                'I Am Admin',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
