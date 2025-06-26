import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_images.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_categories_appbar.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_product_templete.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  List products = [
    {
      'productName': 'Coffee',
      'productDescription': 'coffee description',
      'productPrice': 100.0,
      'imagePath': Assets.mixCafeCustomerImage,
    },
    {
      'productName': 'Product Name',
      'productDescription': 'Product Description',
      'productPrice': 65.0,
      'imagePath': Assets.mixCafeAdminImage,
    },
    {
      'productName': 'Product Name',
      'productDescription': 'Product Description',
      'productPrice': 65.0,
      'imagePath': Assets.mixCafeCustomerImage,
    },
    {
      'productName': 'Product Name',
      'productDescription': 'Product Description',
      'productPrice': 65.0,
      'imagePath': Assets.mixCafeCustomerImage,
    },
    {
      'productName': 'Product Name',
      'productDescription': 'Product Description',
      'productPrice': 65.0,
      'imagePath': Assets.mixCafeCustomerImage,
    },
    {
      'productName': 'Salamy',
      'productDescription': 'Product Description',
      'productPrice': 20.0,
      'imagePath': Assets.mixCafeImageLogo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomCategoriesAppBar(
        title: widget.categoryName,
        buttonText: 'Add Product',
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return CustomProductTemplate(
                  productName: products[index]['productName'],
                  productDescription: products[index]['productDescription'],
                  productPrice: products[index]['productPrice'],
                  imagePath: products[index]['imagePath'],
                );
              },
              itemCount: products.length,
            ),
          ],
        ),
      ),
    );
  }
}
