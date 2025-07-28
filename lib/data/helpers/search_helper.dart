import '../model/product_model.dart';

class SearchHelper {
  static List<ProductModel> setSearchQuery(
    String query,
    List<ProductModel> products,
  ) {
    if (query.isEmpty) {
      return products;
    }

    return products.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
