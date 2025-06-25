import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_images.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_button.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_text_field.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
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
              CustomTextField(hintText: 'Email'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(hintText: 'Password'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 8, 0, 16),
                    child: TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/forgetPassword'),
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 165, 101, 56),
                          fontSize: 16,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CustomButton(buttonText: 'Login', onPressed: () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 165, 101, 56),
                      fontSize: 16,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/customerSignUp'),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Color.fromARGB(255, 100, 57, 26),
                        fontSize: 16,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
