import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mix_cafe_app/data/model/user_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../model/product_model.dart';
import '../cloudinary/cloudinary_services.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class FirestoreServices {
  Future<void> addProduct({
    required int categoryId,
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String image,
    String? startDiscountDate,
    String? endDiscountDate,
    String? startDiscountTime,
    String? endDiscountTime,
    double? discountPercentage,
    required bool hasDiscount,
    required bool isAvailable,
    required bool isFeatured,
    required bool isNew,
    required bool isBestSeller,
  }) async {
    try {
      final categories = ['Sandwichs', 'Pizzas', 'Crepes', 'Meals', 'Drinks'];
      final categoryName = categories[categoryId];

      final docRef = FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryName)
          .collection('products')
          .doc();

      final CloudinaryServices cloudinaryServices = CloudinaryServices();
      final imageUrl = await cloudinaryServices.uploadImageToCloudinary(
        File(image),
      );

      DateTime? parseDateTime(String? date, String? time) {
        if (date == null || date.isEmpty || time == null || time.isEmpty) {
          return null;
        }
        try {
          final input = "$date $time";
          final format = DateFormat("yyyy-MM-dd h:mm a");
          return format.parse(input);
        } catch (e) {
          print("❌ Failed to parse datetime: $e");
          return null;
        }
      }

      final Map<String, dynamic> productData = {
        'id': docRef.id,
        'category': categoryName,
        'name': name,
        'description': description,
        'price': price,
        'quantity': quantity,
        'isAvailable': isAvailable,
        'imageUrl': imageUrl ?? '',
        'hasDiscount': hasDiscount,
        'isFeatured': isFeatured,
        'isNew': isNew,
        'isBestSeller': isBestSeller,
        'timestamp': FieldValue.serverTimestamp(),
      };

      if (hasDiscount) {
        final start = parseDateTime(startDiscountDate, startDiscountTime);
        final end = parseDateTime(endDiscountDate, endDiscountTime);

        productData.addAll({
          'startDiscount': start != null ? Timestamp.fromDate(start) : null,
          'endDiscount': end != null ? Timestamp.fromDate(end) : null,
          'discountedPrice': price * (1 - (discountPercentage ?? 0.0) / 100),
        });
      }

      await docRef.set(productData);
    } catch (e) {
      print('Error adding item: $e');
      throw Exception('Failed to add item: $e');
    }
  }

  Future<List<ProductModel>> getProducts(int categoryId) async {
    try {
      final CollectionReference collection = FirebaseFirestore.instance
          .collection('categories')
          .doc(
            categoryId == 0
                ? 'Sandwichs'
                : categoryId == 1
                ? 'Pizzas'
                : categoryId == 2
                ? 'Crepes'
                : categoryId == 3
                ? 'Meals'
                : 'Drinks',
          )
          .collection('products');
      final QuerySnapshot snapshot = await collection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ProductModel(
          id: data['id'] ?? '',
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          price: (data['price'] as num?)?.toDouble() ?? 0.0,
          quantity: (data['quantity'] as num?)?.toInt() ?? 0,
          isAvailable: data['isAvailable'] ?? false,
          isFeatured: data['isFeatured'] ?? false,
          isNew: data['isNew'] ?? false,
          isBestSeller: data['isBestSeller'] ?? false,
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

  Stream<List<ProductModel>> getAllProductsStreamFromAllCategories() {
    final List<String> categoryNames = [
      'Sandwichs',
      'Pizzas',
      'Crepes',
      'Meals',
      'Drinks',
    ];

    // نحول كل كاتيجوري لستريم من المنتجات
    final List<Stream<List<ProductModel>>> streams = categoryNames.map((
      category,
    ) {
      final collection = FirebaseFirestore.instance
          .collection('categories')
          .doc(category)
          .collection('products');

      return collection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return ProductModel(
            id: data['id'] ?? '',
            name: data['name'] ?? '',
            description: data['description'] ?? '',
            price: (data['price'] as num?)?.toDouble() ?? 0.0,
            quantity: (data['quantity'] as num?)?.toInt() ?? 0,
            isAvailable: data['isAvailable'] ?? false,
            isFeatured: data['isFeatured'] ?? false,
            isNew: data['isNew'] ?? false,
            isBestSeller: data['isBestSeller'] ?? false,
            imageUrl: data['imageUrl'] ?? '',
            category: data['category'] ?? '',
            hasDiscount: data['hasDiscount'] ?? false,
            startDiscount: (data['startDiscount'] as Timestamp?)?.toDate(),
            endDiscount: (data['endDiscount'] as Timestamp?)?.toDate(),
            discountPercentage:
                (data['discountPercentage'] as num?)?.toDouble() ?? 0.0,
            discountedPrice:
                (data['discountedPrice'] as num?)?.toDouble() ?? 0.0,
          );
        }).toList();
      });
    }).toList();

    // ندمج كل الستريمز مع بعض باستخدام combineLatest
    return Rx.combineLatestList<List<ProductModel>>(streams).map((listOfLists) {
      // دمج كل القوائم في ليست واحدة
      return listOfLists.expand((list) => list).toList();
    });
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

  Future<void> deleteItem(String id, int categoryId) async {
    try {
      final DocumentReference document = FirebaseFirestore.instance
          .collection('categories')
          .doc(
            categoryId == 0
                ? 'Sandwichs'
                : categoryId == 1
                ? 'Pizzas'
                : categoryId == 2
                ? 'Crepes'
                : categoryId == 3
                ? 'Meals'
                : 'Drinks',
          )
          .collection('products')
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

  Future<void> addOrder(
    String userId,
    double totalPrice,
    List<Map<String, dynamic>> items,
  ) async {
    try {
      final ordersRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders');

      final orderHash = generateOrderHash(items);

      final existingOrder = await ordersRef
          .where('orderHash', isEqualTo: orderHash)
          .where('status', isEqualTo: 'pending')
          .get();

      if (existingOrder.docs.isEmpty) {
        await ordersRef.add({
          'userId': userId,
          'items': items,
          'totalPrice': totalPrice,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'pending',
          'orderHash': orderHash,
        });
      } else {
        throw Exception(
          'You already have a pending order with the same items.',
        );
      }
    } catch (error, stackTrace) {
      debugPrint('Error adding order: $error');
      debugPrintStack(stackTrace: stackTrace);
      throw Exception('Failed to add order: $error');
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      final DocumentReference document = FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId);
      await document.delete();
    } catch (e) {
      print('Error deleting order: $e');
      throw Exception('Failed to delete order: $e');
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
          .collection('orders');
      final QuerySnapshot snapshot = await collection.get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching orders: $e');
      throw Exception('Failed to fetch orders: $e');
    }
  }

  Future<int> getOrdersCount() async {
    try {
      final CollectionReference collection = FirebaseFirestore.instance
          .collection('orders');
      final QuerySnapshot snapshot = await collection.get();
      return snapshot.docs.length;
    } catch (e) {
      print('Error fetching orders count: $e');
      throw Exception('Failed to fetch orders count: $e');
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

  Future<List<ProductModel>> searchProductsFromAllCategories(
    String query,
  ) async {
    try {
      final List<String> categoryNames = [
        'Sandwichs',
        'Pizzas',
        'Crepes',
        'Meals',
        'Drinks',
      ];

      List<ProductModel> allProducts = [];

      for (String category in categoryNames) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('categories')
            .doc(category)
            .collection('products')
            .get();

        final products = querySnapshot.docs
            .map((doc) {
              final data = doc.data();
              return ProductModel(
                id: data['id'] ?? '',
                name: data['name'] ?? '',
                description: data['description'] ?? '',
                price: (data['price'] as num?)?.toDouble() ?? 0.0,
                quantity: (data['quantity'] as num?)?.toInt() ?? 0,
                isAvailable: data['isAvailable'] ?? false,
                isFeatured: data['isFeatured'] ?? false,
                isNew: data['isNew'] ?? false,
                isBestSeller: data['isBestSeller'] ?? false,
                imageUrl: data['imageUrl'] ?? '',
                category: data['category'] ?? '',
                hasDiscount: data['hasDiscount'] ?? false,
                startDiscount: (data['startDiscount'] as Timestamp?)?.toDate(),
                endDiscount: (data['endDiscount'] as Timestamp?)?.toDate(),
                discountPercentage:
                    (data['discountPercentage'] as num?)?.toDouble() ?? 0.0,
                discountedPrice:
                    (data['discountedPrice'] as num?)?.toDouble() ?? 0.0,
              );
            })
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

        allProducts.addAll(products);
      }

      return allProducts;
    } catch (e) {
      print('Error searching products: $e');
      throw Exception('Failed to search products: $e');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final collection = FirebaseFirestore.instance
          .collection('categories')
          .doc(category)
          .collection('products');

      final snapshot = await collection.get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // إضافة الـ id لأن غالباً الموديل يستخدمه
        return ProductModel.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error fetching products by category: $e');
      throw Exception('Failed to fetch products by category: $e');
    }
  }

  Future<void> addProductToCart(ProductModel product, String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(product.id)
          .set({
            'id': product.id,
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'quantity': product.quantity,
            'isAvailable': product.isAvailable,
            'isFeatured': product.isFeatured,
            'isNew': product.isNew,
            'isBestSeller': product.isBestSeller,
            'imageUrl': product.imageUrl,
            'category': product.category,
            'hasDiscount': product.hasDiscount,
            'startDiscount': product.startDiscount,
            'endDiscount': product.endDiscount,
            'discountPercentage': product.hasDiscount
                ? (100 - (product.discountedPrice / product.price) * 100)
                : 0.0,
            'discountedPrice': product.discountedPrice,
          });
    } catch (e) {
      print('Error adding product to cart: $e');
      throw Exception('Failed to add product to cart: $e');
    }
  }

  Future<void> removeProductFromCart(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(productId)
          .delete();
    } catch (e) {
      print('Error removing product from cart: $e');
      throw Exception('Failed to remove product from cart: $e');
    }
  }

  Future<void> updateProductQuantityInCart(
    String productId,
    int quantity,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(productId)
          .update({'quantity': quantity});
    } catch (e) {
      print('Error updating product quantity in cart: $e');
      throw Exception('Failed to update product quantity in cart: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .get()
          .then((querySnapshot) async {
            for (var doc in querySnapshot.docs) {
              await doc.reference.delete();
            }
          });
    } catch (e) {
      print('Error clearing cart: $e');
      throw Exception('Failed to clear cart: $e');
    }
  }

  Future<List<ProductModel>> getCartProducts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching cart products: $e');
      throw Exception('Failed to fetch cart products: $e');
    }
  }

  Future<UserModel> getUserInfo(String orderId) async {
    try {
      final DocumentReference document = FirebaseFirestore.instance
          .collection('users')
          .doc(orderId);
      final DocumentSnapshot snapshot = await document.get();
      if (snapshot.exists) {
        return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        return UserModel(); // Item not found
      }
    } catch (e) {
      print('Error fetching item by ID: $e');
      throw Exception('Failed to fetch item by ID: $e');
    }
  }

  Future<void> updateUserInfo({
    required String userId,
    required UserModel userModel,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      if (userModel.name != null) 'name': userModel.name,
      if (userModel.email != null) 'email': userModel.email,
      if (userModel.imageUrl != null) 'imageUrl': userModel.imageUrl,
      if (userModel.address != null) 'address': userModel.address,
      if (userModel.isNotificationsEnabled != null)
        'isNotificationsEnabled': userModel.isNotificationsEnabled,
    });
  }
}

String generateOrderHash(List<Map<String, dynamic>> items) {
  // ترتيب العناصر لتجنب الاختلاف بسبب الترتيب
  final sortedItems = List<Map<String, dynamic>>.from(items)
    ..sort((a, b) => a.toString().compareTo(b.toString()));

  final jsonString = jsonEncode(sortedItems);
  final hash = sha256.convert(utf8.encode(jsonString));
  return hash.toString();
}
