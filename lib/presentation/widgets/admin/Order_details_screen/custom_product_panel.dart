import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import '../../../../data/model/order_model.dart';
import 'custom_info_panel.dart';
import 'custom_order_items.dart';

class CustomProductPanel extends StatelessWidget {
  const CustomProductPanel({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return CustomInfoPanel(
      icon: IconlyBold.bag_2,
      title: 'Products Summary',
      children: [
        // Products List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: order.items!.length,
          itemBuilder: (context, index) {
            final item = order.items![index];
            return ProductListItem(
              name: item["name"]!,
              quantity: item["quantity"]!,
              price: item["price"]!.toDouble(),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
        const Divider(height: 24),
        // Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Price',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'EGP ${order.totalPrice!.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
