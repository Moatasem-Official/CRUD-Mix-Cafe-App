// 1. Offer Model & Status Enum

enum OfferStatus { Active, Scheduled, Expired }

class Offer {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
  });
}
