import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'custom_category_drop_down.dart';
import 'custom_section_card.dart';
import 'custom_text_field.dart';

class PricingQualitySectionCard extends StatelessWidget {
  const PricingQualitySectionCard({
    super.key,
    required this.priceController,
    required this.quantityController,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final TextEditingController priceController;
  final TextEditingController quantityController;
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return CustomSectionCard(
      icon: IconlyBold.wallet,
      title: 'Pricing & Quantity',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: priceController,
                  label: 'Price',
                  icon: Icons.attach_money_rounded,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  controller: quantityController,
                  label: 'Quantity',
                  icon: IconlyLight.bag,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomCategoryDropDown(
            categories: categories,
            selectedCategory: selectedCategory,
            onCategoryChanged: (category) => onCategoryChanged(category),
          ),
        ],
      ),
    );
  }
}
