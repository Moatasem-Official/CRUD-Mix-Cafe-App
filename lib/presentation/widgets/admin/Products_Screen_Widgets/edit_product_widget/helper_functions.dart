import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';

class HelperFunctions {
  static Future<DateTime?> selectDateTime({
    required BuildContext context,
    DateTime? initialDate,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate == null) return null;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate ?? DateTime.now()),
    );

    if (pickedTime == null) return null;

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }

  static ProductInitData initializeFields(ProductModel? productModel) {
    final product =
        productModel ??
        ProductModel(
          id: '',
          imageUrl: '',
          name: '',
          description: '',
          price: 0,
          quantity: 0,
          discountPercentage: 0,
          isAvailable: true,
          hasDiscount: false,
          category: 'Sandwichs',
          isBestSeller: false,
          isFeatured: false,
          isNew: false,
          discountedPrice: 0,
          endDiscount: DateTime.now(),
          startDiscount: DateTime.now(),
          timestamp: DateTime.now(),
        );

    return ProductInitData(
      nameController: TextEditingController(text: product.name),
      descriptionController: TextEditingController(text: product.description),
      priceController: TextEditingController(text: product.price.toString()),
      quantityController: TextEditingController(
        text: product.quantity.toString(),
      ),
      discountController: TextEditingController(
        text: (product.price > 0 && product.discountedPrice > 0)
            ? (100 - ((product.discountedPrice / product.price) * 100))
                  .toStringAsFixed(1)
            : '0.0',
      ),
      isAvailable: product.isAvailable,
      hasDiscount: product.hasDiscount,
      selectedCategory: product.category,
      startDate: product.startDiscount!,
      endDate: product.endDiscount!,
    );
  }
}

class ProductInitData {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final TextEditingController discountController;
  final bool isAvailable;
  final bool hasDiscount;
  final String selectedCategory;
  final DateTime startDate;
  final DateTime endDate;

  ProductInitData({
    required this.nameController,
    required this.descriptionController,
    required this.priceController,
    required this.quantityController,
    required this.discountController,
    required this.isAvailable,
    required this.hasDiscount,
    required this.selectedCategory,
    required this.startDate,
    required this.endDate,
  });
}
