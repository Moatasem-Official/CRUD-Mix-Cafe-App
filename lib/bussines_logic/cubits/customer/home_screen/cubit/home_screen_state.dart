part of 'home_screen_cubit.dart';

sealed class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

final class HomeScreenLoading extends HomeScreenState {}

final class HomeScreenSuccess extends HomeScreenState {
  final List<ProductModel> products;
  const HomeScreenSuccess(this.products);

  @override
  List<Object> get props => [products];
}

final class HomeScreenError extends HomeScreenState {
  final String error;
  const HomeScreenError(this.error);

  @override
  List<Object> get props => [error];
}
