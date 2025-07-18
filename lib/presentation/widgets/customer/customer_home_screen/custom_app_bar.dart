import 'package:flutter/material.dart';
import '../../../../constants/app_assets.dart';
import 'custom_filter_row_item.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.onSearchChanged,
    required this.onFilterAllTapped,
    required this.onFilterSandwichesTapped,
    required this.onFilterPizzasTapped,
    required this.onFilterCrepesTapped,
    required this.onFilterMealsTapped,
    required this.onFilterDrinksTapped,
    required this.onFilterDesertsTapped,
    required this.selectedFilter,
  });

  final Function(String) onSearchChanged;
  final Function() onFilterAllTapped;
  final Function() onFilterSandwichesTapped;
  final Function() onFilterPizzasTapped;
  final Function() onFilterCrepesTapped;
  final Function() onFilterMealsTapped;
  final Function() onFilterDrinksTapped;
  final Function() onFilterDesertsTapped;
  final String selectedFilter;

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
              onChanged: onSearchChanged,
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
                filterId: 0,
                isSelected: selectedFilter == 'All',
                onTap: onFilterAllTapped,
              ),
              CustomFilterRowItem(
                filterName: 'Sandwiches',
                filterIcon: Icons.local_drink,
                filterId: 1,
                isSelected: selectedFilter == 'Sandwiches',
                onTap: onFilterSandwichesTapped,
              ),
              CustomFilterRowItem(
                filterName: 'Pizza',
                filterIcon: Icons.local_pizza,
                filterId: 2,
                isSelected: selectedFilter == 'Pizzas',
                onTap: onFilterPizzasTapped,
              ),
              CustomFilterRowItem(
                filterName: 'Crepes',
                filterIcon: Icons.cake,
                filterId: 3,
                isSelected: selectedFilter == 'Crepes',
                onTap: onFilterCrepesTapped,
              ),
              CustomFilterRowItem(
                filterName: 'Meals',
                filterIcon: Icons.fastfood,
                filterId: 4,
                isSelected: selectedFilter == 'Meals',
                onTap: onFilterMealsTapped,
              ),
              CustomFilterRowItem(
                filterName: 'Drinks',
                filterIcon: Icons.local_drink,
                filterId: 5,
                isSelected: selectedFilter == 'Drinks',
                onTap: () {},
              ),
              CustomFilterRowItem(
                filterName: 'Desserts',
                filterIcon: Icons.cake,
                filterId: 6,
                isSelected: selectedFilter == 'Desserts',
                onTap: onFilterDesertsTapped,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
