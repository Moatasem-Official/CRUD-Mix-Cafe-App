import 'package:flutter/material.dart';
import '../../../../constants/app_assets.dart';
import 'custom_filter_row_item.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFDE7D6), Color(0xFFF3CBA8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.asset(
                  Assets.mixCafeCustomerFoodImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),

            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),

            // النصوص
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome to Mix Cafe!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Freshly prepared, just for you.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search for food, drinks, or more...',
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
              onSubmitted: (value) {
                // Handle search action
              },
              onChanged: (value) {
                // Handle search input changes
              },
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Add your category items here
              CustomFilterRowItem(
                filterName: 'All',
                filterIcon: Icons.fastfood,
              ),
              CustomFilterRowItem(
                filterName: 'Sndwiches',
                filterIcon: Icons.local_drink,
              ),
              CustomFilterRowItem(
                filterName: 'Pizza',
                filterIcon: Icons.local_pizza,
              ),
              CustomFilterRowItem(filterName: 'Crepes', filterIcon: Icons.cake),
            ],
          ),
        ),
      ],
    );
  }
}
