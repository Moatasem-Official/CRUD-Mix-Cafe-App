part of 'offers_screen_cubit.dart';

sealed class OffersScreenState extends Equatable {
  const OffersScreenState();

  @override
  List<Object> get props => [];
}

final class OffersScreenInitial extends OffersScreenState {}

final class OffersScreenLoading extends OffersScreenState {}

final class OffersScreenSuccess extends OffersScreenState {
  final List<Offer> offers;
  const OffersScreenSuccess({required this.offers});
}

final class OffersScreenError extends OffersScreenState {
  final String message;
  const OffersScreenError(this.message);
}
