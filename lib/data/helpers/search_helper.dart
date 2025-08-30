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

  static String formatPreparedTime(String time) {
    final hour = time.split(':')[0];
    final minute = time.split(':')[1];
    return '$hour h  $minute min';
  }
}
