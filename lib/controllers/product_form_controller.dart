import 'package:flutter/material.dart';

class ProductFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final discountPercentageController = TextEditingController();
  final quantityController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  String? imageUrl;
  bool isHasDiscount = false;
  bool isAvailable = true;
  bool isFeatured = false;
  bool isNew = false;
  bool isBest = false;

  TimeOfDay? timeStartPicked;
  TimeOfDay? timeEndPicked;
  DateTime? startDate;
  DateTime? endDate;

  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    discountPercentageController.dispose();
    quantityController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
  }
}
