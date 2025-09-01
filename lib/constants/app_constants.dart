import 'dart:ui';

class AppConstants {
  static final List<Map<String, String>> onboardingPages = [
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

  static const Color kCoffeeLight = Color(0xFFEADBC8);
  static const Color kCoffeeDark = Color(0xFF4B3621);
  static const Color kAccentBrown = Color(0xFF6F4E37);
  static const Color kAccentOrange = Color(0xFFC38154);

  static const double kDeliveryFee = 0.1;
}
