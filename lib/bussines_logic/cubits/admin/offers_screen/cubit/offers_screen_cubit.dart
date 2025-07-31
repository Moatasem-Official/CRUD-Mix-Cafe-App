import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mix_cafe_app/data/model/offer_model.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';

part 'offers_screen_state.dart';

class OffersScreenCubit extends Cubit<OffersScreenState> {
  OffersScreenCubit() : super(OffersScreenInitial());
  final _firestoreServices = FirestoreServices();

  Future<void> getOffers() async {
    emit(OffersScreenLoading());
    try {
      final offers = await _firestoreServices.getAllOffers();
      emit(OffersScreenSuccess(offers: offers));
    } catch (e) {
      emit(OffersScreenError(e.toString()));
    }
  }

  Future<void> deleteOffer(String offerId) async {
    emit(OffersScreenLoading());
    try {
      await _firestoreServices.deleteOffer(offerId);
    } catch (e) {
      emit(OffersScreenError(e.toString()));
    }
  }

  Future<void> updateOffer(Offer offer) async {
    emit(OffersScreenLoading());
    try {
      await _firestoreServices.updateOffer(offer);
    } catch (e) {
      emit(OffersScreenError(e.toString()));
    }
  }

  Future<void> addOffer({required Offer offer}) async {
    emit(OffersScreenLoading());
    try {
      await _firestoreServices.addOffer(offer: offer);
    } catch (e) {
      emit(OffersScreenError(e.toString()));
    }
  }
}
