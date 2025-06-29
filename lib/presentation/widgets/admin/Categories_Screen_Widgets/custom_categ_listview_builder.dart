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
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Material(
            borderRadius: BorderRadius.circular(15),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: onTab,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDFBFA),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 28,
                      tooltip: 'Delete',
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                      color: const Color(0xFFA56538),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category $index',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFA56538),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Category Description',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF5C5C5C),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      iconSize: 28,
                      tooltip: 'Edit',
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      color: const Color(0xFFA56538),
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
