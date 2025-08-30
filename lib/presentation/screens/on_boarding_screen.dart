import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color kCoffeeLight = Color(0xFFEADBC8);
const Color kCoffeeDark = Color(0xFF4B3621);
const Color kAccentBrown = Color(0xFF6F4E37);
const Color kAccentOrange = Color(0xFFC38154);

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> onboardingPages = [
    {
      'image': 'assets/icons/coffee-cup-svgrepo-com.svg',
      'title': 'Welcome to Mix Cafe',
      'body':
          'Discover a world of flavor where a restaurant, a cafe, and a juice bar meet in one place.',
    },
    {
      'image': 'assets/icons/food-fast-hamburger-burger-svgrepo-com.svg',
      'title': 'A Memorable Dining Experience',
      'body':
          'Browse our diverse menus, from breakfast to dinner, and order your favorite dishes with ease.',
    },
    {
      'image': 'assets/icons/coffee-beans-svgrepo-com.svg',
      'title': 'Your Coffee Awaits',
      'body':
          'Enjoy moments of tranquility with your favorite cup of coffee, from rich espresso to luxurious latte.',
    },
    {
      'image': 'assets/icons/juice-svgrepo-com.svg',
      'title': 'Fresh & Natural Juices',
      'body':
          'Revitalize with our wide selection of fresh, natural juices. Perfect for any time of the day.',
    },
    {
      'image': 'asset/icons/shopping-cart-svgrepo-com.svg',
      'title': 'Seamless Control for You',
      'body':
          'Track your orders, review your purchase history, and save your favorites for quick reordering.',
    },
    {
      'image': 'assets/icons/analytics-chart-diagram-svgrepo-com.svg',
      'title': 'Smart Business Management',
      'body':
          'For our business partners: our admin dashboard provides instant insights and comprehensive reports to manage your business efficiently.',
    },
  ];

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
      backgroundColor: kCoffeeLight,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingPages.length,
            itemBuilder: (context, index) {
              final page = onboardingPages[index];
              return _buildOnboardingPage(
                page['image']!,
                page['title']!,
                page['body']!,
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
                  color: kCoffeeDark,
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
                _buildDotsIndicator(),
                const SizedBox(height: 30),
                if (_currentPage < onboardingPages.length - 1)
                  _buildNextButton(context)
                else
                  _buildGetStartedButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(String imagePath, String title, String body) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: SvgPicture.asset(
            imagePath,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(kAccentBrown, BlendMode.srcIn),
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
                  color: kCoffeeDark,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                body,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: kCoffeeDark),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingPages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          height: 8.0,
          width: _currentPage == index ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? kCoffeeDark
                : kAccentBrown.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: kCoffeeLight,
        backgroundColor: kAccentOrange,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
        shadowColor: kAccentOrange.withOpacity(0.5),
      ),
      child: const Text(
        'Next',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _goToHome(context),
      style: ElevatedButton.styleFrom(
        foregroundColor: kCoffeeLight,
        backgroundColor: kCoffeeDark,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
        shadowColor: kCoffeeDark.withOpacity(0.5),
      ),
      child: const Text(
        'Get Started',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _goToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/selectUserRole');
  }
}
