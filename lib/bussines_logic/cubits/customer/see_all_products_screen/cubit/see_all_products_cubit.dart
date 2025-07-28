import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../data/helpers/search_helper.dart';
import '../../../../../data/model/product_model.dart';

part 'see_all_products_state.dart';

class SeeAllProductsCubit extends Cubit<SeeAllProductsState> {
  SeeAllProductsCubit() : super(SeeAllProductsLoading());

  void showAllProducts(List<ProductModel> products) {
    emit(SeeAllProductsLoading());
    try {
      emit(SeeAllProductsLoaded(products));
    } catch (e) {
      emit(SeeAllProductsError(e.toString()));
    }
  }

  void searchProducts(String query, List<ProductModel> products) {
    emit(SeeAllProductsLoading());
    try {
      final results = SearchHelper.setSearchQuery(query, products);
      emit(SeeAllProductsSearch(results));
    } catch (e) {
      emit(SeeAllProductsError(e.toString()));
    }
  }
}
