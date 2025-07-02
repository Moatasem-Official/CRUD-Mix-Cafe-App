import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/app_images.dart';
import '../../widgets/admin/custom_button.dart';
import '../../widgets/admin/custom_text_field.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFCF9),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
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
              const CustomTextField(hintText: 'Email'),
              const SizedBox(height: 12),
              const CustomTextField(hintText: 'Password', controller: null),
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
              CustomButton(
                buttonText: 'Login',
                onPressed: () {
                  print('Customer UI Screens Have Not Been Designed Yet !');
                },
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Color(0xFF8B4513),
                  size: 20,
                ),
                label: const Text(
                  'Continue with Google',
                  style: TextStyle(
                    color: Color(0xFF8B4513),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  print("Google Sign In Triggered");
                  // مكان استدعاء Firebase Google SignIn
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFF8B4513)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
      ),
    );
  }
}
