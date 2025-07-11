import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_assets.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_button.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_text_field.dart';

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
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height - kToolbarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Center(
              child: Image.asset(
                Assets.mixCafeImageLogo,
                width: 220,
                height: 220,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Welcome back !',
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
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/forgetPassword'),
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
                  const SizedBox(height: 8),
                  CustomButton(buttonText: 'Login', onPressed: onPressed),
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
