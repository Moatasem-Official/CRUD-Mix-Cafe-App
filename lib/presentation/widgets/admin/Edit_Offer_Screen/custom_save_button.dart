import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bussines_logic/cubits/admin/offers_screen/cubit/offers_screen_cubit.dart';
import '../../../../data/model/offer_model.dart';
import '../../../../data/services/cloudinary/cloudinary_services.dart';
import 'helper_functions.dart';

class CustomSaveButton extends StatelessWidget {
  const CustomSaveButton({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descController,
    required this.selectedDate,
    this.image,
    required this.selectedOffer,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descController;
  final DateTime selectedDate;
  final File? image;
  final Offer selectedOffer;

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color.fromARGB(255, 165, 101, 56);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsetsDirectional.symmetric(vertical: 14),
      ),
      onPressed: () async {
        final isValid = HelperFunctions.saveForm(
          titleController,
          descController,
          selectedDate,
          image,
          formKey,
        );

        if (isValid) {
          String imageUrl = '';

          if (image != null) {
            final cloudinaryServices = CloudinaryServices();
            final uploadedUrl = await cloudinaryServices
                .uploadImageToCloudinary(image!);
            if (uploadedUrl != null) {
              imageUrl = uploadedUrl;
            } else {
              // فشل رفع الصورة الجديدة
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('فشل رفع الصورة')));
              return;
            }
          } else {
            // استخدم الصورة القديمة
            final offer = selectedOffer;
            if (offer != null && offer.imageUrl != null) {
              imageUrl = offer.imageUrl!;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('الصورة غير متوفرة')),
              );
              return;
            }
          }

          context.read<OffersScreenCubit>().updateOffer(
            selectedOffer.id,
            imageUrl,
            titleController.text,
            descController.text,
            selectedDate,
          );
        }
      },
      child: const Text(
        'حفظ التعديلات',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
