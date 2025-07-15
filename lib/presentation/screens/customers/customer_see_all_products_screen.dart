import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_assets.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_see_all_products/custom_product_card.dart';

class CustomerSeeAllProductsScreen extends StatelessWidget {
  const CustomerSeeAllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomerAppBar(),
      backgroundColor: const Color.fromARGB(255, 255, 253, 251),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductCard(
              imageUrl: Assets.mixCafeCustomerFoodImage,
              name: 'Mix Cafe',
              description: 'Mix Cafe Description here ...',
              price: 10.99,
            ),
            ProductCard(
              imageUrl: Assets.mixCafeCustomerFoodImage,
              name: 'Mix Cafe',
              description: 'Mix Cafe Description here ...',
              price: 10.99,
            ),
            ProductCard(
              imageUrl: Assets.mixCafeCustomerFoodImage,
              name: 'Mix Cafe',
              description: 'Mix Cafe Description here ...',
              price: 10.99,
            ),
            ProductCard(
              imageUrl: Assets.mixCafeCustomerFoodImage,
              name: 'Mix Cafe',
              description: 'Mix Cafe Description here ...',
              price: 10.99,
            ),
            ProductCard(
              imageUrl: Assets.mixCafeCustomerFoodImage,
              name: 'Mix Cafe',
              description: 'Mix Cafe Description here ...',
              price: 10.99,
            ),
            ProductCard(
              imageUrl: Assets.mixCafeCustomerFoodImage,
              name: 'Mix Cafe',
              description: 'Mix Cafe Description here ...',
              price: 10.99,
            ),
            ProductCard(
              imageUrl: Assets.mixCafeCustomerFoodImage,
              name: 'Mix Cafe',
              description: 'Mix Cafe Description here ...',
              price: 10.99,
            ),
            ProductCard(
              imageUrl: Assets.mixCafeCustomerFoodImage,
              name: 'Mix Cafe',
              description: 'Mix Cafe Description here ...',
              price: 10.99,
            ),
            ProductCard(
              imageUrl: Assets.mixCafeCustomerFoodImage,
              name: 'Mix Cafe',
              description: 'Mix Cafe Description here ...',
              price: 10.99,
            ),
            ProductCard(
              imageUrl: Assets.mixCafeCustomerFoodImage,
              name: 'Mix Cafe',
              description: 'Mix Cafe Description here ...',
              price: 10.99,
            ),
          ],
        ),
      ), // لون بيج فاتح
    );
  }
}

class CustomerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 253, 251), // لون بيج فاتح
      elevation: 0,
      title: const Text(
        'All Products',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      surfaceTintColor: const Color.fromARGB(255, 255, 253, 251),
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: Colors.black),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Products...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
