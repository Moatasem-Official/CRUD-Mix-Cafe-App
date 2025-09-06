// lib/widgets/filter_chip_bar.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_cart_screen/custom_checkout_container.dart';

class FilterChipBar extends StatefulWidget {
  const FilterChipBar({super.key, required this.onFilterChanged});

  final Function(int) onFilterChanged;

  @override
  State<FilterChipBar> createState() => _FilterChipBarState();
}

class _FilterChipBarState extends State<FilterChipBar> {
  final List<String> _filters = ['All', 'Pending', 'Delivered', 'Cancelled'];
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FittedBox(
          child: Container(
            height: 50,
            color: const Color.fromARGB(255, 165, 101, 56), // Rich dark brown
            padding: const EdgeInsetsDirectional.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_filters.length, (index) {
                  final bool isActive = _activeIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _activeIndex = index;
                        widget.onFilterChanged(index);
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        _filters[index],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: isActive
                              ? const Color.fromARGB(255, 165, 101, 56)
                              : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// lib/widgets/wave_clipper.dart
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40); // Start from bottom-left with an offset

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30.0);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(
      size.width - (size.width / 4),
      size.height - 60,
    );
    var secondEndPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0); // Go to top-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomerOrdersSliverAppBar extends StatelessWidget {
  const CustomerOrdersSliverAppBar({super.key, required this.onFilterChanged});

  final Function(int) onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true, // The app bar stays visible at the top
      floating: true, // The app bar becomes visible as soon as you scroll up
      elevation: 5,
      title: const Text(
        'Your Orders',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      flexibleSpace: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 165, 101, 56), // Rich dark brown
                Color(0xFF8B4513), // Rich brown
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      surfaceTintColor: const Color(0xFF4E342E), // The color when expanded
      shadowColor: Colors.black.withOpacity(0.3),
      iconTheme: const IconThemeData(color: Colors.white),

      // --- The filter bar at the bottom ---
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: FilterChipBar(onFilterChanged: onFilterChanged),
      ),
    );
  }
}
