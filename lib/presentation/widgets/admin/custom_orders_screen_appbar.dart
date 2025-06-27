import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_orders_tab_bar_item.dart';

class CustomOrdersManagmentAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomOrdersManagmentAppBar({super.key, required this.onTabSelected});

  final Function(String) onTabSelected;

  @override
  State<CustomOrdersManagmentAppBar> createState() =>
      _CustomOrdersManagmentAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 160);
}

class _CustomOrdersManagmentAppBarState
    extends State<CustomOrdersManagmentAppBar> {
  String selectedTab = 'All';

  final List<String> tabs = [
    'All',
    'Pending',
    'In Progress',
    'Delivered',
    'Cancelled',
  ];

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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: tabs.map((tabText) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: CustomOrdersTabBarItem(
                      itemText: tabText,
                      isSelected: selectedTab == tabText,
                      onTap: () {
                        setState(() {
                          selectedTab = tabText;
                        });
                        widget.onTabSelected(tabText);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
