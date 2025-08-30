import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mix_cafe_app/constants/app_strings.dart';

class CustomOnBoardingPage extends StatelessWidget {
  const CustomOnBoardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.body,
  });

  final String imagePath;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: SvgPicture.asset(
            imagePath,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(
              AppStrings.kAccentBrown,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppStrings.kCoffeeDark,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                body,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppStrings.kCoffeeDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
