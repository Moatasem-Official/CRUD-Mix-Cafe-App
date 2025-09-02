part of 'orders_screen_cubit.dart';

sealed class OrdersScreenState extends Equatable {
  const OrdersScreenState();

  @override
  List<Object> get props => [];
}

final class OrdersScreenInitial extends OrdersScreenState {}

final class OrdersScreenLoading extends OrdersScreenState {}

final class ReorderLoading extends OrdersScreenState {}

final class ReorderSuccess extends OrdersScreenState {
  final String message;
  const ReorderSuccess(this.message);
}

final class ReorderError extends OrdersScreenState {
  final String message;
  const ReorderError(this.message);
}

final class ReoderedOrdersReachedToMaxTimes extends OrdersScreenState {
  final String message;
  const ReoderedOrdersReachedToMaxTimes(this.message);
}

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
