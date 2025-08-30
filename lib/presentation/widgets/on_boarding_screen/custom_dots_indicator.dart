import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_strings.dart';

class CustomDotsIndicator extends StatelessWidget {
  const CustomDotsIndicator({super.key, required this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        AppStrings.onboardingPages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          height: 8.0,
          width: currentPage == index ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppStrings.kCoffeeDark
                : AppStrings.kAccentBrown.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
