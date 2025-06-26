import 'package:flutter/material.dart';

class CustomAddingCategoryForm extends StatelessWidget {
  const CustomAddingCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 242, 238),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Material(
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category Name',
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Material(
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category Description',
                  ),
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 16.0),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: const Color.fromARGB(255, 165, 101, 56),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'Add Category',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
