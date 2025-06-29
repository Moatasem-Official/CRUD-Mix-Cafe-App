import 'package:flutter/material.dart';
import '../../../constants/app_images.dart';
import '../../widgets/admin/custom_button.dart';
import '../../widgets/admin/custom_rich_text.dart';
import '../../widgets/admin/custom_text_field.dart';

class CustomerSignUpScreen extends StatefulWidget {
  const CustomerSignUpScreen({super.key});

  @override
  State<CustomerSignUpScreen> createState() => _CustomerSignUpScreenState();
}

class _CustomerSignUpScreenState extends State<CustomerSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
            CustomTextField(hintText: 'Name'),
            CustomTextField(hintText: 'Email'),
            CustomTextField(hintText: 'Password'),
            CustomTextField(hintText: 'Confirm Password'),
            CustomRichText(),
            CustomButton(buttonText: 'SIGN UP', onPressed: () {}),
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
      ),
    );
  }
}
