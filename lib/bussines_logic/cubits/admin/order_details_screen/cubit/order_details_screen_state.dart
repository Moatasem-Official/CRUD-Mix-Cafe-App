part of 'order_details_screen_cubit.dart';

sealed class OrderDetailsScreenState extends Equatable {
  const OrderDetailsScreenState();

  @override
  List<Object> get props => [];
}

final class OrderDetailsScreenInitial extends OrderDetailsScreenState {}

final class OrderDetailsScreenLoading extends OrderDetailsScreenState {}

final class OrderDetailsScreenError extends OrderDetailsScreenState {
  final String message;
  const OrderDetailsScreenError(this.message);
}
