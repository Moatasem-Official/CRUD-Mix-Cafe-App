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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: const Text(
          'Product Information',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 154, 97, 57),
        centerTitle: true,
        automaticallyImplyLeading: true,
        surfaceTintColor: const Color.fromARGB(255, 154, 97, 57),
        elevation: 0,
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
