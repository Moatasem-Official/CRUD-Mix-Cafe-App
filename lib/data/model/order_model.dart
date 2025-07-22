import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? orderId;
  final String? customerName;
  final String? customerPhone;
  final String? customerAddress;
  final String? customerCity;
  final String? customerState;
  final String? status;
  final double? totalPrice;
  final String? preparationTime;
  final List<Map<String, dynamic>>? items;
  final DateTime? timestamp;

  OrderModel({
    this.orderId,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.customerCity,
    this.customerState,
    this.status,
    this.totalPrice,
    this.preparationTime,
    this.items,
    this.timestamp,
  });

  factory OrderModel.fromMap(String id, Map<String, dynamic> data) {
    final itemsData = (data['items'] as List<dynamic>?) ?? [];

    // نسطّح كل orderItems داخل كل item
    final itemsList = itemsData
        .expand((item) {
          final orderItems = item['orderItems'] as List<dynamic>? ?? [];
          return orderItems;
        })
        .whereType<Map<String, dynamic>>()
        .toList();

    return OrderModel(
      orderId: id,
      items: itemsList,
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      status: data['status']?.toString() ?? 'pending',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
