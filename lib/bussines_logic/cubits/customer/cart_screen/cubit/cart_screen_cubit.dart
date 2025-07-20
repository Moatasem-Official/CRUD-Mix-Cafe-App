import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';

part 'cart_screen_state.dart';

class CartScreenCubit extends Cubit<CartScreenState> {
  CartScreenCubit() : super(CartScreenInitial());

  final FirestoreServices _firestoreServices = FirestoreServices();

  Future<void> getCartProducts() async {
    emit(CartScreenLoading());
    try {
      final cartProducts = await _firestoreServices.getCartProducts();
      emit(CartScreenSuccess(cartProducts));
    } catch (e) {
      emit(CartScreenError(e.toString()));
    }
  }

  Future<void> removeProductFromCart(String productId) async {
    emit(CartScreenLoading());
    try {
      await _firestoreServices.removeProductFromCart(productId);
      emit(CartScreenSuccess(await _firestoreServices.getCartProducts()));
    } catch (e) {
      emit(CartScreenError(e.toString()));
    }
  }

  Future<void> clearCart() async {
    emit(CartScreenLoading());
    try {
      await _firestoreServices.clearCart();
      emit(CartScreenSuccess(await _firestoreServices.getCartProducts()));
    } catch (e) {
      emit(CartScreenError(e.toString()));
    }
  }

  List<double> calculateTotalPrice(
    List<ProductModel> products,
    Map<String, int> quantities,
  ) {
    double subTotalPrice = 0;
    double deliveryFee = 0;
    double totalPrice = 0;

    for (var product in products) {
      final quantity = quantities[product.id] ?? 1;

      if (product.hasDiscount) {
        subTotalPrice += (product.discountedPrice * quantity);
      } else {
        subTotalPrice += (product.price * quantity);
      }
    }

    deliveryFee = (subTotalPrice * 0.1);
    totalPrice = subTotalPrice + deliveryFee;

    return [totalPrice, subTotalPrice, deliveryFee];
  }
}
