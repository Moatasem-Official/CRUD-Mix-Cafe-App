class OrderModel {
  final String? orderId;
  final String? customerName;
  final String? customerPhone;
  final String? customerAddress;
  final String? customerCity;
  final String? customerState;
  final String? status;
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
    this.preparationTime,
    this.items,
    this.timestamp,
  });
}
