part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesLoading extends CategoriesState {}

final class EditProductLoading extends CategoriesState {}

final class DeleteProductLoading extends CategoriesState {}

final class AddProductLoading extends CategoriesState {}

final class EditProductSuccess extends CategoriesState {
  final String message;
  const EditProductSuccess(this.message);
}

final class DeleteProductSuccess extends CategoriesState {
  final String message;
  const DeleteProductSuccess(this.message);
}

final class AddProductSuccess extends CategoriesState {
  final String message;
  const AddProductSuccess(this.message);
}

final class EditProductError extends CategoriesState {
  final String errorMessage;
  const EditProductError(this.errorMessage);
}

final class DeleteProductError extends CategoriesState {
  final String errorMessage;
  const DeleteProductError(this.errorMessage);
}

final class AddProductError extends CategoriesState {
  final String errorMessage;
  const AddProductError(this.errorMessage);
}

final class CategoriesLoaded extends CategoriesState {
  final List<ProductModel> categories;
  const CategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

final class CategoriesError extends CategoriesState {
  final String errorMessage;
  const CategoriesError(this.errorMessage);
}

final class CategoriesEmpty extends CategoriesState {}

final class CategoriesNoInternet extends CategoriesState {}
