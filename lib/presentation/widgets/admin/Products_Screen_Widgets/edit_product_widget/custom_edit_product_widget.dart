import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/data/helpers/custom_snack_bar.dart';
import 'package:mix_cafe_app/data/helpers/when_loading_widget.dart';
import '../../../../../bussines_logic/cubits/admin/categories_screen/cubit/categories_cubit.dart';
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
    this.categoryId,
  });

  final ProductModel? productModel;
  final int? categoryId;

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
  final _formKey = GlobalKey<FormState>();

  bool _isAvailable = true;
  bool _hasDiscount = false;
  bool _isFeatured = false;
  bool _isNew = false;
  bool _isBestSeller = false;
  String _selectedCategory = 'Pizzas';

  DateTime? _startDate;
  DateTime? _endDate;

  bool isLoading = false;

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
    _isFeatured = data.isFeatured;
    _isNew = data.isNew;
    _isBestSeller = data.isBestSeller;
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
    return Stack(
      children: [
        BlocListener<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
            if (state is EditProductLoading) {
              setState(() {
                isLoading = true;
              });
            } else if (state is EditProductSuccess) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  title: 'Success',
                  contentType: ContentType.success,
                ),
              );
              Navigator.pop(context);
            } else if (state is EditProductError) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.errorMessage,
                  title: 'Error',
                  contentType: ContentType.failure,
                ),
              );
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                overflow: TextOverflow.ellipsis,
                'Edit Product',
                style: TextStyle(
                  color: Color(0xFF6F4E37),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
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
                      isBestSeller: _isBestSeller,
                      isNew: _isNew,
                      isFeatured: _isFeatured,
                      discountController: _discountController,
                      startDate: _startDate,
                      endDate: _endDate,
                      onIsAvailableChanged: (val) =>
                          setState(() => _isAvailable = val),
                      onHasDiscountChanged: (val) =>
                          setState(() => _hasDiscount = val),
                      onIsBestSellerChanged: (val) =>
                          setState(() => _isBestSeller = val),
                      onIsNewChanged: (val) => setState(() => _isNew = val),
                      onIsFeaturedChanged: (val) =>
                          setState(() => _isFeatured = val),
                      onStartDateTap: () => _pickDateTime(true),
                      onEndDateTap: () => _pickDateTime(false),
                    ),
                    const SizedBox(height: 32),
                    CustomActionButtons(
                      onSave: () async {
                        // ... (كود التحقق من الصحة كما هو)
                        final bool isValid =
                            _formKey.currentState?.validate() ?? false;
                        if (!isValid) {
                          return;
                        }

                        print(
                          '--- Validation PASSED! Proceeding to update... ---',
                        );

                        // --- 👇 أضف هذا الجزء للتشخيص ---
                        print('--- CHECKING WIDGET VALUES ---');
                        print(
                          'Value of widget.categoryId is: ${widget.categoryId}',
                        );
                        print(
                          'Value of widget.productModel is: ${widget.productModel}',
                        );

                        if (widget.categoryId == null) {
                          print(
                            '❌ FATAL ERROR: categoryId is NULL. Stopping execution.',
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'CRITICAL ERROR: Category ID is missing!',
                              ),
                            ),
                          );
                          return;
                        }

                        if (widget.productModel == null) {
                          print(
                            '❌ FATAL ERROR: productModel is NULL. Stopping execution.',
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'CRITICAL ERROR: Product data is missing!',
                              ),
                            ),
                          );
                          return;
                        }
                        // --- نهاية جزء التشخيص ---

                        print(
                          '--- All values seem OK. Building updated model... ---',
                        );
                        final updatedProduct = _buildUpdatedProductModel();

                        print('--- Calling Cubit to update product... ---');
                        await context.read<CategoriesCubit>().updateProduct(
                          widget.categoryId!,
                          updatedProduct,
                        );
                      },
                    ),
                  ],
                ).animate().fadeIn(duration: 500.ms),
              ),
            ),
          ),
        ),
        isLoading ? const WhenLoadingLogInWidget() : Container(),
      ],
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

  ProductModel _buildUpdatedProductModel() {
    final double price = double.tryParse(_priceController.text) ?? 0.0;
    final int quantity = int.tryParse(_quantityController.text) ?? 0;
    final double discountPercent =
        double.tryParse(_discountController.text) ?? 0.0;

    final double discountedPrice = _hasDiscount
        ? price * (1 - discountPercent / 100)
        : price; // إذا لم يكن هناك خصم، فالسعر المخفض هو السعر الأصلي

    return ProductModel(
      id: widget.productModel!.id,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      price: price,
      quantity: quantity,
      isAvailable: _isAvailable,
      hasDiscount: _hasDiscount,
      isFeatured: _isFeatured,
      isNew: _isNew,
      isBestSeller: _isBestSeller,
      imageUrl: widget.productModel!.imageUrl, // يجب تحديث هذا عند تغيير الصورة
      category: _selectedCategory,
      startDiscount: _startDate,
      endDiscount: _endDate,
      discountedPrice: discountedPrice,
      discountPercentage: discountPercent,
      timestamp: widget.productModel!.timestamp, // أو استخدم timestamp جديد
    );
  }
}
