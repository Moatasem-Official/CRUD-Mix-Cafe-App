import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_assets.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_button.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_text_field.dart';

class CustomerForgetPasswordScreenContent extends StatelessWidget {
  const CustomerForgetPasswordScreenContent({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Image.asset(
              Assets.mixCafeImageLogo,
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Enter Your Email Address To Receive A Link To Reset Your Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6F4E37),
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  hintText: 'Email',
                  controller: emailController,
                ),
                CustomButton(buttonText: 'Submit', onPressed: onSubmit),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
