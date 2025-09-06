import 'dart:io';
import 'package:flutter/material.dart';
import '../../../data/helpers/image_helper.dart';
import '../../../data/model/offer_model.dart';
import '../../widgets/admin/Edit_Offer_Screen/custom_end_date_list_tile.dart';
import '../../widgets/admin/Edit_Offer_Screen/custom_image_preview.dart';
import '../../widgets/admin/Edit_Offer_Screen/custom_save_button.dart';
import '../../widgets/admin/Edit_Offer_Screen/custom_text_form_field.dart';

class EditOfferForm extends StatefulWidget {
  const EditOfferForm({super.key, required this.offer});
  final Offer offer;

  @override
  State<EditOfferForm> createState() => _EditOfferFormState();
}

class _EditOfferFormState extends State<EditOfferForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late DateTime _selectedDate;
  final Color mainColor = const Color.fromARGB(255, 165, 101, 56);

  File? _image;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.offer.title);
    _descController = TextEditingController(text: widget.offer.description);
    _selectedDate = widget.offer.endDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تعديل العرض',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // صورة العرض
              CustomImagePreview(image: _image, offer: widget.offer),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () async {
                  final image = await ImageHelper.pickFromGallery();
                  setState(() {
                    _image = image;
                  });
                },
                icon: Icon(Icons.image, color: mainColor),
                label: Text('تغيير الصورة', style: TextStyle(color: mainColor)),
              ),
              const SizedBox(height: 16),

              // عنوان العرض
              CustomTextFormField(
                labelText: 'عنوان العرض',
                titleController: _titleController,
                validator: (val) => val!.isEmpty ? 'ادخل العنوان' : null,
              ),
              const SizedBox(height: 16),

              // وصف العرض
              CustomTextFormField(
                labelText: 'وصف العرض',
                titleController: _descController,
                validator: (val) => val!.isEmpty ? 'ادخل الوصف' : null,
              ),
              const SizedBox(height: 16),

              // التاريخ
              CustomEndDateListTile(
                selectedDate: _selectedDate,
                updateSelectedDate: (selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                },
              ),

              const SizedBox(height: 24),

              CustomSaveButton(
                titleController: _titleController,
                descController: _descController,
                selectedDate: _selectedDate,
                image: _image,
                formKey: _formKey,
                selectedOffer: widget.offer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
