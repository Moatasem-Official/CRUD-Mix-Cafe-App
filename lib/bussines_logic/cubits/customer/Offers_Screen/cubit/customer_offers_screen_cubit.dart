import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../data/model/offer_model.dart';
import '../../../../../data/services/firestore/firestore_services.dart';

part 'customer_offers_screen_state.dart';

class CustomerOffersScreenCubit extends Cubit<CustomerOffersScreenState> {
  CustomerOffersScreenCubit() : super(CustomerOffersScreenInitial());

  final FirestoreServices _firestoreServices = FirestoreServices();
  final List<Offer> offersList = [];

  void getOffers() async {
    emit(CustomerOffersScreenLoading());
    try {
      final offers = await _firestoreServices.getAllOffers();
      offersList.addAll(offers);
      emit(CustomerOffersScreenSuccess(offers));
    } catch (e) {
      emit(CustomerOffersScreenError(e.toString()));
    }
  }
}
