part of 'order_details_screen_cubit.dart';

sealed class OrderDetailsScreenState extends Equatable {
  const OrderDetailsScreenState();

  @override
  List<Object> get props => [];
}

final class OrderDetailsScreenInitial extends OrderDetailsScreenState {}

final class UpdateOrderStatusLoading extends OrderDetailsScreenState {}

final class UpdateOrderPreparationTimeLoading extends OrderDetailsScreenState {}

final class DeleteOrderLoading extends OrderDetailsScreenState {}

final class UpdateOrderStatusSuccess extends OrderDetailsScreenState {
  final String message;
  const UpdateOrderStatusSuccess(this.message);
}

final class UpdateOrderPreparationTimeSuccess extends OrderDetailsScreenState {
  final String message;
  const UpdateOrderPreparationTimeSuccess(this.message);
}

final class DeleteOrderSuccess extends OrderDetailsScreenState {
  final String message;
  const DeleteOrderSuccess(this.message);
}

final class UpdateOrderStatusError extends OrderDetailsScreenState {
  final String message;
  const UpdateOrderStatusError(this.message);
}

final class UpdateOrderPreparationTimeError extends OrderDetailsScreenState {
  final String message;
  const UpdateOrderPreparationTimeError(this.message);
}

final class DeleteOrderError extends OrderDetailsScreenState {
  final String message;
  const DeleteOrderError(this.message);
}
