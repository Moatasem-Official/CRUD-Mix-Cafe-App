import 'package:flutter/material.dart';

class CustomCategoriesListViewBuilder extends StatelessWidget {
  const CustomCategoriesListViewBuilder({super.key});

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
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 242, 238),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              onTap: () {},
              leading: IconButton(
                iconSize: 30,
                tooltip: 'Delete',
                color: const Color.fromARGB(255, 165, 101, 56),
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: const Color.fromARGB(255, 165, 101, 56),
                ),
              ),
              subtitle: const Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,
                'Category Description',
                style: TextStyle(fontSize: 14),
              ),
              title: Text(
                'Category $index',
                style: const TextStyle(
                  color: Color.fromARGB(255, 165, 101, 56),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: IconButton(
                iconSize: 30,
                color: const Color.fromARGB(255, 165, 101, 56),
                tooltip: 'Edit',
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: const Color.fromARGB(255, 165, 101, 56),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
