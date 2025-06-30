import 'package:flutter/material.dart';

class CustomCategoriesListViewBuilder extends StatelessWidget {
  const CustomCategoriesListViewBuilder({super.key, this.onTab});

  final Function()? onTab;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(8),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: onTab,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF9F6), // كريمي فاتح
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.07),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // أيقونة دائرية رمزية
                    CircleAvatar(
                      backgroundColor: const Color(0xFFD7B49E), // بني فاتح
                      radius: 24,
                      child: const Icon(
                        Icons.category_outlined,
                        color: Color(0xFF6F4E37), // بني غامق
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // النصوص
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category $index',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4B322D), // بني داكن
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Category description goes here...',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF7C6A63), // رمادي بني
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // أيقونات التعديل والحذف
                    Column(
                      children: [
                        IconButton(
                          tooltip: 'Edit',
                          icon: const Icon(Icons.edit_outlined),
                          color: const Color(0xFF8B5E3C), // نحاسي غامق
                          onPressed: () {},
                        ),
                        IconButton(
                          tooltip: 'Delete',
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.red[300], // أحمر خفيف
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
