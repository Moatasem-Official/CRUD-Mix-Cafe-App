import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            CustomTextField(hintText: 'Email'),
            CustomButton(buttonText: 'Submit', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
