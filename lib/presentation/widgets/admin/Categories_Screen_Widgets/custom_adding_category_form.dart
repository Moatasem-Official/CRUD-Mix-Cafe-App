import 'package:flutter/material.dart';

class CustomAddingCategoryForm extends StatelessWidget {
  const CustomAddingCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF9F6), // خلفية ناعمة
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Add New Category",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6F4E37),
              ),
            ),
            const SizedBox(height: 20),

            // اسم التصنيف
            TextField(
              decoration: InputDecoration(
                labelText: 'Category Name',
                filled: true,
                fillColor: Colors.white,
                labelStyle: const TextStyle(color: Colors.brown),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.brown),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // وصف التصنيف
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Category Description',
                filled: true,
                fillColor: Colors.white,
                labelStyle: const TextStyle(color: Colors.brown),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.brown),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // زر الإضافة
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text(
                "Add Category",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF6F4E37),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
