part of 'customer_offers_screen_cubit.dart';

sealed class CustomerOffersScreenState extends Equatable {
  const CustomerOffersScreenState();

  @override
  List<Object> get props => [];
}

final class CustomerOffersScreenInitial extends CustomerOffersScreenState {}

final class CustomerOffersScreenLoading extends CustomerOffersScreenState {}

final class CustomerOffersScreenSuccess extends CustomerOffersScreenState {
  final List<Offer> offers;
  const CustomerOffersScreenSuccess(this.offers);
}

final class CustomerOffersScreenError extends CustomerOffersScreenState {
  final String message;
  const CustomerOffersScreenError(this.message);

  @override
  List<Object> get props => [message];
}
