import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_strings.dart';

class CustomGetStartedButton extends StatelessWidget {
  const CustomGetStartedButton({super.key, required this.onGetStarted});

  final Function() onGetStarted;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onGetStarted(),
      style: ElevatedButton.styleFrom(
        foregroundColor: AppStrings.kCoffeeLight,
        backgroundColor: AppStrings.kCoffeeDark,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
        shadowColor: AppStrings.kCoffeeDark.withOpacity(0.5),
      ),
      child: const Text(
        'Get Started',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
