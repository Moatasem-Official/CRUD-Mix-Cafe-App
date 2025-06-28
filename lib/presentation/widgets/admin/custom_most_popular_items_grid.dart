import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_most_popular_items_card.dart';

class CustomMostPopularItemsGrid extends StatelessWidget {
  const CustomMostPopularItemsGrid({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
  final String name;
  final String description;
  final String price;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1 / 2,
          ),
          itemBuilder: (context, index) => MostPopularItemsCard(
            name: name,
            description: description,
            price: price,
            imagePath: imagePath,
          ),
        ),
      ),
    );
  }
}
