import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';
import 'custom_product_container.dart';

class CustomItemsHorizontalListView extends StatelessWidget {
  const CustomItemsHorizontalListView({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.take(5).map((product) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CustomProductContainer(
              productImage: product.imageUrl,
              productName: product.name,
              productPrice: product.price,
              discountPercentage:
                  100 - ((product.discountedPrice / product.price) * 100),
              isAvailable: product.isAvailable,
              quantity: product.quantity,
              offerStartDate: product.startDiscount,
              offerEndDate: product.endDiscount,
              hasDiscount: product.hasDiscount,
              onAddToCart: () {
                // handle add to cart
              },
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/customerShowProductDetails',
                  arguments: product,
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
