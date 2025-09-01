import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_constants.dart';
import 'package:mix_cafe_app/presentation/widgets/on_boarding_screen/custom_dots_indicator.dart';
import 'package:mix_cafe_app/presentation/widgets/on_boarding_screen/custom_get_started_button.dart';
import 'package:mix_cafe_app/presentation/widgets/on_boarding_screen/custom_next_button.dart';
import 'package:mix_cafe_app/presentation/widgets/on_boarding_screen/custom_on_boarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kCoffeeLight,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: AppConstants.onboardingPages.length,
            itemBuilder: (context, index) {
              final page = AppConstants.onboardingPages[index];
              return CustomOnBoardingPage(
                imagePath: page['image']!,
                title: page['title']!,
                body: page['body']!,
              );
            },
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () => _goToHome(context),
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: AppConstants.kCoffeeDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                CustomDotsIndicator(currentPage: _currentPage),
                const SizedBox(height: 30),
                if (_currentPage < AppConstants.onboardingPages.length - 1)
                  CustomNextButton(pageController: _pageController)
                else
                  CustomGetStartedButton(
                    onGetStarted: () => _goToHome(context),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/selectUserRole');
  }
}
