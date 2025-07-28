import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final bool isAvailable;
  final bool isFeatured;
  final bool isNew;
  final bool isBestSeller;
  String imageUrl;
  final String category;
  final bool hasDiscount;
  final DateTime? startDiscount;
  final DateTime? endDiscount;
  final double discountPercentage;
  final double discountedPrice;
  final DateTime? timestamp;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.isAvailable,
    required this.isFeatured,
    required this.isNew,
    required this.isBestSeller,
    required this.imageUrl,
    required this.category,
    this.hasDiscount = false,
    this.startDiscount,
    this.endDiscount,
    this.discountPercentage = 0.0,
    this.discountedPrice = 0.0,
    this.timestamp,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    isAvailable: json['isAvailable'] ?? false,
    isFeatured: json['isFeatured'] ?? false,
    isNew: json['isNew'] ?? false,
    isBestSeller: json['isBestSeller'] ?? false,
    imageUrl: json['imageUrl'] ?? '',
    category: json['category'] ?? '',
    hasDiscount: json['hasDiscount'] ?? false,
    startDiscount: json['startDiscount'] != null
        ? (json['startDiscount'] as Timestamp).toDate()
        : null,
    endDiscount: json['endDiscount'] != null
        ? (json['endDiscount'] as Timestamp).toDate()
        : null,
    discountPercentage: json['discountPercentage']?.toDouble() ?? 0.0,
    discountedPrice: json['discountedPrice']?.toDouble() ?? 0.0,
    timestamp: json['timestamp'] != null
        ? (json['timestamp'] as Timestamp).toDate()
        : null,
  );

  // داخل كلاس ProductModel
  // ... (الحقول والـ constructor)

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'isAvailable': isAvailable,
      'imageUrl': imageUrl,
      'category': category,
      'hasDiscount': hasDiscount,
      'startDiscount': startDiscount, // فايرستور سيقوم بتحويله لـ Timestamp
      'endDiscount': endDiscount, // فايرستور سيقوم بتحويله لـ Timestamp
      'discountedPrice': discountedPrice,
      'discountPercentage': discountPercentage, // تأكد من إضافة هذا الحقل
      'timestamp': FieldValue.serverTimestamp(), // للتحديث التلقائي للوقت
      'isBestSeller': isBestSeller,
      'isFeatured': isFeatured,
      'isNew': isNew,
    };
  }
}
