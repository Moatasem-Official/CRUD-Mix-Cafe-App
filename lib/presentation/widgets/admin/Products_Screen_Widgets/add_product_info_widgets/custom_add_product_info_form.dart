import 'package:flutter/material.dart';
import 'discount_widget.dart';
import 'without_discount_widget.dart';

class CustomAddProductInformationForm extends StatefulWidget {
  CustomAddProductInformationForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descController,
    required this.priceController,
    required this.discountPercentageController,
    required this.quantityController,
    required this.startDateController,
    required this.endDateController,
    required this.timeStartPicked,
    required this.timeEndPicked,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
    required this.isHasDiscount,
    required this.onSwitchChanged,
    required this.onImageSelected,
    required this.onStartDatePicked,
    required this.onEndDatePicked,
    required this.onStartTimePicked,
    required this.onEndTimePicked,
    required this.categoryId,
    required this.onAddProduct,
    required this.startTimeController,
    required this.endTimeController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController priceController;
  final TextEditingController discountPercentageController;
  final TextEditingController quantityController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final int categoryId;
  TimeOfDay? timeStartPicked;
  TimeOfDay? timeEndPicked;
  DateTime? startDate;
  DateTime? endDate;
  final String? imageUrl;
  final bool isHasDiscount;
  final Function(bool value) onSwitchChanged;
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
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WithoutDiscountWidget(
              nameController: widget.nameController,
              descController: widget.descController,
              priceController: widget.priceController,
              quantityController: widget.quantityController,
              imageUrl: widget.imageUrl,
              onImageSelected: widget.onImageSelected,
            ),

            const SizedBox(height: 20),

            // Switch العرض
            Row(
              children: [
                Switch(
                  value: widget.isHasDiscount,
                  onChanged: widget.onSwitchChanged,
                  activeColor: const Color(0xFF8B5E3C), // بني غني
                  inactiveThumbColor: const Color(0xFFD7B899), // بيج ناعم
                  inactiveTrackColor: const Color(
                    0xFFF3E3D3,
                  ), // بيج أفتح لمسار التراك
                  trackOutlineColor: WidgetStateProperty.all(
                    const Color(0xFFDCC6B1), // تحديد بسيط للمسار
                  ),
                  splashRadius: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Has Discount ?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8B4513),
                  ),
                ),
              ],
            ),
            // تفاصيل العرض
            if (widget.isHasDiscount) ...[
              const SizedBox(height: 16),
              DiscountWidget(
                discountPercentageController:
                    widget.discountPercentageController,
                startDateController: widget.startDateController,
                startTimeController: widget.startTimeController,
                endDateController: widget.endDateController,
                endTimeController: widget.endTimeController,
                startDate: widget.startDate ?? DateTime.now(),
                endDate:
                    widget.endDate ??
                    DateTime.now().add(const Duration(days: 7)),
                timeStartPicked: widget.timeStartPicked ?? TimeOfDay.now(),
                timeEndPicked: widget.timeEndPicked ?? TimeOfDay.now(),
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
                  if (widget.formKey.currentState!.validate()) {
                    widget.formKey.currentState!.save();
                    widget.onAddProduct();
                    // هنا يمكنك إضافة الكود لإضافة المنتج إلى قاعدة البيانات
                    // على سبيل المثال، يمكنك استدعاء دالة من FirestoreServices
                    // لإضافة المنتج باستخدام البيانات التي تم جمعها من النموذج.
                    // مثال:
                    // FirestoreServices().addProduct(
                    //   categoryId: 0, // يجب تعديل هذا حسب الفئة المختارة
                    //   name: widget.nameController.text,
                    //   description: widget.descController.text,
                    //   price: double.parse(widget.priceController.text),
                    //   quantity: int.parse(widget.quantityController.text),
                    //   image: widget.imageUrl ?? '',
                    //   startDiscount: widget.startDate,
                    //   endDiscount: widget.endDate,
                    //   discountPercentage: double.tryParse(
                    //     widget.discountPercentageController.text,
                    //   ),
                    //   hasDiscount: widget.isHasDiscount,
                    //   isAvailable: true, // أو أي قيمة أخرى حسب الحاجة
                    // );
                  }
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text("Add Product"),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF8B4513),
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
