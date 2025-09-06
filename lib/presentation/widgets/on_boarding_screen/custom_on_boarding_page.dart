import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/app_constants.dart';

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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: SvgPicture.asset(imagePath, fit: BoxFit.contain),
        ),
        const SizedBox(height: 40),
        Container(
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 25,
            vertical: 30,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 165, 101, 56).withOpacity(0.1),
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
                  color: Color.fromARGB(255, 165, 101, 56),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                body,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppConstants.kCoffeeDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
