import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenLoading());

  final FirestoreServices _firestore = FirestoreServices();
  StreamSubscription<List<ProductModel>>? _productsSubscription;
  final List<ProductModel> featuredProducts = [];
  final List<ProductModel> newProducts = [];
  final List<ProductModel> bestProducts = [];
  final List<ProductModel> otherProducts = [];

  Future<void> getProducts() async {
    emit(HomeScreenLoading());
    try {
      _productsSubscription?.cancel();
      _productsSubscription = _firestore
          .getAllProductsStreamFromAllCategories()
          .listen(
            (products) {
              // نظف الليستات قبل ما تملاها
              featuredProducts.clear();
              newProducts.clear();
              bestProducts.clear();
              otherProducts.clear();

              // وزع المنتجات
              for (var product in products) {
                if (product.isFeatured) {
                  featuredProducts.add(product);
                }
                if (product.isNew) {
                  newProducts.add(product);
                }
                if (product.isBestSeller) {
                  bestProducts.add(product);
                }
                if (!product.isFeatured &&
                    !product.isNew &&
                    !product.isBestSeller) {
                  otherProducts.add(product);
                }
              }

              // ابعت الحالة النهائية بعد التوزيع
              emit(HomeScreenSuccess(products));
            },
            onError: (e) {
              emit(HomeScreenError(e.toString()));
            },
          );
    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }

  Future<void> deleteProduct(String id, int categoryId) async {
    emit(HomeScreenLoading());
    try {
      await _firestore.deleteItem(id, categoryId);
    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _productsSubscription?.cancel();
    return super.close();
  }

  Future<void> searchProducts(String query) async {
    emit(HomeScreenLoading());
    try {
      final products = await _firestore.searchProductsFromAllCategories(query);
      emit(HomeScreenSearch(products));
    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }

  Future<void> filterProducts(String category) async {
    emit(HomeScreenLoading());
    try {
      final products = await _firestore.getProductsByCategory(category);
      emit(HomeScreenFilter(products));
    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }
}
