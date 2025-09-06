import 'package:flutter/material.dart';
import '../../../../data/model/product_model.dart';
import 'most_popular_items_card/custom_most_popular_items_card.dart';
import 'dart:math';

class CustomMostPopularItemsGrid extends StatelessWidget {
  const CustomMostPopularItemsGrid({super.key, required this.items});

  final List<ProductModel> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Wrap(
        runSpacing: 10,
        children: List.generate(
          min(4, items.length),
          (index) => SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: index == 0 || index == 2 ? 15 : 8,
                end: index == 0 || index == 2 ? 0 : 15,
              ),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/customerShowProductDetails',
                  arguments: items[index],
                ),
                child: MostPopularItemsCard(
                  name: items[index].name,
                  description: items[index].description,
                  price: items[index].price,
                  imagePath: items[index].imageUrl,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
