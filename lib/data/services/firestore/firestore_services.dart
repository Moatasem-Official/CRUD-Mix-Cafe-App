import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mix_cafe_app/data/model/offer_model.dart';
import '../../model/order_model.dart';
import '../../model/user_model.dart';
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

  // لاحظ كيف أصبحت البارامترات أبسط بكثير
  Future<void> updateProduct(
    int oldCategoryId,
    ProductModel product, // نستقبل كائن المنتج المحدث بالكامل
  ) async {
    try {
      // 🧭 تحويل ID التصنيف القديم إلى اسم للوصول للمسار الصحيح
      String oldCategoryName = _getCategoryNameFromId(oldCategoryId);

      final firestore = FirebaseFirestore.instance;
      final newCategoryName = product.category; // اسم التصنيف الجديد من الكائن

      // 🔁 هل تم تغيير التصنيف؟
      if (oldCategoryName != newCategoryName) {
        // إذا تم تغيير التصنيف، نقوم بحذف المنتج من القديم وإضافته للجديد

        // 🗑️ احذف من التصنيف القديم
        await firestore
            .collection('categories')
            .doc(oldCategoryName)
            .collection('products')
            .doc(product.id)
            .delete();

        // ➕ أضف للتصنيف الجديد باستخدام toMap
        await firestore
            .collection('categories')
            .doc(newCategoryName)
            .collection('products')
            .doc(product.id)
            .set(product.toMap()); // ✨ نستخدم toMap هنا
      } else {
        // ✅ تحديث عادي في نفس التصنيف
        final document = firestore
            .collection('categories')
            .doc(oldCategoryName)
            .collection('products')
            .doc(product.id);

        // ✨ نستخدم toMap هنا أيضًا للتحديث
        await document.update(product.toMap());
      }

      print('✅ Product updated successfully in $newCategoryName');
    } catch (e) {
      print('❌ Error updating product: $e');
      // من الأفضل إلقاء الخطأ مرة أخرى ليتمكن الـ Cubit من التعامل معه
      throw Exception('Failed to update product: $e');
    }
  }

  // دالة مساعدة خاصة لتنظيف الكود
  String _getCategoryNameFromId(int categoryId) {
    switch (categoryId) {
      case 0:
        return 'Sandwichs';
      case 1:
        return 'Pizzas';
      case 2:
        return 'Crepes';
      case 3:
        return 'Meals';
      case 4:
        return 'Drinks';
      case 5:
        return 'Desserts'; // تأكد من أن هذا الاسم يطابق Firestore
      default:
        throw Exception('❌ Invalid old categoryId: $categoryId');
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
                : categoryId == 4
                ? 'Drinks'
                : categoryId == 5
                ? 'Desserts'
                : '',
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
        final newDocRef = ordersRef.doc(); // أنشئ ID يدويًا

        await newDocRef.set({
          'orderId': newDocRef.id, // ✅ خزنه هنا
          'userId': userId,
          'items': items,
          'totalPrice': totalPrice,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'pending',
          'orderHash': orderHash,
          'updatedAt': '',
          'preparationTime': '',
        });
      } else {
        throw Exception(
          'You already have a pending order with the same items.',
        );
      }
    } catch (error, stackTrace) {
      debugPrint('Error adding order: $error');
      debugPrintStack(stackTrace: stackTrace);
      rethrow; // ❗️ده بيرمي نفس الخطأ اللي حصل بدون تعديل
    }
  }

  Future<void> deleteOrder({
    required String userId,
    required String orderId,
  }) async {
    print('⛳ deleteOrder called: $userId - $orderId'); // <== هنا
    try {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId);

      await docRef.delete();
      print('✅ Order deleted');
    } catch (e) {
      print('❌ Error deleting order: $e');
      throw Exception('Failed to delete order: $e');
    }
  }

  Future<void> updateOrderStatus({
    required String userId,
    required String orderId,
    required String status,
  }) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId);

      await docRef.update({
        'status': status,
        'updatedAt':
            FieldValue.serverTimestamp(), // ✅ أفضل من string لتتبع الوقت الحقيقي
      });

      print('✅ Order status updated.');
    } catch (e, stack) {
      print('🔥 Failed to update order [$orderId]: $e');
      print(stack);
      throw Exception('Something went wrong while updating order status.');
    }
  }

  Future<void> updateOrderPreparationTime({
    required String userId,
    required String orderId,
    required Duration preparationTime,
  }) async {
    try {
      final orderRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId);

      await orderRef.update({'preparationTime': preparationTime.toString()});

      print('✅ Order updated successfully.');
    } catch (e) {
      print('❌ Failed to update order [$orderId]: $e');
    }
  }

  Future<List<OrderModel>> getAllOrders() async {
    try {
      final collection = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('orders');

      final snapshot = await collection.get();

      return snapshot.docs.map((doc) {
        // ignore: unnecessary_cast
        final data = doc.data() as Map<String, dynamic>; // 👈 مهم جدًا
        return OrderModel.fromMap(doc.id, data);
      }).toList();
    } catch (e) {
      print('Error fetching orders: $e');
      throw Exception('Failed to fetch orders: $e');
    }
  }

  Future<double> calculateTotalRevenue() async {
    try {
      double total = 0.0;

      final snapshot = await FirebaseFirestore.instance
          .collectionGroup('orders')
          .where('status', isEqualTo: 'delivered')
          .get();

      for (final doc in snapshot.docs) {
        final price = doc['totalPrice'];
        if (price != null && price is num) {
          total += price.toDouble();
        }
      }

      return total;
    } catch (e) {
      print('Error calculating revenue: $e');
      throw Exception('Failed to calculate revenue');
    }
  }

  Future<List<double>> getRevenueDistribution(String period) async {
    try {
      final now = DateTime.now();
      DateTime startDate;

      int bucketCount;
      int Function(DateTime date) bucketSelector;

      if (period == 'weekly') {
        // ✅ حساب بداية الأسبوع من يوم السبت
        int daysSinceSaturday = now.weekday % 7; // Saturday = 6
        DateTime rawStartDate = now.subtract(Duration(days: daysSinceSaturday));

        // ✅ تصفير الساعة والدقيقة والثانية
        startDate = DateTime(
          rawStartDate.year,
          rawStartDate.month,
          rawStartDate.day,
        );

        bucketCount = 7;

        bucketSelector = (date) {
          switch (date.weekday) {
            case DateTime.saturday:
              return 0;
            case DateTime.sunday:
              return 1;
            case DateTime.monday:
              return 2;
            case DateTime.tuesday:
              return 3;
            case DateTime.wednesday:
              return 4;
            case DateTime.thursday:
              return 5;
            case DateTime.friday:
              return 6;
            default:
              return 0;
          }
        };
      } else if (period == 'monthly') {
        // الشهر الحالي (4 أو 5 أسابيع)
        startDate = DateTime(now.year, now.month, 1);
        bucketCount = 5;
        bucketSelector = (date) => ((date.day - 1) ~/ 7); // week index 0-4
      } else if (period == 'yearly') {
        // السنة الحالية (12 شهر)
        startDate = DateTime(now.year, 1, 1);
        bucketCount = 12;
        bucketSelector = (date) => date.month - 1; // 0 = Jan
      } else {
        throw Exception('Invalid period: $period');
      }
      print('📅 startDate = $startDate');
      print('🕒 now = $now');
      final snapshot = await FirebaseFirestore.instance
          .collectionGroup('orders')
          .where('status', isEqualTo: 'delivered')
          .where(
            'updatedAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
          )
          .get();
      print('📦 Fetched orders count: ${snapshot.docs.length}');
      for (var doc in snapshot.docs) {
        print('🧾 Order ID: ${doc.id}, updatedAt: ${doc['updatedAt']}');
      }

      List<double> buckets = List.filled(bucketCount, 0.0);

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final price = data['totalPrice'];
        final timestamp = data['updatedAt'];

        if (price != null && price is num && timestamp is Timestamp) {
          final date = timestamp.toDate();
          int index = bucketSelector(date);

          if (index >= 0 && index < bucketCount) {
            buckets[index] += price.toDouble();
          }
        }
      }

      return buckets;
    } catch (e, stackTrace) {
      print('❌ Error in revenue distribution: $e');
      print('📌 Stack Trace: $stackTrace');
      rethrow; // علشان تشوف الخطأ الأصلي في debug
    }
  }

  Future<int> getOrdersCount() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collectionGroup('orders') // شامل كل subcollections
          .get();

      return snapshot.size;
    } catch (e) {
      print('Error counting orders: $e');
      throw Exception('Failed to count orders');
    }
  }

  Future<List<OrderModel>> getOrdersByStatus(String status) async {
    try {
      final collection = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('orders');

      final snapshot = await collection
          .where('status', isEqualTo: status)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return OrderModel.fromMap(doc.id, data);
      }).toList();
    } catch (e) {
      print('Error fetching orders by status: $e');
      throw Exception('Failed to fetch orders by status: $e');
    }
  }

  Future<List<OrderModel>> getAllCustomerOrders() async {
    try {
      final usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userRole', isEqualTo: 'customer')
          .get();

      List<OrderModel> allOrders = [];

      for (var userDoc in usersSnapshot.docs) {
        final userData = userDoc.data();
        final customerName = userData['name'] ?? '---';
        final customerImage = userData['imageUrl'] ?? '';
        final customerAddress = userData['address'] ?? '';
        final customerPhone = userData['phone'] ?? '';

        final ordersSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userDoc.id)
            .collection('orders')
            .get();

        final userOrders = ordersSnapshot.docs.map((orderDoc) {
          final data = orderDoc.data();

          final order = OrderModel.fromMap(orderDoc.id, data);

          // تحديث الحقول يدويًا لو OrderModel لا يحتوي عليهم من الـ map
          return order.copyWith(
            customerName: customerName,
            customerImage: customerImage,
            customerAddress: customerAddress,
            customerPhone: customerPhone,
          );
        }).toList();

        allOrders.addAll(userOrders);
      }

      return allOrders;
    } catch (e) {
      print('Error fetching customer orders: $e');
      throw Exception('Failed to fetch customer orders: $e');
    }
  }

  Future<void> addOffer({required Offer offer}) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final docRef = firestore.collection('offers').doc(); // توليد ID يدوي
      final offerId = docRef.id;

      final offerData = {
        'id': offerId, // عشان تحفظ الـ ID نفسه داخل الداتا
        'imageUrl': offer.imageUrl,
        'title': offer.title,
        'description': offer.description,
        'startDate': Timestamp.fromDate(offer.startDate),
        'endDate': Timestamp.fromDate(offer.endDate),
        'timestamp': FieldValue.serverTimestamp(),
      };

      await docRef.set(offerData); // ✅ استخدم set بس هنا

      print('✅ Offer added successfully!');
    } catch (e) {
      print('❌ Error adding offer: $e');
      throw Exception('Failed to add offer: $e');
    }
  }

  Future<void> deleteOffer(String offerId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('offers').doc(offerId).delete();
      print('✅ Offer deleted successfully!');
    } catch (e) {
      print('❌ Error deleting offer: $e');
      throw Exception('Failed to delete offer: $e');
    }
  }

  Future<void> updateOffer(
    String offerId, // 🟡 تمرير الـ ID هنا
    String imageUrl,
    String title,
    String description,
    DateTime endDate,
  ) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('offers').doc(offerId).update({
        'imageUrl': imageUrl,
        'title': title,
        'description': description,
        'endDate': Timestamp.fromDate(endDate),
      });
      print('✅ Offer updated successfully!');
    } catch (e) {
      print('❌ Error updating offer: $e');
      throw Exception('Failed to update offer: $e');
    }
  }

  Future<List<Offer>> getAllOffers() async {
    final firestore = FirebaseFirestore.instance;
    try {
      final snapshot = await firestore.collection('offers').get();
      final offers = snapshot.docs
          .map((doc) => Offer.fromMap(doc.data(), doc.id))
          .toList();
      return offers;
    } catch (e) {
      print('❌ Error fetching offers: $e');
      throw Exception('Failed to fetch offers: $e');
    }
  }

  Future<List<OrderModel>> getCustomersOrdersByStatus(String status) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collectionGroup('orders')
          .where('status', isEqualTo: status)
          .get();

      List<OrderModel> orders = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final userRef = doc.reference.parent.parent; // نجيب الـ user
        final userSnapshot = await userRef?.get();

        final customerName = userSnapshot?.data()?['name'] ?? '---';
        final customerImage = userSnapshot?.data()?['imageUrl'] ?? '';

        final order = OrderModel.fromMap(
          doc.id,
          data,
        ).copyWith(customerName: customerName, customerImage: customerImage);

        orders.add(order);
      }

      return orders;
    } catch (e) {
      print('Error fetching orders by status: $e');
      throw Exception('فشل في جلب الطلبات حسب الحالة: $e');
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

  Future<int> getAllCustomersCount() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userRole', isEqualTo: 'customer') // عد العملاء فقط
          .get();

      return snapshot.size; // عدد الوثائق (العملاء)
    } catch (e) {
      print('Error counting customers: $e');
      throw Exception('Failed to count customers: $e');
    }
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
