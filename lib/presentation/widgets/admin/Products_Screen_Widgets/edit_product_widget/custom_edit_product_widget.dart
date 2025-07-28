import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../data/model/product_model.dart';
import 'custom_action_buttons.dart';
import 'custom_image_uploader.dart';
import 'helper_functions.dart';
import 'main-section_card.dart';
import 'pricing_quality_section_card.dart';
import 'product_settings_section_card.dart';

class CustomEditProductWidget extends StatefulWidget {
  const CustomEditProductWidget({
    super.key,
    this.productModel,
    required this.onSave,
  });

  final ProductModel? productModel;
  final Function() onSave;

  @override
  State<CustomEditProductWidget> createState() =>
      _CustomEditProductWidgetState();
}

class _CustomEditProductWidgetState extends State<CustomEditProductWidget> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _discountController;

  bool _isAvailable = true;
  bool _hasDiscount = false;
  String _selectedCategory = 'Pizzas';

  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _categories = [
    'Pizzas',
    'Sandwichs',
    'Crepes',
    'Meals',
    'Deserts',
    'Drinks',
  ];

  @override
  void initState() {
    super.initState();
    final data = HelperFunctions.initializeFields(widget.productModel);

    _nameController = data.nameController;
    _descriptionController = data.descriptionController;
    _priceController = data.priceController;
    _quantityController = data.quantityController;
    _discountController = data.discountController;
    _isAvailable = data.isAvailable;
    _hasDiscount = data.hasDiscount;
    _selectedCategory = data.selectedCategory;
    _startDate = data.startDate;
    _endDate = data.endDate;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomImageUploader(productModel: widget.productModel!),
          const SizedBox(height: 24),
          MainSectionCard(
            nameController: _nameController,
            descriptionController: _descriptionController,
          ),
          const SizedBox(height: 20),
          PricingQualitySectionCard(
            priceController: _priceController,
            quantityController: _quantityController,
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategoryChanged: (value) =>
                setState(() => _selectedCategory = value),
          ),
          const SizedBox(height: 20),
          ProductSettingsSectionCard(
            isAvailable: _isAvailable,
            hasDiscount: _hasDiscount,
            discountController: _discountController,
            startDate: _startDate,
            endDate: _endDate,
            onIsAvailableChanged: (val) => setState(() => _isAvailable = val),
            onHasDiscountChanged: (val) => setState(() => _hasDiscount = val),
            onStartDateTap: () => _pickDateTime(true),
            onEndDateTap: () => _pickDateTime(false),
          ),
          const SizedBox(height: 32),
          CustomActionButtons(onSave: widget.onSave),
        ],
      ).animate().fadeIn(duration: 500.ms),
    );
  }

  void _pickDateTime(bool isStart) async {
    final picked = await HelperFunctions.selectDateTime(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }
}
