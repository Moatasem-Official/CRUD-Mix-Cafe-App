import 'package:flutter/material.dart';
import '../../../../data/model/product_model.dart';
import 'custom_product_container.dart';

class CustomItemsHorizontalListView extends StatelessWidget {
  const CustomItemsHorizontalListView({
    super.key,
    required this.products,
    required this.onAddToCart,
  });

  final List<ProductModel> products;
  final Function(ProductModel) onAddToCart;

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
              discountPercentage: double.parse(
                (100 - ((product.discountedPrice / product.price) * 100))
                    .toStringAsFixed(2),
              ),
              isAvailable: product.isAvailable,
              quantity: product.quantity,
              offerStartDate: product.startDiscount,
              offerEndDate: product.endDiscount,
              hasDiscount: product.hasDiscount,
              onAddToCart: (product) => onAddToCart(product),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/customerShowProductDetails',
                  arguments: product,
                );
              },
              product: product,
            ),
          );
        }).toList(),
      ),
    );
  }
}
