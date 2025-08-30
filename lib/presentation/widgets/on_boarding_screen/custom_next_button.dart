import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_strings.dart';

class CustomNextButton extends StatelessWidget {
  const CustomNextButton({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: AppStrings.kCoffeeLight,
        backgroundColor: AppStrings.kAccentOrange,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
        shadowColor: AppStrings.kAccentOrange.withOpacity(0.5),
      ),
      child: const Text(
        'Next',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
