import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  final FirestoreServices _firestoreServices = FirestoreServices();

  Future<void> getProducts() async {
    emit(CategoriesLoading());
    try {
      final categories = await _firestoreServices.getProducts();
      if (categories.isEmpty) {
        emit(CategoriesEmpty());
      } else {
        emit(CategoriesLoaded(categories.cast<String>().toList()));
      }
    } catch (e) {
      emit(CategoriesError());
    }
  }
}
