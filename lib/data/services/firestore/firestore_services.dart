import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';
import 'package:mix_cafe_app/data/services/cloudinary/cloudinary_services.dart';

class FirestoreServices {
  Future<void> addProduct(
    String name,
    String description,
    double price,
    int quantity,
    String image,
    String category,
    DateTime? startDiscount,
    DateTime? endDiscount,
    double? discountPercentage,
    bool hasDiscount,
    bool isAvailable,
  ) async {
    try {
      final CollectionReference collection = FirebaseFirestore.instance
          .collection('products');
      final CloudinaryServices cloudinaryServices = CloudinaryServices();
      final imageUrl = await cloudinaryServices.uploadImageToCloudinary(
        File(image), // Replace with actual image file path
      );
      await collection.add({
        'name': name,
        'description': description,
        'price': price,
        'quantity': quantity,
        'isAvailable': isAvailable,
        'imageUrl': imageUrl ?? '',
        'hasDiscount': hasDiscount,
        'startDiscount': startDiscount != null
            ? Timestamp.fromDate(startDiscount)
            : null,
        'endDiscount': endDiscount != null
            ? Timestamp.fromDate(endDiscount)
            : null,
        'discountedPrice': price * (1 - (discountPercentage ?? 0.0) / 100),
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding item: $e');
      throw Exception('Failed to add item: $e');
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      final CollectionReference collection = FirebaseFirestore.instance
          .collection('products');
      final QuerySnapshot snapshot = await collection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ProductModel(
          id: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          price: (data['price'] as num?)?.toDouble() ?? 0.0,
          quantity: (data['quantity'] as num?)?.toInt() ?? 0,
          isAvailable: data['isAvailable'] ?? false,
          imageUrl: data['imageUrl'] ?? '',
          category: data['category'] ?? '',
          hasDiscount: data['hasDiscount'] ?? false,
          startDiscount: (data['startDiscount'] as Timestamp?)?.toDate(),
          endDiscount: (data['endDiscount'] as Timestamp?)?.toDate(),
          discountPercentage:
              (data['discountPercentage'] as num?)?.toDouble() ?? 0.0,
          discountedPrice: (data['discountedPrice'] as num?)?.toDouble() ?? 0.0,
        );
      }).toList();
    } catch (e) {
      print('Error fetching items: $e');
      throw Exception('Failed to fetch items: $e');
    }
  }

  Future<void> updateProduct(
    String id,
    String name,
    String description,
    double price,
    int quantity,
    bool isAvailable,
    String imageUrl,
    String category,
    DateTime startDiscount,
    DateTime endDiscount,
    double discountPercentage,
    double discountedPrice,
  ) async {
    try {
      final DocumentReference document = FirebaseFirestore.instance
          .collection('products')
          .doc(id);
      await document.update({
        'name': name,
        'description': description,
        'price': price,
        'quantity': quantity,
        'isAvailable': isAvailable,
        'imageUrl': imageUrl,
        'category': category,
        'hasDiscount': discountPercentage > 0,
        'startDiscount': startDiscount != null
            ? Timestamp.fromDate(startDiscount)
            : null,
        'endDiscount': endDiscount != null
            ? Timestamp.fromDate(endDiscount)
            : null,
        'discountPercentage': discountPercentage,
        'discountedPrice': discountedPrice,
      });
    } catch (e) {
      print('Error updating product: $e');
      throw Exception('Failed to update item: $e');
    }
  }

  Future<void> deleteItem(String id, String collection) async {
    try {
      final DocumentReference document = FirebaseFirestore.instance
          .collection(collection)
          .doc(id);
      await document.delete();
    } catch (e) {
      print('Error deleting item: $e');
      throw Exception('Failed to delete item: $e');
    }
  }

  Future<Map<String, dynamic>?> getItemById(
    String id,
    String collection,
  ) async {
    try {
      final DocumentReference document = FirebaseFirestore.instance
          .collection(collection)
          .doc(id);
      final DocumentSnapshot snapshot = await document.get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return null; // Item not found
      }
    } catch (e) {
      print('Error fetching item by ID: $e');
      throw Exception('Failed to fetch item by ID: $e');
    }
  }

  Future<void> addOrder(String userId, List<Map<String, dynamic>> items) async {
    try {
      final CollectionReference collection = FirebaseFirestore.instance
          .collection('orders');
      await collection.add({
        'userId': userId,
        'items': items,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding order: $e');
      throw Exception('Failed to add order: $e');
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      final DocumentReference document = FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId);
      await document.update({'status': status});
    } catch (e) {
      print('Error updating order status: $e');
      throw Exception('Failed to update order status: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    try {
      final CollectionReference collection = FirebaseFirestore.instance
          .collection('users')
          .doc('userOrders')
          .collection('orders');
      final QuerySnapshot snapshot = await collection.get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching all orders: $e');
      throw Exception('Failed to fetch all orders: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getOrdersByStatus(String status) async {
    try {
      final CollectionReference collection = FirebaseFirestore.instance
          .collection('orders');
      final QuerySnapshot snapshot = await collection
          .where('status', isEqualTo: status)
          .get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching orders by status: $e');
      throw Exception('Failed to fetch orders by status: $e');
    }
  }
}
