part of 'orders_screen_cubit.dart';

sealed class OrdersScreenState extends Equatable {
  const OrdersScreenState();

  @override
  List<Object> get props => [];
}

final class OrdersScreenInitial extends OrdersScreenState {}

final class OrdersScreenLoading extends OrdersScreenState {}

final class OrdersScreenSuccess extends OrdersScreenState {
  final List<OrderModel> orders;
  const OrdersScreenSuccess(this.orders);
}

final class OrdersScreenError extends OrdersScreenState {
  final String message;
  const OrdersScreenError(this.message);
}

final class OrdersScreenEmpty extends OrdersScreenState {}

final class OrdersScreenNoInternet extends OrdersScreenState {}

final class OrdersScreenFilterOrders extends OrdersScreenState {
  final List<OrderModel> orders;
  const OrdersScreenFilterOrders(this.orders);
}
