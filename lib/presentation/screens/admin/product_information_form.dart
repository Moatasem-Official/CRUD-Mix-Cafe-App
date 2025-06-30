import 'package:flutter/material.dart';
import '../../widgets/admin/Products_Screen_Widgets/custom_add_product_info_form.dart';

class ProductInformationForm extends StatefulWidget {
  const ProductInformationForm({super.key});

  @override
  State<ProductInformationForm> createState() => _ProductInformationFormState();
}

class _ProductInformationFormState extends State<ProductInformationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? _imageUrl; // في الوقت الحالي نعتبر الصورة رابط

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color(0xFFB6855E), // كابتشينو ناعم
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
              offerPriceController: TextEditingController(),
              imageUrl: _imageUrl,
            ),
          ],
        ),
      ),
    );
  }
}
