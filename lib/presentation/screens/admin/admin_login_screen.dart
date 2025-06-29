import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_images.dart';
import 'package:mix_cafe_app/presentation/screens/admin/admin_home_screen.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_button.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_text_field.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
              CustomTextField(hintText: 'Email'),
              CustomTextField(hintText: 'Password'),
              CustomButton(
                buttonText: 'LOGIN',
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const AdminHomeScreen(),
                  ),
                  (route) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
