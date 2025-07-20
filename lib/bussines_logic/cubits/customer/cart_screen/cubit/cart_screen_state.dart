part of 'cart_screen_cubit.dart';

sealed class CartScreenState extends Equatable {
  const CartScreenState();

  @override
  List<Object> get props => [];
}

final class CartScreenInitial extends CartScreenState {}

final class CartScreenLoading extends CartScreenState {}

final class CartScreenError extends CartScreenState {
  final String error;
  const CartScreenError(this.error);

  @override
  List<Object> get props => [error];
}

final class CartScreenSuccess extends CartScreenState {
  final List<ProductModel> products;
  const CartScreenSuccess(this.products);

  @override
  List<Object> get props => [products];
}
