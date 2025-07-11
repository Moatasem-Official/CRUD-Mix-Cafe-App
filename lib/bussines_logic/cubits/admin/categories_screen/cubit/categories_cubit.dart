import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';
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
      emit(CategoriesError());
    }
  }

  Future<void> deleteProduct(String id, int categoryId) async {
    try {
      await _firestoreServices.deleteItem(id, categoryId);
      await getProducts(categoryId);
    } catch (e) {
      emit(CategoriesError());
    }
  }
}
