import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/screens/admin/admin_settings_screen.dart';
import 'package:mix_cafe_app/presentation/screens/admin/analytics_home_screen.dart';
import 'package:mix_cafe_app/presentation/screens/admin/categories_managment_screen.dart';
import 'package:mix_cafe_app/presentation/screens/admin/orders_managment_screen.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final NotchBottomBarController _notchBottomBarController =
      NotchBottomBarController(index: 0);

  final PageController pageController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          AnalyticsHomeScreen(),
          const CategoriesManagmentScreen(),
          const OrdersManagmentScreen(),
          const AdminSettingsScreen(),
        ],
      ),
      bottomNavigationBar: FittedBox(
        child: WaterDropNavBar(
          bottomPadding: 20,
          backgroundColor: Colors.white,
          waterDropColor: Color.fromARGB(
            255,
            165,
            101,
            56,
          ), // بني غامق للأيقونة المفعلة
          inactiveIconColor: Color(0xFFBCAAA4),
          onItemSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(
              selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad,
            );
          },
          selectedIndex: selectedIndex,
          barItems: [
            BarItem(
              filledIcon: Icons.analytics_rounded,
              outlinedIcon: Icons.analytics_outlined,
            ),
            BarItem(
              filledIcon: Icons.category_rounded,
              outlinedIcon: Icons.category_outlined,
            ),
            BarItem(
              filledIcon: Icons.receipt_long,
              outlinedIcon: Icons.receipt_long_outlined,
            ),
            BarItem(
              filledIcon: Icons.settings_rounded,
              outlinedIcon: Icons.settings_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
