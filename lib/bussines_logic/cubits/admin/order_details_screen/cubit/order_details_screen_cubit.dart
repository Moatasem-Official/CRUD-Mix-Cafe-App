import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';

part 'order_details_screen_state.dart';

class OrderDetailsScreenCubit extends Cubit<OrderDetailsScreenState> {
  OrderDetailsScreenCubit() : super(OrderDetailsScreenInitial());

  FirestoreServices firestoreServices = FirestoreServices();

  void deleteOrder(String orderId, String userId) async {
    emit(OrderDetailsScreenLoading());
    try {
      await firestoreServices.deleteOrder(userId: userId, orderId: orderId);
    } catch (e) {
      emit(OrderDetailsScreenError(e.toString()));
    }
  }

  void updateOrderPreparationTime(
    String orderId,
    String userId,
    Duration preparationTime,
  ) async {
    emit(OrderDetailsScreenLoading());
    try {
      await firestoreServices.updateOrderPreparationTime(
        orderId: orderId,
        userId: userId,
        preparationTime: preparationTime,
      );
    } catch (e) {
      emit(OrderDetailsScreenError(e.toString()));
    }
  }

  void updateOrderStatus(String orderId, String userId, String status) async {
    emit(OrderDetailsScreenLoading());
    try {
      await firestoreServices.updateOrderStatus(
        orderId: orderId,
        userId: userId,
        status: status,
      );
    } catch (e) {
      emit(OrderDetailsScreenError(e.toString()));
    }
  }
}
