import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Products_Screen_Widgets/add_product_info_widgets/custom_switchs.dart';
import '../../../../../controllers/product_form_controller.dart';
import 'discount_widget.dart';
import 'without_discount_widget.dart';

class CustomAddProductInformationForm extends StatefulWidget {
  const CustomAddProductInformationForm({
    super.key,
    required this.controller,
    required this.onImageSelected,
    required this.onStartDatePicked,
    required this.onEndDatePicked,
    required this.onStartTimePicked,
    required this.onEndTimePicked,
    required this.onAddProduct,
    required this.categoryId,
    required this.onHasDiscountSwitchChanged,
    required this.onIsNewSwitchChanged,
    required this.onIsFeaturedSwitchChanged,
    required this.onIsBestSwitchChanged,
  });

  final ProductFormController controller;
  final int categoryId;
  final Function(bool value) onHasDiscountSwitchChanged;
  final Function(bool value) onIsNewSwitchChanged;
  final Function(bool value) onIsFeaturedSwitchChanged;
  final Function(bool value) onIsBestSwitchChanged;
  final void Function(String image) onImageSelected;
  final Function(DateTime onStartDatePicked) onStartDatePicked;
  final Function(DateTime onEndDatePicked) onEndDatePicked;
  final Function(TimeOfDay onStartTimePicked) onStartTimePicked;
  final Function(TimeOfDay onEndTimePicked) onEndTimePicked;
  final Function() onAddProduct;

  @override
  State<CustomAddProductInformationForm> createState() =>
      _CustomAddProductInformationFormState();
}

class _CustomAddProductInformationFormState
    extends State<CustomAddProductInformationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WithoutDiscountWidget(
              nameController: widget.controller.nameController,
              descController: widget.controller.descController,
              priceController: widget.controller.priceController,
              quantityController: widget.controller.quantityController,
              imageUrl: widget.controller.imageUrl,
              onImageSelected: widget.onImageSelected,
            ),

            const SizedBox(height: 20),

            ProductPropertiesCard(
              isNew: widget.controller.isNew,
              isFeatured: widget.controller.isFeatured,
              isBest: widget.controller.isBest,
              hasDiscount: widget.controller.isHasDiscount,
              onIsNewChanged: widget.onIsNewSwitchChanged,
              onIsFeaturedChanged: widget.onIsFeaturedSwitchChanged,
              onIsBestChanged: widget.onIsBestSwitchChanged,
              onHasDiscountChanged: widget.onHasDiscountSwitchChanged,
            ),
            // تفاصيل العرض
            if (widget.controller.isHasDiscount) ...[
              const SizedBox(height: 16),
              DiscountWidget(
                discountPercentageController:
                    widget.controller.discountPercentageController,
                startDateController: widget.controller.startDateController,
                startTimeController: widget.controller.startTimeController,
                endDateController: widget.controller.endDateController,
                endTimeController: widget.controller.endTimeController,
                startDate: widget.controller.startDate ?? DateTime.now(),
                endDate:
                    widget.controller.endDate ??
                    DateTime.now().add(const Duration(days: 7)),
                timeStartPicked:
                    widget.controller.timeStartPicked ?? TimeOfDay.now(),
                timeEndPicked:
                    widget.controller.timeEndPicked ?? TimeOfDay.now(),
                onStartDatePicked: widget.onStartDatePicked,
                onEndDatePicked: widget.onEndDatePicked,
                onStartTimePicked: widget.onStartTimePicked,
                onEndTimePicked: widget.onEndTimePicked,
              ),
            ],

            const SizedBox(height: 28),

            // زر إضافة المنتج
            Center(
              child: FilledButton.icon(
                onPressed: () {
                  if (widget.controller.formKey.currentState!.validate()) {
                    widget.controller.formKey.currentState!.save();
                    widget.onAddProduct();
                  }
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text("Add Product"),
                style: FilledButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 165, 101, 56),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
