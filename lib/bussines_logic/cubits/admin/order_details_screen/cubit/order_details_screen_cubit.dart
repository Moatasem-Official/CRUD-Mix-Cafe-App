import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../data/services/firestore/firestore_services.dart';

part 'order_details_screen_state.dart';

class OrderDetailsScreenCubit extends Cubit<OrderDetailsScreenState> {
  OrderDetailsScreenCubit() : super(OrderDetailsScreenInitial());

  FirestoreServices firestoreServices = FirestoreServices();

  void deleteOrder(String orderId, String userId) async {
    emit(DeleteOrderLoading());
    try {
      await firestoreServices.deleteOrder(userId: userId, orderId: orderId);
      emit(DeleteOrderSuccess('Order Deleted Successfully'));
      await firestoreServices.getAllOrders();
    } catch (e) {
      emit(DeleteOrderError('Failed To Delete Order'));
    }
  }

  void updateOrderPreparationTime(
    String orderId,
    String userId,
    Duration preparationTime,
  ) async {
    emit(UpdateOrderPreparationTimeLoading());
    try {
      await firestoreServices.updateOrderPreparationTime(
        orderId: orderId,
        userId: userId,
        preparationTime: preparationTime,
      );
      emit(
        UpdateOrderPreparationTimeSuccess(
          'Order Preparation Time Updated Successfully',
        ),
      );
      await firestoreServices.getAllOrders();
    } catch (e) {
      emit(
        UpdateOrderPreparationTimeError(
          'Failed To Update Order Preparation Time',
        ),
      );
    }
  }

  void updateOrderStatus(String orderId, String userId, String status) async {
    emit(UpdateOrderStatusLoading());
    try {
      await firestoreServices.updateOrderStatus(
        orderId: orderId,
        userId: userId,
        status: status,
      );
      emit(UpdateOrderStatusSuccess('Order Status Updated Successfully'));
      await firestoreServices.getAllOrders();
    } catch (e) {
      emit(UpdateOrderStatusError('Failed To Update Order Status'));
    }
  }
}
