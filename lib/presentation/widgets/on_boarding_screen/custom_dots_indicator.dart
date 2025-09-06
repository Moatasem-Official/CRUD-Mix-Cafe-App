import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';

class CustomDotsIndicator extends StatelessWidget {
  const CustomDotsIndicator({super.key, required this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        AppConstants.onboardingPages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 5.0),
          height: 8.0,
          width: currentPage == index ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: currentPage == index
                ? Color.fromARGB(255, 165, 101, 56)
                : AppConstants.kAccentBrown.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
