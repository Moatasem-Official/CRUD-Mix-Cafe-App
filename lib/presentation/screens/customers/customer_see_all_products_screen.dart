import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_see_all_products/custom_product_card.dart';

class CustomerSeeAllProductsScreen extends StatelessWidget {
  const CustomerSeeAllProductsScreen({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomerAppBar(),
      backgroundColor: const Color.fromARGB(255, 255, 253, 251),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    name: products[index].name,
                    description: products[index].description,
                    price: products[index].price,
                    imageUrl: products[index].imageUrl,
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
