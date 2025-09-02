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
    emit(AddProductLoading());
    try {
      await _firestoreServices.addProduct(
        categoryId: categoryId,
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        image: image,
        hasDiscount: hasDiscount,
        isAvailable: isAvailable,
        isFeatured: isFeatured,
        isNew: isNew,
        isBestSeller: isBestSeller,
      );
      emit(AddProductSuccess('Product Added Successfully'));
    } catch (e) {
      emit(AddProductError('Failed To Add Product'));
    }
  }

  Future<void> deleteProduct(String id, int categoryId) async {
    emit(DeleteProductLoading());
    try {
      await _firestoreServices.deleteItem(id, categoryId);
      emit(DeleteProductSuccess('Product Deleted Successfully'));
      await getProducts(categoryId);
    } catch (e) {
      emit(DeleteProductError('Failed To Delete Product'));
    }
  }

  // لاحظ كيف أصبحت الدالة تستقبل بارامترين فقط
  // لاحظ كيف أصبحت الدالة تستقبل بارامترين فقط
  Future<void> updateProduct(
    int oldCategoryId,
    ProductModel product, // الكائن المحدث بالكامل
  ) async {
    emit(EditProductLoading());
    try {
      // ✨ تمرير الكائن مباشرةً كما هو إلى طبقة الخدمات
      await _firestoreServices.updateProduct(oldCategoryId, product);
      emit(EditProductSuccess('Product Updated Successfully'));
      // تحديث قائمة المنتجات في الواجهة
      await getProducts(
        product.category == getCategoryName(oldCategoryId)
            ? oldCategoryId
            : getNewCategoryId(product.category),
      );
    } catch (e) {
      emit(EditProductError('Failed To Update Product'));
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
      case 'Desserts':
        return 4;
      case 'Drinks':
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
        return 'Desserts';
      case 5:
        return 'Drinks';
      default:
        return ''; // Or handle as an error
    }
  }
}
