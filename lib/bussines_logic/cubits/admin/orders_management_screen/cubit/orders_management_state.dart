part of 'orders_management_cubit.dart';

sealed class OrdersManagementState extends Equatable {
  const OrdersManagementState();

  @override
  List<Object> get props => [];
}

final class OrdersManagementInitial extends OrdersManagementState {}

final class OrdersManagementLoading extends OrdersManagementState {}

final class OrdersManagementLoaded extends OrdersManagementState {
  final List<OrderModel> orders;
  const OrdersManagementLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

final class OrdersManagementError extends OrdersManagementState {
  final String message;
  const OrdersManagementError(this.message);
}

final class OrdersManagementFilter extends OrdersManagementState {
  final List<OrderModel> orders;
  const OrdersManagementFilter(this.orders);

  @override
  List<Object> get props => [orders];
}
