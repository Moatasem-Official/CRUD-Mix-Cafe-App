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

final class AddProductToCart extends CartScreenState {
  final String message;
  const AddProductToCart(this.message);
}

final class AddProductToCartError extends CartScreenState {
  final String message;
  const AddProductToCartError(this.message);
}

final class AddProductToCartLoading extends CartScreenState {}

final class RemoveProductFromCart extends CartScreenState {
  final String message;
  const RemoveProductFromCart(this.message);
}

final class ClearCart extends CartScreenState {
  final String message;
  const ClearCart(this.message);
}

final class OrdersReachedToMaxTimes extends CartScreenState {
  final String message;
  const OrdersReachedToMaxTimes(this.message);
}

final class RequestOrderSuccess extends CartScreenState {
  final String message;
  const RequestOrderSuccess(this.message);
}

final class RequestOrderError extends CartScreenState {
  final String message;
  const RequestOrderError(this.message);
}

final class DuplicateOrder extends CartScreenState {
  final String message;
  const DuplicateOrder(this.message);
}

final class RequestOrderLoading extends CartScreenState {}
