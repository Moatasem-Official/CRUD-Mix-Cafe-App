import 'package:flutter/material.dart';
import 'custom_build_section.dart';
import 'helper_functions.dart';

class MainOfferDetailsSection extends StatelessWidget {
  const MainOfferDetailsSection({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return CustomBuildSection(
      title: 'تفاصيل العرض الأساسية',
      icon: Icons.edit_note,
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: HelperFunctions.buildInputDecoration(
              'عنوان العرض',
              Icons.title,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            decoration: HelperFunctions.buildInputDecoration(
              'وصف العرض',
              Icons.description,
            ),
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
