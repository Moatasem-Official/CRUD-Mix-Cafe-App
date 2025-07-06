class ProductModel {
  String name;
  String description;
  double price;
  int quantity;
  bool isAvailable;
  String imageUrl;
  String category;
  bool hasDiscount;
  DateTime startDiscount;
  DateTime endDiscount;
  double discountPercentage;
  double discountedPrice;
  DateTime timestamp;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.isAvailable,
    required this.imageUrl,
    required this.category,
    this.hasDiscount = false,
    DateTime? startDiscount,
    DateTime? endDiscount,
    this.discountPercentage = 0.0,
    double? discountedPrice, required String id,
  }) : startDiscount = startDiscount ?? DateTime.now(),
       endDiscount = endDiscount ?? DateTime.now().add(Duration(days: 7)),
       discountedPrice =
           discountedPrice ?? price * (1 - discountPercentage / 100),
       timestamp = DateTime.now();
}
