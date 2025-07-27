import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart'; // استيراد المكتبة الجديدة
import 'package:mix_cafe_app/data/model/product_model.dart';

class CustomEditProductWidget extends StatefulWidget {
  const CustomEditProductWidget({super.key, this.productModel});

  final ProductModel? productModel;

  @override
  State<CustomEditProductWidget> createState() =>
      _CustomEditProductWidgetState();
}

class _CustomEditProductWidgetState extends State<CustomEditProductWidget> {
  // ... (المتحكمات والمتغيرات السابقة كما هي)
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _discountController;

  bool _isAvailable = true;
  bool _hasDiscount = false;
  String _selectedCategory = 'Pizzas';

  // --- إضافة متغيرات الحالة الجديدة للتاريخ والوقت ---
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
    final product =
        widget.productModel ??
        ProductModel(
          // ... (القيم الافتراضية كما هي)
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
    _nameController = TextEditingController(text: product.name);
    _descriptionController = TextEditingController(text: product.description);
    _priceController = TextEditingController(text: product.price.toString());
    _quantityController = TextEditingController(
      text: product.quantity.toString(),
    );
    _discountController = TextEditingController(
      text: (100 - ((product.discountedPrice / product.price) * 100))
          .toStringAsFixed(1),
    );
    _isAvailable = product.isAvailable;
    _hasDiscount = product.hasDiscount;
    _selectedCategory = product.category;

    // --- تهيئة متغيرات التاريخ من المنتج ---
    _startDate = product.startDiscount;
    _endDate = product.endDiscount;
  }

  @override
  void dispose() {
    // ... (dispose للمتحكمات كما هي)
    super.dispose();
  }

  // --- دالة جديدة لاختيار التاريخ والوقت ---
  Future<void> _selectDateTime({required bool isStart}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: (isStart ? _startDate : _endDate) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate == null || !mounted) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        (isStart ? _startDate : _endDate) ?? DateTime.now(),
      ),
    );

    if (pickedTime == null || !mounted) return;

    final newDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      if (isStart) {
        _startDate = newDateTime;
      } else {
        _endDate = newDateTime;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // ... (الأقسام السابقة كما هي)
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImageUploader(),
          const SizedBox(height: 24),
          _buildSectionCard(
            icon: IconlyBold.edit,
            title: 'المعلومات الأساسية',
            child: Column(
              children: [
                _buildTextField(
                  controller: _nameController,
                  label: 'اسم المنتج',
                  icon: IconlyLight.document,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _descriptionController,
                  label: 'وصف المنتج',
                  icon: IconlyLight.info_square,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            icon: IconlyBold.wallet,
            title: 'التسعير والمخزون',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _priceController,
                        label: 'السعر',
                        icon: Icons.attach_money_rounded,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _quantityController,
                        label: 'الكمية المتاحة',
                        icon: IconlyLight.bag,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildCategoryDropdown(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // --- قسم الإعدادات المتقدمة (تم تعديله) ---
          _buildSectionCard(
            icon: IconlyBold.setting,
            title: 'الإعدادات',
            child: Column(
              children: [
                _buildSwitchTile(
                  title: 'المنتج متاح؟',
                  subtitle: 'سيظهر المنتج للعملاء عند تفعيله',
                  value: _isAvailable,
                  onChanged: (val) => setState(() => _isAvailable = val),
                ),
                const Divider(height: 24),
                _buildSwitchTile(
                  title: 'تطبيق خصم؟',
                  subtitle: 'تفعيل الخصم على هذا المنتج',
                  value: _hasDiscount,
                  onChanged: (val) => setState(() => _hasDiscount = val),
                ),
                AnimatedSize(
                  duration: 300.ms,
                  curve: Curves.easeInOut,
                  child: _hasDiscount
                      ? _buildDiscountFields()
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildActionButtons(),
        ],
      ).animate().fadeIn(duration: 500.ms),
    );
  }

  // --- ويدجت جديد لعرض حقول الخصم ---
  Widget _buildDiscountFields() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          _buildTextField(
            controller: _discountController,
            label: 'نسبة الخصم (%)',
            icon: IconlyLight.discount,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          // --- حقول التاريخ والوقت الجديدة ---
          Row(
            children: [
              Expanded(
                child: _buildDateTimePickerField(
                  label: 'تاريخ البدء',
                  date: _startDate,
                  onTap: () => _selectDateTime(isStart: true),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDateTimePickerField(
                  label: 'تاريخ الانتهاء',
                  date: _endDate,
                  onTap: () => _selectDateTime(isStart: false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- ويدجت جديد لعرض حقل التاريخ والوقت ---
  Widget _buildDateTimePickerField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF4E342E).withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(IconlyLight.calendar, color: Color(0xFFC58B3E)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date != null
                        // تنسيق التاريخ والوقت بشكل جميل
                        ? DateFormat('dd MMM, yyyy  hh:mm a').format(date)
                        : 'لم يتم التحديد',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF4E342E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // --- Widgets مساعدة لتحسين قراءة الكود ---

  /// ويدجت خاص برفع الصورة
  Widget _buildImageUploader() {
    return Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFC58B3E).withOpacity(0.5),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    widget.productModel?.imageUrl ??
                        'https://placehold.co/400x400/FFF8F0/4E342E?text=Upload',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFC58B3E),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      // TODO: Implement image picking logic
                    },
                    icon: const Icon(
                      IconlyBold.camera,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .slideY(begin: 0.5, duration: 600.ms, curve: Curves.easeOutCubic)
        .fadeIn();
  }

  /// ويدجت لتصميم كارت لكل قسم
  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF4E342E)),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4E342E),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          child,
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 500.ms).moveY(begin: 20);
  }

  /// ويدجت لتصميم حقل الإدخال
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(color: const Color(0xFF4E342E)),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFC58B3E)),
        filled: true,
        fillColor: const Color(0xFF4E342E).withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFC58B3E), width: 2),
        ),
      ),
    );
  }

  /// ويدجت لتصميم القائمة المنسدلة للأصناف
  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      onChanged: (value) {
        if (value != null) {
          setState(() => _selectedCategory = value);
        }
      },
      style: GoogleFonts.poppins(color: const Color(0xFF4E342E)),
      decoration: InputDecoration(
        labelText: 'الصنف',
        prefixIcon: const Icon(IconlyLight.category, color: Color(0xFFC58B3E)),
        filled: true,
        fillColor: const Color(0xFF4E342E).withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: _categories.map((category) {
        return DropdownMenuItem(value: category, child: Text(category));
      }).toList(),
    );
  }

  /// ويدجت لتصميم مفتاح التبديل
  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade600),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFFC58B3E),
      contentPadding: EdgeInsets.zero,
    );
  }

  /// ويدجت لتصميم أزرار الحفظ والإلغاء
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(IconlyLight.close_square),
            label: const Text('إلغاء'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              foregroundColor: Colors.grey.shade700,
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement save logic
            },
            icon: const Icon(IconlyBold.tick_square, color: Colors.white),
            label: const Text(
              'حفظ التعديلات',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: const Color(0xFFC58B3E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: const Color(0xFFC58B3E).withOpacity(0.4),
            ),
          ),
        ),
      ],
    ).animate().slideY(
      begin: 1,
      delay: 400.ms,
      duration: 600.ms,
      curve: Curves.elasticOut,
    );
  }
}
