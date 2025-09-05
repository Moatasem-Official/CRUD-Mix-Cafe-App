import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../data/model/order_model.dart';
import '../../../../../data/services/firestore/firestore_services.dart';

part 'orders_screen_state.dart';

class OrdersScreenCubit extends Cubit<OrdersScreenState> {
  OrdersScreenCubit() : super(OrdersScreenLoading());
  final FirestoreServices _firestoreServices = FirestoreServices();
  String _currentFilter = 'all';
  Future<void> getOrders() async {
    emit(OrdersScreenLoading());
    _currentFilter = 'all';
    try {
      final orders = await _firestoreServices.getAllOrders();
      emit(OrdersScreenSuccess(orders));
    } catch (e) {
      emit(OrdersScreenError(e.toString()));
    }
  }

  Future<void> cancelOrder(String orderId, String userId) async {
    emit(CancelOrderLoading());
    try {
      await _firestoreServices.customerCancelOrder(
        orderId: orderId,
        userId: userId,
      );
      emit(CancelOrderSuccess('Order Cancelled Successfully'));
      if (_currentFilter == 'all') {
        emit(OrdersScreenSuccess(await _firestoreServices.getAllOrders()));
      } else {
        emit(
          OrdersScreenFilterOrders(
            await _firestoreServices.getOrdersByStatus(_currentFilter),
          ),
        );
      }
    } catch (e) {
      emit(CancelOrderError('Failed To Cancel Order'));
    }
  }

  Future<void> filterOrdersByStatus(String? userId, String status) async {
    emit(OrdersScreenLoading());
    _currentFilter = status;
    try {
      final orders = status == 'all'
          ? await _firestoreServices.getAllOrders()
          : await _firestoreServices.getOrdersByStatus(status);
      emit(OrdersScreenFilterOrders(orders));
    } catch (e) {
      emit(OrdersScreenError(e.toString()));
    }
  }

  Future<void> reOrder(String orderId, String userId) async {
    emit(ReorderLoading());
    try {
      final orderRequestsTimes = await _firestoreServices
          .getCustomerOrdersPerDaySnapshot();

      if (orderRequestsTimes.docs.length >= 5) {
        emit(
          ReoderedOrdersReachedToMaxTimes(
            'You Have Reached The Maximum Number Of Orders Per This Day.',
          ),
        );
        if (_currentFilter == 'all') {
          emit(OrdersScreenSuccess(await _firestoreServices.getAllOrders()));
        } else {
          emit(
            OrdersScreenFilterOrders(
              await _firestoreServices.getOrdersByStatus(_currentFilter),
            ),
          );
        }
        return;
      }
      await _firestoreServices.reOrder(orderId: orderId, userId: userId);
      emit(ReorderSuccess('Order Reordered Successfully'));
      if (_currentFilter == 'all') {
        emit(OrdersScreenSuccess(await _firestoreServices.getAllOrders()));
      } else {
        emit(
          OrdersScreenFilterOrders(
            await _firestoreServices.getOrdersByStatus(_currentFilter),
          ),
        );
      }
    } catch (e) {
      emit(ReorderError('Failed To Reorder Order'));
      emit(OrdersScreenSuccess(await _firestoreServices.getAllOrders()));
    }
  }
}
