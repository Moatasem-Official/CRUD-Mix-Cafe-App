import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';
import '../../../constants/app_images.dart';
import '../../widgets/admin/custom_button.dart';
import '../../widgets/admin/custom_text_field.dart';

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
  final String _emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final AuthService _authService = AuthService();
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
          body: SingleChildScrollView(
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
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        validator: (value) {
                          return RegExp(_emailPattern).hasMatch(value ?? '')
                              ? null
                              : 'Enter a valid email';
                        },
                        hintText: 'Email',
                        controller: _emailController,
                      ),
                      CustomButton(
                        buttonText: 'Submit',
                        onPressed: () async {
                          _formKey.currentState!.validate();
                          setState(() => isLoading = true);
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            await _authService.sendPasswordResetEmail(
                              context,
                              _emailController.text,
                            );
                          }
                          setState(() => isLoading = false);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5), // ظل شفاف
            child: Center(
              child: Image.asset(
                'assets/animations/Animation - 1751644034977.gif',
                width: 250, // الحجم الذي تريده
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),
      ],
    );
  }
}
