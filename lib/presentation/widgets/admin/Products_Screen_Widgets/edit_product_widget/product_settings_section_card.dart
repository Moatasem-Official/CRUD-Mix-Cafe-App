import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';
import 'custom_discount_details.dart';
import 'custom_section_card.dart';
import 'custom_switch_tile.dart';

class ProductSettingsSectionCard extends StatelessWidget {
  const ProductSettingsSectionCard({
    super.key,
    required this.isAvailable,
    required this.hasDiscount,
    required this.isFeatured,
    required this.isNew,
    required this.isBestSeller,
    required this.discountController,
    this.startDate,
    this.endDate,
    required this.onHasDiscountChanged,
    required this.onIsAvailableChanged,
    required this.onStartDateTap,
    required this.onEndDateTap,
    required this.onIsFeaturedChanged,
    required this.onIsNewChanged,
    required this.onIsBestSellerChanged,
  });

  final bool isAvailable;
  final bool hasDiscount;
  final bool isFeatured;
  final bool isNew;
  final bool isBestSeller;
  final TextEditingController discountController;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(bool) onHasDiscountChanged;
  final Function(bool) onIsAvailableChanged;
  final Function(bool) onIsFeaturedChanged;
  final Function(bool) onIsNewChanged;
  final Function(bool) onIsBestSellerChanged;
  final Function() onStartDateTap;
  final Function() onEndDateTap;

  @override
  Widget build(BuildContext context) {
    return CustomSectionCard(
      icon: IconlyBold.setting,
      title: 'Product Settings',
      child: Column(
        children: [
          CustomSwitchTile(
            title: 'Product is Available ?',
            subtitle: 'Product Will Appear To Customers When Available',
            value: isAvailable,
            onChanged: (val) => onIsAvailableChanged(val),
          ),
          const Divider(height: 24),
          CustomSwitchTile(
            title: 'Product is Featured ?',
            subtitle: 'Product Will Appear To Customers When Featured',
            value: isFeatured,
            onChanged: (val) => onIsFeaturedChanged(val),
          ),
          const Divider(height: 24),
          CustomSwitchTile(
            title: 'Product is New ?',
            subtitle: 'Product Will Appear To Customers When New',
            value: isNew,
            onChanged: (val) => onIsNewChanged(val),
          ),
          const Divider(height: 24),
          CustomSwitchTile(
            title: 'Product is Best Seller ?',
            subtitle: 'Product Will Appear To Customers When Best Seller',
            value: isBestSeller,
            onChanged: (val) => onIsBestSellerChanged(val),
          ),
          const Divider(height: 24),
          CustomSwitchTile(
            title: 'Apply Discount ?',
            subtitle: 'Product Will Have Discount',
            value: hasDiscount,
            onChanged: (val) => onHasDiscountChanged(val),
          ),
          AnimatedSize(
            duration: 300.ms,
            curve: Curves.easeInOut,
            child: hasDiscount
                ? CustomDiscountDetails(
                    discountController: discountController,
                    startDate: startDate!,
                    endDate: endDate!,
                    onStartDateTap: () async {
                      onStartDateTap();
                    },
                    onEndDateTap: () async {
                      onEndDateTap();
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
