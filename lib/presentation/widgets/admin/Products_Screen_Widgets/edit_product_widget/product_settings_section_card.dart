import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Products_Screen_Widgets/edit_product_widget/custom_discount_details.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Products_Screen_Widgets/edit_product_widget/custom_section_card.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Products_Screen_Widgets/edit_product_widget/custom_switch_tile.dart';

class ProductSettingsSectionCard extends StatelessWidget {
  const ProductSettingsSectionCard({
    super.key,
    required this.isAvailable,
    required this.hasDiscount,
    required this.discountController,
    this.startDate,
    this.endDate,
    required this.onHasDiscountChanged,
    required this.onIsAvailableChanged,
    required this.onStartDateTap,
    required this.onEndDateTap,
  });

  final bool isAvailable;
  final bool hasDiscount;
  final TextEditingController discountController;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(bool) onHasDiscountChanged;
  final Function(bool) onIsAvailableChanged;
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
