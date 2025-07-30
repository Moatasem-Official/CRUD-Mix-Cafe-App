import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AdminAddOfferScreen extends StatefulWidget {
  const AdminAddOfferScreen({super.key});

  @override
  State<AdminAddOfferScreen> createState() => _AdminAddOfferScreenState();
}

// Add SingleTickerProviderStateMixin for animation
class _AdminAddOfferScreenState extends State<AdminAddOfferScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _discountController = TextEditingController();

  // State variables
  DateTime? _startDate;
  DateTime? _endDate;
  File? _offerImage;
  bool _isLoading = false;

  // Animation
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Theme color
  final Color _primaryColor = const Color.fromARGB(255, 165, 101, 56);
  final Color _secondaryColor = const Color.fromARGB(255, 195, 131, 86);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _discountController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _offerImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDateTime({required bool isStartDate}) async {
    // ... same logic as before
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null || !mounted) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    setState(() {
      final selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      if (isStartDate) {
        _startDate = selectedDateTime;
      } else {
        _endDate = selectedDateTime;
      }
    });
  }

  void _submitOffer() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid || _startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("الرجاء تعبئة جميع الحقول وتحديد التواريخ"),
        ),
      );
      return;
    }
    if (_offerImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("الرجاء اختيار صورة للعرض")));
      return;
    }
    if (_endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تاريخ النهاية يجب أن يكون بعد تاريخ البداية"),
        ),
      );
      return;
    }
    setState(() => _isLoading = true);
    // Simulate network call
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Implement your actual logic to save data to Firebase/API
    // String title = _titleController.text;
    // String description = _descriptionController.text;
    // double discount = double.parse(_discountController.text);
    // ... send all data

    setState(() => _isLoading = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("🎉 تم إضافة العرض بنجاح!"),
          backgroundColor: Colors.green,
        ),
      );
      // Optionally, pop the screen
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'إضافة عرض جديد',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_primaryColor, _secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionCard(
                  title: 'تفاصيل العرض الأساسية',
                  icon: Icons.edit_note,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: _buildInputDecoration(
                          'عنوان العرض',
                          Icons.title,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: _buildInputDecoration(
                          'وصف العرض',
                          Icons.description,
                        ),
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSectionCard(
                  title: 'جدولة العرض',
                  icon: Icons.calendar_month,
                  child: Column(
                    children: [
                      _buildDateTimePicker(
                        label: 'تاريخ ووقت البداية',
                        dateTime: _startDate,
                        onTap: () => _pickDateTime(isStartDate: true),
                      ),
                      const SizedBox(height: 16),
                      _buildDateTimePicker(
                        label: 'تاريخ ووقت النهاية',
                        dateTime: _endDate,
                        onTap: () => _pickDateTime(isStartDate: false),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSectionCard(
                  title: 'صورة العرض',
                  icon: Icons.image,
                  child: _buildImagePicker(),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitOffer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : const Text(
                          'إضافة العرض الآن',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Methods for a cleaner build method
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: _primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _primaryColor,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400, width: 1.5),
        ),
        child: _offerImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.file(_offerImage!, fit: BoxFit.cover),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    size: 40,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8),
                  Text('اضغط هنا لاختيار صورة'),
                ],
              ),
      ),
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required DateTime? dateTime,
    required VoidCallback onTap,
  }) {
    String formattedDateTime = dateTime != null
        ? DateFormat('yyyy-MM-dd – hh:mm a', 'ar').format(dateTime)
        : 'لم يتم التحديد';

    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: _buildInputDecoration(label, Icons.date_range),
        child: Text(
          formattedDateTime,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: _primaryColor.withOpacity(0.7)),
      labelStyle: TextStyle(color: _primaryColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _primaryColor, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}
