import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../../data/model/product_model.dart';
import '../../../../../data/services/firestore/firestore_services.dart';

part 'cart_screen_state.dart';

class CartScreenCubit extends Cubit<CartScreenState> {
  CartScreenCubit() : super(CartScreenInitial());

  final FirestoreServices _firestoreServices = FirestoreServices();
  List<ProductModel> cartProducts = [];

  Future<void> addProductToCart(ProductModel product) async {
    emit(AddProductToCartLoading());
    try {
      await _firestoreServices.addProductToCart(
        product,
        FirebaseAuth.instance.currentUser!.uid,
      );
      cartProducts = await _firestoreServices.getCartProducts();

      emit(AddProductToCart('Product Added To Cart Successfully'));
    } catch (e) {
      emit(AddProductToCartError('Failed To Add Product To Cart'));
    }
  }

  Future<void> getCartProducts() async {
    emit(CartScreenLoading());
    try {
      cartProducts = await _firestoreServices.getCartProducts();
      emit(CartScreenSuccess(cartProducts));
    } catch (e) {
      emit(CartScreenError(e.toString()));
    }
  }

  Future<void> removeProductFromCart(String productId) async {
    emit(RemoveProductFromCartLoading());
    try {
      await _firestoreServices.removeProductFromCart(productId);
      emit(RemoveProductFromCart('Product Removed From Cart Successfully'));
      cartProducts = await _firestoreServices
          .getCartProducts(); // ✅ تحديث النسخة
      emit(CartScreenSuccess(cartProducts));
    } catch (e) {
      emit(RemoveProductFromCartError(e.toString()));
    }
  }

  Future<void> clearCart() async {
    emit(CartScreenLoading());
    try {
      await _firestoreServices.clearCart();
      cartProducts = await _firestoreServices
          .getCartProducts(); // ✅ تحديث النسخة
      emit(CartScreenSuccess(cartProducts));
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

    deliveryFee = (subTotalPrice * AppConstants.kDeliveryFee);
    totalPrice = subTotalPrice + deliveryFee;

    return [totalPrice, subTotalPrice, deliveryFee];
  }

  Future<void> onCustomerRequestOrder(
    String userId,
    List<double> prices,
    Map<String, int> productQuantities,
    List<ProductModel> products,
  ) async {
    emit(RequestOrderLoading());
    try {
      final orderRequestsTimes = await _firestoreServices
          .getCustomerOrdersPerDaySnapshot();

      if (orderRequestsTimes.docs.length >= 5) {
        emit(
          OrdersReachedToMaxTimes(
            'You Have Reached The Maximum Number Of Orders Per This Day.',
          ),
        );
        cartProducts = await _firestoreServices
            .getCartProducts(); // ✅ تحديث النسخة
        emit(CartScreenSuccess(cartProducts));
      } else {
        await _firestoreServices.addOrder(
          userId,
          double.parse(prices[0].toStringAsFixed(2)),
          products
              .map(
                (product) => {
                  'productId': product.id,
                  'orderItems': [
                    {
                      'quantity': productQuantities[product.id],
                      'price': product.hasDiscount
                          ? product.discountedPrice
                          : product.price,
                      'name': product.name,
                      'imageUrl': product.imageUrl,
                    },
                  ],
                },
              )
              .toList(),
        );

        emit(RequestOrderSuccess('Order Placed Successfully'));
        cartProducts = await _firestoreServices
            .getCartProducts(); // ✅ تحديث النسخة
        emit(CartScreenSuccess(cartProducts));
      }
    } catch (e) {
      if (e.toString().contains('pending order with the same items')) {
        emit(
          DuplicateOrder(
            'You Already Have A Pending Order With The Same Items.',
          ),
        );
        emit(CartScreenSuccess(await _firestoreServices.getCartProducts()));
      } else {
        emit(RequestOrderError('Failed To add Order: ${e.toString()}'));
      }
    }
  }

  Future<int> getCartProductsCount() async {
    final cartProducts = await _firestoreServices.getCartProducts();
    return cartProducts.length;
  }
}
