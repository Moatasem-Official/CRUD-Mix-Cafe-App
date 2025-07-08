import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';
import '../../widgets/admin/Products_Screen_Widgets/add_product_info_widgets/custom_add_product_info_form.dart';

class ProductInformationForm extends StatefulWidget {
  const ProductInformationForm({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<ProductInformationForm> createState() => _ProductInformationFormState();
}

class _ProductInformationFormState extends State<ProductInformationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountPercentageController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  TimeOfDay? _timeStartPicked;
  TimeOfDay? _timeEndPicked;
  DateTime? _startDate; // تاريخ بداية الخصم
  DateTime? _endDate; // تاريخ نهاية الخصم

  String? _imageUrl; // في الوقت الحالي نعتبر الصورة رابط
  bool isHasDiscount = false;
  bool isAvailable = true; // حالة التوفر الافتراضية

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _discountPercentageController.dispose();
    _quantityController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
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
              formKey: _formKey,
              nameController: _nameController,
              descController: _descController,
              priceController: _priceController,
              discountPercentageController: _discountPercentageController,
              imageUrl: _imageUrl,
              onSwitchChanged: (value) {
                setState(() {
                  isHasDiscount = value;
                });
              },
              isHasDiscount: isHasDiscount,
              quantityController: _quantityController,
              startTimeController: _startTimeController,
              endTimeController: _endTimeController,
              startDateController: _startDateController,
              endDateController: _endDateController,
              onImageSelected: (image) {
                setState(() {
                  _imageUrl = image;
                });
              },
              onStartDatePicked: (onStartDatePicked) {
                setState(() {
                  _startDate = onStartDatePicked;
                  _startDateController.text =
                      "${onStartDatePicked.year}-${onStartDatePicked.month.toString().padLeft(2, '0')}-${onStartDatePicked.day.toString().padLeft(2, '0')}";
                });
              },
              onEndDatePicked: (onEndDatePicked) {
                setState(() {
                  _endDate = onEndDatePicked;
                  _endDateController.text =
                      "${onEndDatePicked.year}-${onEndDatePicked.month.toString().padLeft(2, '0')}-${onEndDatePicked.day.toString().padLeft(2, '0')}";
                });
              },
              onStartTimePicked: (onStartTimePicked) {
                setState(() {
                  _timeStartPicked = onStartTimePicked;
                  _startTimeController.text = onStartTimePicked.format(context);
                });
              },
              onEndTimePicked: (onEndTimePicked) {
                setState(() {
                  _timeEndPicked = onEndTimePicked;
                  _endTimeController.text = onEndTimePicked.format(context);
                });
              },
              timeStartPicked: _timeStartPicked ?? TimeOfDay.now(),
              timeEndPicked: _timeEndPicked ?? TimeOfDay.now(),
              startDate: _startDate ?? DateTime.now(),
              endDate: _endDate ?? DateTime.now().add(const Duration(days: 7)),
              categoryId: widget.categoryId, // هنا يمكنك تحديد الفئة المناسبة
              onAddProduct: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (_imageUrl == null || _imageUrl!.isEmpty) {
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
                    name: _nameController.text,
                    description: _descController.text,
                    price: double.parse(_priceController.text),
                    quantity: int.parse(_quantityController.text),
                    image: _imageUrl ?? '',
                    startDiscountDate: _startDateController.text,
                    endDiscountDate: _endDateController.text,
                    startDiscountTime: _startTimeController.text,
                    endDiscountTime: _endTimeController.text,
                    discountPercentage: double.tryParse(
                      _discountPercentageController.text,
                    ),
                    hasDiscount: isHasDiscount,
                    isAvailable: isAvailable, // أو أي قيمة أخرى حسب الحاجة
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product added successfully!'),
                    ),
                  );
                  Navigator.of(context).pop(); // العودة إلى الشاشة السابقة
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
