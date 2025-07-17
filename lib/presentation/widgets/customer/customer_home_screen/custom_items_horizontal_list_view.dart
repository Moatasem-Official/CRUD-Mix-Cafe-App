import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';
import 'custom_product_container.dart';

class CustomItemsHorizontalListView extends StatelessWidget {
  const CustomItemsHorizontalListView({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length > 5 ? 5 : products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CustomProductContainer(
              productImage: products[index].imageUrl,
              productName: products[index].name,
              productPrice: products[index].price.toString(),
            ),
          );
        },
      ),
    );
  }
}
