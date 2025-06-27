import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_orders_drop_menu_item.dart';

class CustomOrdersManagmentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomOrdersManagmentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: true,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'Orders Managment',
              style: TextStyle(
                color: Color(0xFF6F4E37),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Orders by Customer Name or Order ID',
                  prefixIcon: Icon(Icons.search, color: Color(0xFF6F4E37)),
                ),
              ),
            ),
          ),
          Text(
            'Sort By',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6F4E37),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Row(
              children: const [
                Expanded(
                  child: CustomOrdersDropdownMenuItem(
                    menuHintText: 'Status',
                    label1: 'Pending',
                    label2: 'In Progress',
                    label3: 'Delivered',
                    value1: 'Pending',
                    value2: 'In Progress',
                    value3: 'Delivered',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomOrdersDropdownMenuItem(
                    menuHintText: 'Date',
                    label1: 'Today',
                    label2: 'This Week',
                    label3: 'This Month',
                    value1: 'Today',
                    value2: 'This Week',
                    value3: 'This Month',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 220);
}
