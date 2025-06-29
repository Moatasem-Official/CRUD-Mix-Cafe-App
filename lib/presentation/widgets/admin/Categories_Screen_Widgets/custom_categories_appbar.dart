import 'package:flutter/material.dart';

class CustomCategoriesAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomCategoriesAppBar({
    super.key,
    required this.onPressed,
    required this.title,
    required this.buttonText,
    this.onChange,
    this.onSubmitted,
  });
  final String? title;
  final String? buttonText;
  final Function()? onPressed;
  final Function(String searchValue)? onChange;
  final Function(String searchValue)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFDF9F6),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 25),
              // 🔙 Title with optional Back Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title != 'Categories')
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFF6F4E37),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  Expanded(
                    child: Center(
                      child: Text(
                        title ?? 'Dashboard',
                        style: const TextStyle(
                          color: Color(0xFF6F4E37),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (title != 'Categories')
                    const SizedBox(width: 48), // space to balance the row
                ],
              ),

              const SizedBox(height: 16),

              // 🔍 Search Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.07),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                height: 48,
                alignment: Alignment.center,
                child: TextField(
                  onChanged: onChange,
                  onSubmitted: onSubmitted,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Search for Category of $title ...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.brown),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // 🟠 Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.add, color: Colors.white, size: 26),
              label: Text(
                buttonText ?? 'Add New',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6F4E37),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(190);
}
