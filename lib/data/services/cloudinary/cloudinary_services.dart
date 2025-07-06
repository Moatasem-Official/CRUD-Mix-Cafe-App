import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class CloudinaryServices {
  Future<String?> uploadImageToCloudinary(File imageFile) async {
    final cloudName = "dvhokehbd";
    final uploadPreset = "item_upload";

    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      final data = json.decode(res.body);
      return data['secure_url']; // رابط الصورة
    } else {
      print("فشل في رفع الصورة: ${response.statusCode}");
      return null;
    }
  }

  Future<void> deleteImageFromCloudinary(String imageUrl) async {
    final cloudName = "dvhokehbd";
    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/delete",
    );
    final request = http.MultipartRequest('POST', url)
      ..fields['public_id'] = imageUrl;
    final response = await request.send();
    if (response.statusCode == 200) {
      print("تم حذف الصورة من Cloudinary");
    } else {
      print("فشل في حذف الصورة من Cloudinary: ${response.statusCode}");
    }
  }
}
