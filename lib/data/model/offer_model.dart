// 1. Offer Model & Status Enum

import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Offer fromMap(Map<String, dynamic> data, String id) {
    return Offer(
      id: id,
      title: data['title'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      startDate: data['startDate'].toDate(),
      endDate: data['endDate'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
    };
  }
}
