import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_assets.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_button.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_text_field.dart';

class AdminLoginScreenContent extends StatelessWidget {
  const AdminLoginScreenContent({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function() onLogin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                Assets.mixCafeImageLogo,
                width: 300,
                height: 300,
              ),
            ),
            Text(
              'ADMIN',
              style: TextStyle(
                fontSize: 24,
                letterSpacing: 5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6F4E37),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    validator: (value) => value!.isEmpty ? 'Enter email' : null,
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  CustomTextField(
                    validator: (value) =>
                        value!.isEmpty ? 'Enter password' : null,
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                  CustomButton(buttonText: 'LOGIN', onPressed: onLogin),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'I am not admin ?',
                  style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 232, 206, 187),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/customerLogin');
                  },
                  child: const Text(
                    'Login as Customer',
                    style: TextStyle(fontSize: 16, color: Color(0xFF6F4E37)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
