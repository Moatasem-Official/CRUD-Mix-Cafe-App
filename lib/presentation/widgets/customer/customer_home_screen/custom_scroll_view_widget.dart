import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_home_screen/custom_items_horizontal_list_view.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_home_screen/custom_items_title_row.dart';

class CustomScrollViewWidget extends StatelessWidget {
  const CustomScrollViewWidget({
    super.key,
    required this.featuredProducts,
    required this.bestProducts,
    required this.newProducts,
    required this.otherProducts,
  });

  final List<ProductModel> featuredProducts;
  final List<ProductModel> bestProducts;
  final List<ProductModel> newProducts;
  final List<ProductModel> otherProducts;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: CustomItemsTitleRow(
            title: 'Featured Items',
            onTap: () => Navigator.pushNamed(
              context,
              '/customerSeeAllProductsScreen',
              arguments: featuredProducts,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CustomItemsHorizontalListView(products: featuredProducts),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverToBoxAdapter(
          child: CustomItemsTitleRow(
            title: 'Best Sellers',
            onTap: () => Navigator.pushNamed(
              context,
              '/customerSeeAllProductsScreen',
              arguments: bestProducts,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CustomItemsHorizontalListView(products: bestProducts),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverToBoxAdapter(
          child: CustomItemsTitleRow(
            title: 'New Items',
            onTap: () => Navigator.pushNamed(
              context,
              '/customerSeeAllProductsScreen',
              arguments: newProducts,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CustomItemsHorizontalListView(products: newProducts),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverToBoxAdapter(
          child: CustomItemsTitleRow(
            title: 'Other Items',
            onTap: () => Navigator.pushNamed(
              context,
              '/customerSeeAllProductsScreen',
              arguments: otherProducts,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CustomItemsHorizontalListView(products: otherProducts),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}
