import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_orders_tab_bar_item.dart';

class CustomOrdersManagmentAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomOrdersManagmentAppBar({super.key, required this.onTabSelected});

  final Function(String) onTabSelected;

  @override
  State<CustomOrdersManagmentAppBar> createState() =>
      _CustomOrdersManagmentAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(140); // Adjusted height
}

class _CustomOrdersManagmentAppBarState
    extends State<CustomOrdersManagmentAppBar> {
  int _selectedIndex = 0;
  final List<String> tabs = ['All', 'Pending', 'Delivered', 'Cancelled'];

  // This maps index to an alignment value for the slider
  Alignment _getAlignment(int index) {
    double value = -1.0 + (index * (2.0 / (tabs.length - 1)));
    return Alignment(value, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            'Orders Management',
            style: TextStyle(
              color: Color.fromARGB(255, 165, 101, 56),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Animated Segmented Control
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F5EF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // --- The Sliding Indicator ---
                AnimatedAlign(
                  alignment: _getAlignment(_selectedIndex),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  child: FractionallySizedBox(
                    widthFactor: 1 / tabs.length,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA56538),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFA56538).withOpacity(0.4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // --- The Tab Items (Text) ---
                Row(
                  children: List.generate(tabs.length, (index) {
                    return CustomOrdersTabBarItem(
                      itemText: tabs[index],
                      isSelected: _selectedIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        widget.onTabSelected(tabs[index]);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
