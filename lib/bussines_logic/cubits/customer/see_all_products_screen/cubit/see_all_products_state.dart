part of 'see_all_products_cubit.dart';

sealed class SeeAllProductsState extends Equatable {
  const SeeAllProductsState();

  @override
  List<Object> get props => [];
}

final class SeeAllProductsInitial extends SeeAllProductsState {}

final class SeeAllProductsLoading extends SeeAllProductsState {}

final class SeeAllProductsLoaded extends SeeAllProductsState {
  final List<ProductModel> products;
  const SeeAllProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class SeeAllProductsError extends SeeAllProductsState {
  final String message;
  const SeeAllProductsError(this.message);

  @override
  List<Object> get props => [message];
}

final class SeeAllProductsSearch extends SeeAllProductsState {
  final List<ProductModel> searchResults;
  const SeeAllProductsSearch(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}
