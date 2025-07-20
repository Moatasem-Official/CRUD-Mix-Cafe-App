import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_cart_screen.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_home_screen.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_orders_screen.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_profile_screen.dart';

class CustomerHomeNavigation extends StatefulWidget {
  const CustomerHomeNavigation({super.key});

  @override
  State<CustomerHomeNavigation> createState() => _CustomerHomeNavigationState();
}

class _CustomerHomeNavigationState extends State<CustomerHomeNavigation> {
  int _currentPage = 0;
  final _pageController = PageController();

  final Color mainColor = const Color(0xFFC58B3E);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          CustomerHomeScreen(),
          CustomerCartScreen(),
          CustomerOrdersScreen(),
          CustomerProfileScreen(),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        backgroundColor: Colors.white,
        items: <BottomBarItem>[
          BottomBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            activeColor: mainColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.shopping_cart_outlined),
            title: const Text('Cart'),
            activeColor: mainColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.receipt_long_outlined),
            title: const Text('Orders'),
            activeColor: mainColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            activeColor: mainColor,
          ),
        ],
      ),
    );
  }
}
