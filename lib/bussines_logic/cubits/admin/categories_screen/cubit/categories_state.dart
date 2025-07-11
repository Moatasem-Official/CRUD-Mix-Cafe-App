part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesLoaded extends CategoriesState {
  final List<ProductModel> categories;
  const CategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

final class CategoriesError extends CategoriesState {}

final class CategoriesEmpty extends CategoriesState {}

final class CategoriesNoInternet extends CategoriesState {}
