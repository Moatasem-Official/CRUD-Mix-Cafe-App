import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'custom_section_card.dart';
import 'custom_text_field.dart';

class MainSectionCard extends StatelessWidget {
  const MainSectionCard({
    super.key,
    required TextEditingController nameController,
    required TextEditingController descriptionController,
  }) : _nameController = nameController,
       _descriptionController = descriptionController;

  final TextEditingController _nameController;
  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return CustomSectionCard(
      icon: IconlyBold.edit,
      title: 'Main Information',
      child: Column(
        children: [
          CustomTextField(
            controller: _nameController,
            label: 'Product Name',
            icon: IconlyLight.document,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _descriptionController,
            label: 'Product Description',
            icon: IconlyLight.info_square,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
