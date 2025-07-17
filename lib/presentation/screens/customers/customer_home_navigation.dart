import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_cart_screen.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_home_screen.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_orders_screen.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_profile_screen.dart';

enum _SelectedTab { home, favorite, add, search, profile }

class CustomerHomeNavigation extends StatefulWidget {
  const CustomerHomeNavigation({super.key});

  @override
  State<CustomerHomeNavigation> createState() => _CustomerHomeNavigationState();
}

class _CustomerHomeNavigationState extends State<CustomerHomeNavigation> {
  _SelectedTab _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedTab = _SelectedTab.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedTab.index,
        children: [
          CustomerHomeScreen(),
          const CustomerCartScreen(),
          const CustomerOrdersScreen(),
          const CustomerProfileScreen(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.1),
          borderWidth: 2,
          outlineBorderColor: Colors.white,
          onTap: _handleIndexChanged,
          items: [
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.buy,
              unselectedIcon: IconlyLight.buy,
              selectedColor: Colors.white,
              badge: const Badge(
                label: Text("9", style: TextStyle(color: Colors.white)),
              ),
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.paper,
              unselectedIcon: IconlyLight.paper,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.profile,
              unselectedIcon: IconlyLight.profile,
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
