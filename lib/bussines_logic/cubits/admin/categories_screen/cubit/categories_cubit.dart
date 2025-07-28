import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../data/model/product_model.dart';
import '../../../../../data/services/firestore/firestore_services.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesLoading());

  final FirestoreServices _firestoreServices = FirestoreServices();
  late List<ProductModel> products = [];

  Future<void> getProducts(int categoryId) async {
    emit(CategoriesLoading());
    try {
      products = await _firestoreServices.getProducts(categoryId);
      if (products.isEmpty) {
        emit(CategoriesEmpty());
      } else {
        if (!isClosed) emit(CategoriesLoaded(products));
      }
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> deleteProduct(String id, int categoryId) async {
    try {
      await _firestoreServices.deleteItem(id, categoryId);
      await getProducts(categoryId);
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  // لاحظ كيف أصبحت الدالة تستقبل بارامترين فقط
  // لاحظ كيف أصبحت الدالة تستقبل بارامترين فقط
  Future<void> updateProduct(
    int oldCategoryId,
    ProductModel product, // الكائن المحدث بالكامل
  ) async {
    emit(CategoriesLoading());
    try {
      // ✨ تمرير الكائن مباشرةً كما هو إلى طبقة الخدمات
      await _firestoreServices.updateProduct(oldCategoryId, product);

      // تحديث قائمة المنتجات في الواجهة
      await getProducts(
        product.category == getCategoryName(oldCategoryId)
            ? oldCategoryId
            : getNewCategoryId(product.category),
      );
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  // دالة مساعدة لتحويل اسم التصنيف إلى ID
  int getNewCategoryId(String categoryName) {
    switch (categoryName) {
      case 'Sandwichs':
        return 0;
      case 'Pizzas':
        return 1;
      case 'Crepes':
        return 2;
      case 'Meals':
        return 3;
      case 'Drinks':
        return 4;
      case 'Desserts':
        return 5;
      default:
        return -1; // Or handle as an error
    }
  }

  // دالة مساعدة لتحويل ID التصنيف إلى اسم
  String getCategoryName(int categoryId) {
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
        return 'Desserts';
      default:
        return ''; // Or handle as an error
    }
  }
}
