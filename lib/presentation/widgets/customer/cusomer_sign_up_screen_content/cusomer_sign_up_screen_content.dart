import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_assets.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_button.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_rich_text.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_text_field.dart';

class CusomerSignUpScreenContent extends StatelessWidget {
  const CusomerSignUpScreenContent({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.agreementChecked,
    required this.onSignUpPressed,
    required this.onAgreementChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool agreementChecked;
  final Function() onSignUpPressed;
  final Function(bool? value) onAgreementChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              Assets.mixCafeImageLogo,
              width: 300,
              height: 300,
            ),
          ),
          Text(
            'SIGN UP',
            style: TextStyle(
              fontSize: 24,
              letterSpacing: 5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6F4E37),
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  validator: (value) {
                    return value!.isEmpty ? 'Please enter your name' : null;
                  },
                  hintText: 'Name',
                  controller: nameController,
                ),
                CustomTextField(
                  validator: (value) {
                    return value!.isEmpty ? 'Please enter your email' : null;
                  },
                  hintText: 'Email',
                  controller: emailController,
                ),
                CustomTextField(
                  validator: (value) {
                    return value!.isEmpty ? 'Please enter your password' : null;
                  },
                  hintText: 'Password',
                  controller: passwordController,
                ),
                CustomTextField(
                  validator: (value) {
                    return value!.isEmpty ? 'Please enter your password' : null;
                  },
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController,
                ),
                CustomRichText(
                  checked: agreementChecked,
                  onChanged: onAgreementChanged,
                ),
                CustomButton(buttonText: 'SIGN UP', onPressed: onSignUpPressed),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account ? ',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Color.fromARGB(255, 165, 101, 56),
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
