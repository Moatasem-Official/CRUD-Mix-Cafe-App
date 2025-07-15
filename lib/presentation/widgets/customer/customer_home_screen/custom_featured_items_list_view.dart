import 'package:flutter/material.dart';
import '../../../../constants/app_assets.dart';
import 'custom_product_container.dart';

class CustomFeaturedItemsListView extends StatelessWidget {
  const CustomFeaturedItemsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CustomProductContainer(
              productImage: Assets.mixCafeCustomerFoodImage,
              productName: 'Product $index',
              productPrice: '${(index + 1) * 10}',
            ),
          );
        },
      ),
    );
  }
}
