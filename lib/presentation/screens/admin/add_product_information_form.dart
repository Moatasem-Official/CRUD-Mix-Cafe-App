import 'package:flutter/material.dart';
import 'package:mix_cafe_app/controllers/product_form_controller.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';
import '../../widgets/admin/Products_Screen_Widgets/add_product_info_widgets/custom_add_product_info_form.dart';

class ProductInformationForm extends StatefulWidget {
  const ProductInformationForm({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<ProductInformationForm> createState() => _ProductInformationFormState();
}

class _ProductInformationFormState extends State<ProductInformationForm> {
  late final ProductFormController _formController;
  @override
  void initState() {
    super.initState();
    _formController = ProductFormController();
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color(0xFF8B4513), // كابتشينو ناعم
          elevation: 2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          centerTitle: true,
          title: const Text(
            'Product Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 1.1,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomAddProductInformationForm(
              controller: _formController,
              onSwitchChanged: (value) {
                setState(() {
                  _formController.isHasDiscount = value;
                });
              },
              onImageSelected: (image) {
                setState(() {
                  _formController.imageUrl = image;
                });
              },
              onStartDatePicked: (onStartDatePicked) {
                setState(() {
                  _formController.startDate = onStartDatePicked;
                  _formController.startDateController.text =
                      "${onStartDatePicked.year}-${onStartDatePicked.month.toString().padLeft(2, '0')}-${onStartDatePicked.day.toString().padLeft(2, '0')}";
                });
              },
              onEndDatePicked: (onEndDatePicked) {
                setState(() {
                  _formController.endDate = onEndDatePicked;
                  _formController.endDateController.text =
                      "${onEndDatePicked.year}-${onEndDatePicked.month.toString().padLeft(2, '0')}-${onEndDatePicked.day.toString().padLeft(2, '0')}";
                });
              },
              onStartTimePicked: (onStartTimePicked) {
                setState(() {
                  _formController.timeStartPicked = onStartTimePicked;
                  _formController.startTimeController.text = onStartTimePicked
                      .format(context);
                });
              },
              onEndTimePicked: (onEndTimePicked) {
                setState(() {
                  _formController.timeEndPicked = onEndTimePicked;
                  _formController.endTimeController.text = onEndTimePicked
                      .format(context);
                });
              },
              categoryId: widget.categoryId,
              onAddProduct: () {
                if (_formController.formKey.currentState!.validate()) {
                  _formController.formKey.currentState!.save();
                  if (_formController.imageUrl == null ||
                      _formController.imageUrl!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select an image for the product.',
                        ),
                      ),
                    );
                    return;
                  }
                  FirestoreServices().addProduct(
                    categoryId:
                        widget.categoryId, // يجب تعديل هذا حسب الفئة المختارة
                    name: _formController.nameController.text,
                    description: _formController.descController.text,
                    price: double.parse(_formController.priceController.text),
                    quantity: int.parse(
                      _formController.quantityController.text,
                    ),
                    image: _formController.imageUrl ?? '',
                    startDiscountDate: _formController.startDateController.text,
                    endDiscountDate: _formController.endDateController.text,
                    startDiscountTime: _formController.startTimeController.text,
                    endDiscountTime: _formController.endTimeController.text,
                    discountPercentage: double.tryParse(
                      _formController.discountPercentageController.text,
                    ),
                    hasDiscount: _formController.isHasDiscount,
                    isAvailable: _formController.isAvailable,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product added successfully!'),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
