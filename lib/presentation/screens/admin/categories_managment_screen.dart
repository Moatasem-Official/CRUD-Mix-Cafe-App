import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../bussines_logic/cubits/admin/categories_screen/cubit/categories_cubit.dart';
import 'category_products_screen.dart';

// Data model for our categories for cleaner code
class CategoryInfo {
  final int id;
  final String name;
  final IconData icon;

  CategoryInfo({required this.id, required this.name, required this.icon});
}

class CategoriesManagmentScreen extends StatefulWidget {
  const CategoriesManagmentScreen({super.key});

  @override
  State<CategoriesManagmentScreen> createState() =>
      _CategoriesManagementScreenState();
}

class _CategoriesManagementScreenState extends State<CategoriesManagmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // --- ✨ 1. تم اختيار أيقونات جديدة واحترافية ✨ ---
  final List<CategoryInfo> _categories = [
    CategoryInfo(id: 0, name: 'Sandwiches', icon: Icons.lunch_dining_outlined),
    CategoryInfo(id: 1, name: 'Pizza', icon: Icons.local_pizza_outlined),
    CategoryInfo(id: 2, name: 'Crepes', icon: Icons.breakfast_dining_outlined),
    CategoryInfo(id: 3, name: 'Meals', icon: Icons.dinner_dining_outlined),
    CategoryInfo(id: 4, name: 'Desserts', icon: Icons.cake_outlined),
    CategoryInfo(id: 5, name: 'Drinks', icon: Icons.local_cafe_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFFA56538);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      // --- ✨ 2. تصميم AppBar متكامل جديد ✨ ---
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          // --- ✨ قم بزيادة المسافة العلوية هنا ✨ ---
          padding: const EdgeInsets.only(top: 55, left: 16, right: 16),
          decoration: BoxDecoration(
            //... باقي الكود كما هو
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Categories Management',
                style: TextStyle(
                  color: Color.fromARGB(255, 165, 101, 56),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // --- ✨ 3. شريط تبويب بنمط Material 3 ✨ ---
              TabBar(
                controller: _tabController,
                isScrollable: true,
                padding: EdgeInsets.zero,
                dividerHeight: 0, // <-- 1. أضف هذا السطر لإزالة الخط
                tabAlignment: TabAlignment
                    .start, // <-- 2. أضف هذا السطر لبدء التبويبات من الحافة
                labelColor: themeColor,
                unselectedLabelColor: Colors.grey.shade600,
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: themeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStateProperty.all(
                  themeColor.withOpacity(0.1),
                ),
                tabs: _categories.map((category) {
                  return Tab(
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(category.icon, size: 20),
                        const SizedBox(width: 8),
                        Text(category.name),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _categories.map((category) {
          return BlocProvider(
            create: (context) => CategoriesCubit()..getProducts(category.id),
            child: CategoryProductsScreen(categoryId: category.id),
          );
        }).toList(),
      ),
    );
  }
}
