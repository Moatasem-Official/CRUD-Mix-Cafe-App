import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Analytics_Home_Screen_Widgets/custom_most_popular_items_card.dart';

class CustomMostPopularItemsGrid extends StatelessWidget {
  const CustomMostPopularItemsGrid({super.key, required this.items});

  final List<Map<String, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Wrap(
        runSpacing: 10,
        children: List.generate(
          4,
          (index) => SizedBox(
            width: MediaQuery.of(context).size.width / 2, // نصف العرض تقريبا
            child: Padding(
              padding: EdgeInsets.only(
                left: index == 0 || index == 2 ? 15 : 8,
                right: index == 0 || index == 2 ? 0 : 15,
              ),
              child: MostPopularItemsCard(
                name: items[index]['name'],
                description: items[index]['description'],
                price: items[index]['price'],
                imagePath: items[index]['imagePath'],
              ),
            ),
          ),
          growable: true,
        ),
      ),
    );
  }
}
