import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? userId;
  final String? customerName;
  final String? customerImage; // ✅ مضاف حديثًا
  final String? customerPhone;
  final String? customerAddress;
  final String? customerCity;
  final String? customerState;
  final String? orderId;
  final String? status;
  final double? totalPrice;
  final String? preparationTime;
  final List<Map<String, dynamic>>? items;
  final DateTime? timestamp;

  OrderModel({
    this.userId,
    this.customerName,
    this.customerImage,
    this.customerPhone,
    this.customerAddress,
    this.customerCity,
    this.customerState,
    this.orderId,
    this.status,
    this.totalPrice,
    this.preparationTime,
    this.items,
    this.timestamp,
  });

  factory OrderModel.fromMap(String id, Map<String, dynamic> data) {
    final itemsData = (data['items'] as List<dynamic>?) ?? [];

    final itemsList = itemsData
        .expand((item) {
          final orderItems = item['orderItems'] as List<dynamic>? ?? [];
          return orderItems;
        })
        .whereType<Map<String, dynamic>>()
        .toList();

    return OrderModel(
      userId: data['userId'] ?? '', // ← لو موجود في الداتا، استخدمه
      preparationTime: data['preparationTime']?.toString() ?? '',
      orderId:
          data['orderId'] ??
          id, // لو مش موجود، fallback للـ doc.id // ← ده الـ doc.id من Firestore
      items: itemsList,
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      status: data['status']?.toString() ?? 'pending',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // ✅ نضيف copyWith لتحديث البيانات بدون تعديل الكائن الأصلي
  OrderModel copyWith({
    String? customerName,
    String? customerImage,
    String? customerPhone,
    String? customerAddress,
  }) {
    return OrderModel(
      userId: userId,
      orderId: orderId,
      customerName: customerName ?? this.customerName,
      customerImage: customerImage ?? this.customerImage,
      customerPhone: customerPhone ?? this.customerPhone,
      customerAddress: customerAddress ?? this.customerAddress,
      customerCity: customerCity,
      customerState: customerState,
      status: status,
      totalPrice: totalPrice,
      preparationTime: preparationTime,
      items: items,
      timestamp: timestamp,
    );
  }
}
