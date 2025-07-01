import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/screens/admin/add_product_information_form.dart';
import '../../../constants/app_images.dart';
import '../../widgets/admin/Products_Screen_Widgets/custom_product_templete.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key});

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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 16),
        child: FloatingActionButton.extended(
          backgroundColor: const Color(0xFFA0522D), // بني جذاب
          elevation: 4,
          icon: const Icon(Icons.add, size: 22, color: Colors.white),
          label: const Text(
            "إضافة منتج",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProductInformationForm()),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
