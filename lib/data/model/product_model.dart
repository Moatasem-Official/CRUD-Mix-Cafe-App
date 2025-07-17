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
  final String imageUrl;
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
}
