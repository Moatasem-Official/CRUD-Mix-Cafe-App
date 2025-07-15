import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bussines_logic/cubits/admin/categories_screen/cubit/categories_cubit.dart';
import 'category_products_screen.dart';

class CategoriesManagmentScreen extends StatefulWidget {
  const CategoriesManagmentScreen({super.key});

  @override
  State<CategoriesManagmentScreen> createState() =>
      _CategoriesManagmentScreenState();
}

class _CategoriesManagmentScreenState extends State<CategoriesManagmentScreen> {
  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF8B4513);
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1), // خلفية كريمية ناعمة
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Categories Management',
          style: TextStyle(
            color: Color(0xFF8B4513),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
              child: ButtonsTabBar(
                backgroundColor: themeColor,
                unselectedBackgroundColor: Colors.grey.shade200,
                unselectedLabelStyle: const TextStyle(color: Colors.black87),
                labelStyle: const TextStyle(color: Colors.white),
                radius: 100,
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                tabs: const [
                  Tab(icon: Icon(Icons.fastfood), text: "سندويتشات"),
                  Tab(icon: Icon(Icons.local_pizza), text: "بيتزا"),
                  Tab(
                    icon: Icon(Icons.breakfast_dining, size: 28),
                    text: "كريب",
                  ),
                  Tab(icon: Icon(Icons.dinner_dining), text: "وجبات"),
                  Tab(icon: Icon(Icons.local_drink), text: "مشروبات"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                children: [
                  BlocProvider(
                    create: (context) => CategoriesCubit()..getProducts(0),
                    child: CategoryProductsScreen(categoryId: 0),
                  ),
                  BlocProvider(
                    create: (context) => CategoriesCubit()..getProducts(1),
                    child: CategoryProductsScreen(categoryId: 1),
                  ),
                  BlocProvider(
                    create: (context) => CategoriesCubit()..getProducts(2),
                    child: CategoryProductsScreen(categoryId: 2),
                  ),
                  BlocProvider(
                    create: (context) => CategoriesCubit()..getProducts(3),
                    child: CategoryProductsScreen(categoryId: 3),
                  ),
                  BlocProvider(
                    create: (context) => CategoriesCubit()..getProducts(4),
                    child: CategoryProductsScreen(categoryId: 4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
