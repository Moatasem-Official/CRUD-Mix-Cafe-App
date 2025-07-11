import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';

class EditAdminContactPhoneNumber extends StatelessWidget {
  const EditAdminContactPhoneNumber({
    super.key,
    required this.phoneController,
    required AuthService authService,
  }) : _authService = authService;

  final TextEditingController phoneController;
  final AuthService _authService;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'تعديل رقم تواصل المطعم العام',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 165, 101, 56),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'رقم التواصل',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'أدخل رقم التواصل',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFA0522D),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA0522D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () async {
            final newPhone = phoneController.text.trim();

            if (newPhone.isEmpty) return;

            try {
              await _authService.updateField('contactPhone', newPhone);

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تحديث رقم التواصل بنجاح')),
              );
            } on FirebaseAuthException catch (e) {
              Navigator.pop(context);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(e.message!)));
            } catch (e) {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('فشل التحديث، حاول لاحقًا')),
              );
            }
          },
          child: const Text('تحديث', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
