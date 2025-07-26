import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mix_cafe_app/data/model/order_model.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';

part 'orders_screen_state.dart';

class OrdersScreenCubit extends Cubit<OrdersScreenState> {
  OrdersScreenCubit() : super(OrdersScreenLoading());
  final FirestoreServices _firestoreServices = FirestoreServices();
  Future<void> getOrders() async {
    emit(OrdersScreenLoading());
    try {
      final orders = await _firestoreServices.getAllOrders();
      emit(OrdersScreenSuccess(orders));
    } catch (e) {
      emit(OrdersScreenError(e.toString()));
    }
  }

  Future<void> deleteOrder(String orderId, String userId) async {
    emit(OrdersScreenLoading());
    try {
      await _firestoreServices.deleteOrder(orderId: orderId, userId: userId);
      emit(OrdersScreenSuccess(await _firestoreServices.getAllOrders()));
    } catch (e) {
      emit(OrdersScreenError(e.toString()));
    }
  }

  Future<void> filterOrdersByStatus(String? userId, String status) async {
    emit(OrdersScreenLoading());
    try {
      final orders = await _firestoreServices.getOrdersByStatus(status);
      emit(OrdersScreenFilterOrders(orders));
    } catch (e) {
      emit(OrdersScreenError(e.toString()));
    }
  }
}
